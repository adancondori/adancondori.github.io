---
layout: post
last_modified_at: 2026-06-21T00:00:00-07:00
redirect_from:
  - "/payments,/stripe,paypal/Integration-with-Multiple-Payment-Gateways/"
lang: en
title: 📝 Integration with Multiple Payment Gateways
modified:
categories: Payments, Stripe, PayPal
article_section:
  - Payments
  - Stripe
  - PayPal
excerpt: >
  How I architect Stripe and PayPal in the same codebase without one bleeding into the other — abstraction layers, fallback strategies, and the gateway-specific quirks that ruin clean architecture.
tldr: >
  Integrating Stripe and PayPal in the same codebase usually starts clean and ends in a giant if-else. After doing this in production multiple times, I use a thin Gateway Adapter layer that hides PSP-specific quirks behind a common interface, plus a Capability Registry that lets the router pick the right gateway per transaction instead of forcing a lowest-common-denominator. This post walks through both layers and the patterns I'd defend in any architecture review.
faq:
  - q: "How do you abstract Stripe and PayPal behind a common interface?"
    a: "Define a thin GatewayAdapter interface with three core operations - authorize, capture, refund. Each PSP gets its own adapter that translates the common interface into PSP-specific calls. Don't expose PSP types up the stack - the business logic should never know whether Stripe or PayPal handled the transaction."
  - q: "What is a Capability Registry and why do you need one with multiple gateways?"
    a: "A Capability Registry is a config-driven table that describes what each gateway can do: which payment methods, which currencies, which countries, whether it supports 3DS 2.0, partial captures, recurring, etc. The payment router queries the registry to decide which gateway is eligible for each transaction, instead of forcing all gateways to support the same lowest-common-denominator feature set."
  - q: "How do you handle fallback when the primary gateway fails?"
    a: "Two strategies - automatic retry with the next-eligible gateway from the Capability Registry for transient PSP outages, or explicit fallback chains configured per route when business rules require a specific order. Both require idempotency keys so the failed attempt does not double-charge."
  - q: "Should the frontend know which gateway is being used?"
    a: "No. The frontend should send a payment intent (amount, currency, method) and let the backend route it. The only exception is when a PSP requires hosted UI like PayPal Smart Buttons or Stripe Checkout. In that case the backend returns a redirect or iframe instruction without leaking which PSP is behind it."
tags: []
image:
feature:
date: 2025-01-25T08:12:53-07:00


---

## 📝 **Integración con Múltiples Pasarelas de Pago**

En el mundo del software como servicio (SaaS) y el comercio electrónico, procesar pagos de forma fiable y flexible no es solo una necesidad técnica: es el corazón del negocio.

En mis más de 10 años como ingeniero de software, he liderado la integración de pasarelas de pago globales como **Stripe**, **PayPal** y **RazorPay**, así como regionales como **BAC**, **HDLeon**, **PayFast** y otras. En todos estos proyectos, aprendí una verdad fundamental:

> ✅ *El verdadero reto no es conectar una API, sino diseñar una arquitectura que te permita agregar o reemplazar una pasarela sin romper nada ni duplicar esfuerzo.*

Hoy quiero compartir una guía práctica con estrategias, patrones y ejemplos reales que te permitirán construir un sistema de pagos modular, extensible y fácil de mantener.

---

### 🧩 1. Desafíos Comunes al Integrar Pasarelas

🔍 Aunque las pasarelas de pago comparten propósito, cada una tiene sus propias reglas, flujos y APIs. Algunos desafíos típicos:

* **APIs heterogéneas:** Lo que en Stripe es un `PaymentIntent`, en otros casos es una combinación de `token + confirmación`. La semántica cambia.
* **Errores y asincronía:** Cada proveedor maneja códigos de error y callbacks (como 3D Secure, OXXO o QR) de forma distinta.
* **Mantenimiento y sandbox:** Integrar múltiples entornos de prueba es engorroso, y los cambios en producción de una pasarela pueden romper el flujo si no tienes una arquitectura robusta.

---

### 🧱 2. Principios de Arquitectura Aplicados

La clave para escalar sin caos es diseñar pensando en el cambio. Estos son los principios que aplicamos con éxito:

* **Open/Closed Principle:** Nuestro motor de pagos está abierto a extensiones (nuevas pasarelas), pero cerrado a modificaciones.
* **Separación de responsabilidades:** La lógica de negocio no sabe nada de las APIs externas. Todo lo maneja un adaptador.
* **Contrato común:** Usamos una clase base (`PaymentService::Gateway::Base`) que obliga a cada pasarela a implementar el método `call`.

```ruby
class PaymentService::Gateway::Base
  include Interactor

  def call
    raise NotImplementedError
  end
end
```

---

### 🧠 3. Patrón de Estrategia para Selección Dinámica

Cuando un usuario realiza un pago, nuestro sistema selecciona automáticamente la pasarela adecuada basándose en la configuración de su empresa (`empresa`).

```ruby
def payment_gateway
  "#{gateway_namespace}::#{gateway_name}::#{action_name}".constantize
end
```

Ejemplo real:

* Llamas a `PaymentService::Sale.call(...)`
* Si la `empresa` usa Stripe, se ejecuta `PaymentService::Gateway::Stripe::Sale.call(...)`
* Si usa BAC, se ejecuta `PaymentService::Gateway::BAC::Sale.call(...)`

Esto nos permite escalar sin tocar el core.

---

### 🪝 4. Webhooks: La Parte Más Crítica

Procesar webhooks de manera segura y ordenada es indispensable:

* Verificamos firmas con HMAC o JWT
* Usamos un `WebhookProcessor` que delega según el proveedor
* Manejamos idempotencia para evitar duplicados
* Cada pasarela tiene su handler: `Webhooks::StripeHandler`, `Webhooks::MERUHandler`, etc.

---

### 🧪 5. Pruebas y CI/CD

Las pruebas en sistemas de pago son complejas, pero posibles:

* **Unitarias:** Mockeamos respuestas de APIs externas para validar la lógica interna.
* **Por contrato:** Validamos que las firmas, campos obligatorios y flujos 3DS sigan siendo consistentes.
* **Flujo completo:** Simulamos reservas o ventas completas que requieren callbacks o redirecciones.

Además, evitamos ambientes sandbox inconsistentes usando registros grabados (`VCR`, `WebMock`).

---

### 🚀 6. Caso Real: Integración con PayFast

Integrar **PayFast**, un gateway popular en Sudáfrica, tomó menos de 2 semanas gracias a esta arquitectura:

1. Creamos `PaymentService::Gateway::PayFast::Sale`
2. Implementamos el handler de webhooks
3. Configuramos la `empresa` para usar PayFast
4. Sin modificar una línea del core

---

### 📊 7. Impacto Real en el Negocio

Esta arquitectura nos permitió:

✅ Entrar rápidamente a nuevos países <br>
✅ Ofrecer más opciones al usuario final <br>
✅ Cambiar o eliminar pasarelas obsoletas sin fricción<br>
✅ Ahorrar cientos de horas en mantenimiento<br>
✅ Minimizar errores humanos en integraciones sensibles<br>

---

### 🧭 8. Reflexión Final

Invertir en una arquitectura de pagos limpia es una decisión estratégica. En lugar de reescribir todo con cada nuevo proveedor, construyes una base sólida para el futuro.

Si estás por integrar tu segunda o tercera pasarela, ¡detente y piensa en la arquitectura! Vale más hacerlo bien una vez que mal diez veces.
