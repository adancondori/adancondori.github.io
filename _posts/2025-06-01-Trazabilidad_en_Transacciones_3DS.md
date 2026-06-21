---
layout: post
last_modified_at: 2026-06-21T00:00:00-07:00
redirect_from:
  - "/3ds/card/payments/Trazabilidad_en_Transacciones_3DS/"
lang: es
title: 🛡️🔒 Seguridad y Trazabilidad en Transacciones de Pagos 🔍💳
modified:
categories: [3DS, Card, Payments]
article_section:
  - 3DS
  - Card
  - Payments
excerpt: >
  Descubre cómo diseñamos una arquitectura robusta para trazabilidad de pagos 3DS en sistemas distribuidos. De la incertidumbre al diagnóstico preciso.
tldr: >
  La mayoría de implementaciones 3DS son cajas negras cuando fallan en producción. Después de varias rondas de debugging a ciegas, monté una arquitectura de trazabilidad basada en structured logging con correlation ID por intent, persistencia del payload crudo de ACS, métricas por step del protocolo (fingerprinting, challenge, result), y dashboards que cruzan los tres. Este post es esa arquitectura - código Ruby/Rails incluido y los queries de Datadog/New Relic que uso para diagnosticar 3DS rotos.
tags: [3DS, Payments, Ruby on Rails, Logging, Observability]
faq:
  - q: "¿Por qué los pagos 3DS son tan difíciles de debuggear en producción?"
    a: "Porque el protocolo cruza 4-5 sistemas (tu app, PSP, ACS del issuer, DS de la red, Schemes). Si algo falla y solo tienes los logs de tu app, ves authentication failed sin contexto. Sin persistir el payload crudo de cada request/response al ACS y sin correlation ID que ate todos los hops, estás adivinando."
  - q: "¿Qué nivel de logging es seguro para 3DS sin violar PCI-DSS?"
    a: "Puedes loggear todo el payload de cardholder authentication EXCEPTO el PAN completo (primary account number) y el CVV. Los últimos 4 dígitos, BIN, expiration year-only, cardholder name pueden estar en logs. Cualquier identificador de transacción de PSP/ACS es seguro y crítico para correlation. Si tu logging incluye PAN completo automáticamente subes a SAQ-D y multiplicas tu costo de compliance."
  - q: "¿Qué correlation ID debes propagar a través del flujo 3DS?"
    a: "Mínimo dos - un internal correlation_id que tu app genera al crear el payment intent y propaga por todos sus logs, y el threeDSServerTransID que devuelve el ACS persistido en tu DB junto al intent. Cualquier query de soporte o auditoría empieza con uno de estos dos. Sin ellos atar el log de tu app al log del PSP al log del ACS es trabajo manual de horas."
  - q: "¿Qué métricas de 3DS debes monitorear en producción?"
    a: "Cuatro críticas - frictionless rate como porcentaje de intents que pasan sin challenge, challenge completion rate como porcentaje de challenges iniciados que el cliente termina, authentication success rate post-challenge, y latency por step del protocolo (fingerprinting menor a 3s, challenge menor a 30s). Alertas en cualquiera de estas debajo del baseline detecta problemas antes de que afecten conversion."
image:
feature:
date: 2025-6-24T08:12:53-07:00
---

## 🧵 El Hilo Invisible: Trazabilidad en el Caos Distribuido

> _“El pago falló.”_
Tres palabras que pueden parecer simples, pero en el contexto de un sistema distribuido, suenan como una alarma en medio de la noche. Para nosotros, los desarrolladores, no son solo un error: son el inicio de una búsqueda a través de múltiples servicios, servidores y eventos asincrónicos que, muchas veces, no hablan entre sí.

En plataformas que procesan miles de transacciones por minuto, los logs tradicionales no son la solución. Son parte del problema. Por eso, en este artículo quiero compartir contigo una estrategia real y probada, que convierte el caos en claridad: **trazabilidad de punta a punta** en flujos de pago con 3DS.

---

## 🔥 El Problema: Diagnóstico en la Oscuridad

Imagina este flujo típico de una transacción:

1. El usuario hace clic en **"Pagar"**.
2. La petición llega al backend (por ejemplo, en el `servidor-03`).
3. Se ejecuta la lógica que interactúa con la **pasarela de pago**.
4. Unos minutos después, llega un **webhook** a otro servidor (`servidor-08`).
5. Ese webhook dispara un **WebSocket** para actualizar al usuario en tiempo real.

Ahora... algo falla. ¿Dónde está el error? ¿Se cayó el webhook? ¿La pasarela no respondió? ¿El socket nunca se emitió?

Peor aún: el equipo comercial solo te da el correo del usuario y te dice *"revisá por qué no le llegó el cobro"*. Sin trazabilidad, estás buscando una aguja en un pajar.

---

## 🧠 La Solución: `trace_id`, Nuestro Hilo de Ariadna

Para unir todos los puntos de ese flujo, necesitas un **ID de correlación**. Ese `trace_id` nace al inicio de la solicitud y vive durante todo el recorrido, de extremo a extremo.

Con él:

- Tienes **contexto compartido** entre servicios.
- Puedes **reconstruir el flujo completo** en herramientas como Kibana o Datadog.
- Evitas depender de logs desordenados y fragmentados.

---

## 🛠️ Cómo lo Implementamos

### 1. `CurrentAttributes`: Contexto Seguro y Limpio

Usamos `ActiveSupport::CurrentAttributes` para mantener el `trace_id` accesible, sin tener que pasarlo como parámetro entre métodos. Un middleware o filtro en el controlador base hace lo siguiente:

- Revisa si el header de la petición ya trae un `trace_id`.
- Si no existe, genera un `UUID` nuevo y lo guarda como contexto global.

Esto asegura que cada flujo tenga un identificador único y consistente.

---

### 2. Módulo de Logging Reutilizable

Creamos un módulo (`PaymentLogger`, por ejemplo) con un solo método:
```ruby
log_payment_event(tag:, data:)
````

Este método:

* Enriquecer automáticamente cada log con:

  * `trace_id`
  * `timestamp`
  * `hostname`
  * Datos del usuario (si están disponibles)
* Formatea los logs como JSON estructurado.
* Ofusca datos sensibles como tarjetas, emails, tokens, etc.

De esta forma, el logging no es una tarea, sino una característica clave del sistema.

---

### 3. Instrumentación Estratégica

Aplicamos `log_payment_event` en los puntos críticos del flujo, ejemplos en ruby on rails:

#### 🟢 Inicio (API Controller)

```ruby
log_payment_event(tag: 'payment_flow.started', data: { params: request.params })
```

#### 🔁 Interacción con Pasarela (Service Layer)

```ruby
log_payment_event(tag: 'payment_gateway.request', data: { gateway_params: ... })
log_payment_event(tag: 'payment_gateway.response', data: { response: ..., status: 'success' })
```

#### 📩 Webhook (Confirmación Asíncrona)

* Extraemos el `order_id` del webhook.
* Lo usamos para setear nuevamente el `trace_id`.

```ruby
log_payment_event(tag: 'webhook.received', data: { payload: ... })
```

#### 📡 WebSocket (Notificación al Usuario)

```ruby
log_payment_event(tag: 'socket.emitted', data: { channel: ..., event: ... })
```

---

## 🔍 Resultado: Diagnóstico en Tiempo Real

Cuando alguien del equipo de soporte te da un `user_id`, simplemente haces esto:

1. **Buscas el `user_id` en Kibana:**
   `json.context.user_id: "12345"`

2. **Extraes el `trace_id`:**
   `"uuid-abc-123"`

3. **Rastreás todo el flujo:**
   `json.trace_id: "uuid-abc-123"`

Y así obtienes toda la historia: solicitud, respuesta, webhook, socket… todo en orden y con contexto.

---

## 🎯 Conclusión: Trazabilidad es Confiabilidad

Diseñar un sistema de trazabilidad no es un lujo, es un requisito. En plataformas de pagos con 3DS, donde los errores pueden costar dinero (y reputación), no tener visibilidad es inaceptable.

Con un enfoque basado en `trace_id`, logs estructurados y contexto compartido, transformamos un sistema opaco en una máquina transparente, confiable y lista para escalar.

> *La próxima vez que leas “el pago falló”, no sentirás pánico. Tendrás el mapa.*

---
