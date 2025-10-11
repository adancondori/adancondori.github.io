---
layout: post
title: Guardia del Sprint - el escudo invisible del equipo de desarrollo
modified:
categories: Agile, DevOps, Engineering
excerpt: >
  El rol que protege al equipo, estabiliza el producto y mantiene la cordura en medio del caos
tags: []
image:
feature:
date: 2025-10-10T08:12:53-07:00
---

## Introducción: Cuando el mundo arde y alguien tiene que sostener el fuego

En un equipo de desarrollo ágil, siempre hay una persona que detiene el fuego mientras el resto sigue construyendo.

Esa persona eres tú. O lo serás pronto.

En mis más de 10 años como ingeniero de software, he sido guardia del sprint decenas de veces, y también he liderado equipos donde implementamos este rol de forma estructurada. No es el trabajo más glamoroso, pero es **el más crítico para la estabilidad del producto y la salud mental del equipo**.

> ✅ *El guardia del sprint no apaga incendios: los previene, los canaliza y documenta para que no vuelvan a ocurrir.*

Este artículo es una guía práctica, honesta y técnica sobre qué es ser guardia del sprint (o **triage engineer**), por qué importa tanto, y cómo implementarlo sin morir en el intento.

---

## 1. ¿Qué diablos es un Guardia del Sprint?

Déjame ser claro desde el inicio:

**El guardia del sprint es la persona designada para atender incidentes, errores y bugs de baja/media complejidad durante un periodo determinado (generalmente una semana o un sprint completo), garantizando la continuidad operativa del sistema y la eficiencia del equipo.**

En otras palabras:

* 🚨 **Eres el firewall humano** que intercepta interrupciones antes de que lleguen al resto del equipo
* 🔍 **Clasificas, priorizas y atiendes** reportes de producción
* 🩹 **Resuelves lo urgente** sin romper el flujo del sprint
* 📋 **Documentas y escala** lo que requiere más trabajo

---

## 2. ¿Por qué necesitas este rol?

Si alguna vez has estado en un sprint donde:

* El equipo es interrumpido 15 veces al día por bugs menores
* Los reportes de producción quedan sin atender durante días
* Nadie sabe quién debe responder al mensaje de "el pago falló"
* El tech lead está debuggeando en producción mientras debería estar en planning

**Necesitas un guardia del sprint.**

Este rol existe para resolver problemas estructurales:

| Problema | Solución con Guardia |
|----------|---------------------|
| Interrupciones constantes | El guardia absorbe todas las alertas |
| Bugs sin priorizar | Clasifica (triage) según urgencia |
| Tiempo de resolución alto | Respuesta inmediata a incidentes |
| Caos en producción | Un solo punto de contacto claro |
| Sprint con scope creep | El backlog del sprint se protege |

---

## 3. Responsabilidades del Guardia (lo que realmente haces)

Déjame ser específico, porque este rol no es solo "estar disponible":

### Incidentes en producción
* Monitorear dashboards (Datadog, New Relic, Sentry, Honeybadger)
* Responder a alertas críticas en menos de 5 minutos
* Analizar logs y tracebacks
* Ejecutar rollbacks temporales si es necesario
* Coordinar con DevOps/SRE para problemas de infra

**Ejemplo real:**
```ruby
# Detectas un timeout en Stripe Webhooks
# Logs revelan que un job de Sidekiq está bloqueando la cola

# Acción inmediata:
SomeHeavyJob.cancel_all # Liberas la cola
Bugsnag.notify("Stripe webhooks blocked by job X") # Notificas
# Creas ticket en Jira para refactorizar el job
```

### Bugs simples (1-3 horas)
* Correcciones menores que no requieren diseño
* Typos en mensajes, validaciones faltantes
* Problemas de permisos o configuración

**Ejemplo:**
```javascript
// Usuario reporta: "No puedo editar mi perfil"
// El guardia detecta:

if (user.role !== 'admin') { // ❌ Lógica incorrecta
  return false
}

// Fix en 20 minutos:
if (!user.can_edit_profile) { // ✅ Usa permisos reales
  return false
}
```

### Soporte interno
* Responder dudas técnicas del equipo de soporte
* Ayudar a QA a reproducir bugs complejos
* Validar configuraciones con producto

### Mantenimiento menor
* Limpiar jobs fallidos en Sidekiq/Resque
* Reiniciar workers bloqueados
* Revisar métricas y uso de recursos
* Verificar que los cronjobs estén corriendo

### Documentación crítica
* Registrar cada incidente en Jira/Linear/Notion
* Crear runbooks para problemas recurrentes
* Actualizar el wiki técnico con lecciones aprendidas

---

## 4. Duración y Rotación del Rol

La duración y rotación del guardia **depende completamente del equipo y la cultura de la empresa**. No hay una regla única, pero estas son las modalidades más comunes:

### Rotación Semanal (la más común)
* **Lunes a viernes:** Una persona es guardia
* **Siguiente semana:** Rota a otro miembro del equipo
* **Ventaja:** Nadie se quema, el conocimiento se distribuye rápidamente

### Rotación por Sprint Completo
* Una persona toma el rol durante todo el sprint (1-2 semanas)
* **Ventaja:** Mayor continuidad en el seguimiento de incidentes
* **Desventaja:** Puede ser más agotador para quien lo hace

### Rotación Diaria
* Equipos grandes rotan día a día
* **Ventaja:** Menor carga individual
* **Desventaja:** Menos continuidad en el seguimiento

### Rotación por Tamaño de Equipo
* **Equipos pequeños (2-4 devs):** Por sprint completo
* **Equipos medianos (5-8 devs):** Semanal
* **Equipos grandes (9+ devs):** Pueden rotar cada 2-3 días o tener dos guardias simultáneos

**Ventajas de rotar (independiente del periodo):**
* Todo el equipo conoce el sistema end-to-end
* Se comparte el conocimiento de producción
* Nadie se quema haciendo solo esto
* Fortalece la empatía y responsabilidad compartida

**Pro tip:** Si tu equipo tiene on-call 24/7, combina este rol con guardias fuera de horario (pagadas y rotativas).

---

## 5. Soft Skills: Lo que realmente te hace un buen Guardia

Ser guardia del sprint **no es solo técnica**. De hecho, las soft skills pueden ser más importantes que saber debuggear. Aquí están las habilidades clave:

### Comunicación clara y proactiva

**Lo que NO debes hacer:**
```
❌ "No sé qué pasa, lo veo después"
❌ *Silencio por 2 horas mientras investigas*
❌ "Está roto, no tengo idea de cómo arreglarlo"
```

**Lo que SÍ debes hacer:**
```
✅ "Recibido, estoy investigando. Les actualizo en 15 minutos"
✅ "Reproduje el bug. Voy a revisar los logs de Stripe"
✅ "Este flujo es complejo, voy a pedir ayuda a @juan que lo implementó"
```

### Saber pedir ayuda (sin miedo ni ego)

**Cuándo pedir ayuda:**
* Después de 20-30 minutos sin avance claro
* Cuando el incidente es crítico y no tienes contexto
* Cuando involucra un flujo que nunca has tocado
* Cuando la solución requiere decisiones de arquitectura

**Cómo pedir ayuda correctamente:**

**❌ MAL:**
```
"@tech-lead ayuda, esto no funciona"
```

**✅ BIEN:**
```
"@juan necesito ayuda con el flujo de pagos 3DS

Contexto:
- Usuario no puede completar pago con Visa
- Error: 'authentication_required' desde Stripe
- Ya revisé: logs, webhook handler, job de confirmación

Lo que intenté:
1. Reinicié el job manualmente → mismo error
2. Probé con otra tarjeta → funciona
3. Revisé docs de Stripe → menciona 3DS v2

¿Podrías revisar si el flujo 3DS está configurado
correctamente para tarjetas europeas?"
```

### Coordinación con otros equipos

**Con Operaciones/Soporte:**
* Mantén comunicación bidireccional constante
* Actualiza el estado del ticket cada 30-60 minutos
* Explica en lenguaje simple, sin jerga técnica excesiva
* Anticipa preguntas: "¿Cuándo estará resuelto?" → "Estimo 1 hora más"

**Ejemplo de actualización a soporte:**
```
#support-channel

@soporte-team Update sobre ticket #12345

✅ Identificamos la causa: timeout en gateway de pagos
🚧 Solución en progreso: ajustando timeout de 30s → 60s
⏱️ ETA: Deploy en 20 minutos
📋 Workaround temporal: Pedir al usuario que reintente

Les aviso cuando esté resuelto.
```

**Con el equipo técnico:**
* No interrumpas a todos, identifica al experto del módulo
* Usa hilos/threads en Slack para no contaminar canales
* Documenta lo que aprendiste para la próxima rotación

### Empatía bajo presión

**Recuerda:**
* El usuario final está frustrado, no enojado contigo
* Soporte está presionado por el cliente, no te está atacando
* Tu equipo confía en ti, no espera que seas perfecto

**Frases que ayudan:**
* "Entiendo la urgencia, estoy en esto"
* "Gracias por el reporte detallado, me ayuda mucho"
* "Buen catch, no había visto ese edge case"

### Documentar mientras resuelves

Un buen guardia deja rastro para el futuro. Ejemplo de post-mortem rápido (5 minutos después de resolver):

**Post-mortem: Timeout en pagos con Visa 3DS**

- **Fecha:** 2025-10-10 15:30 UTC
- **Duración:** 45 minutos
- **Impacto:** 8 usuarios afectados

**Root cause:**
Timeout configurado en 30s, pero bancos europeos tardan ~45s en responder el challenge 3DS.

**Solución aplicada:**
- Aumenté timeout a 60s en `payment_service.rb:89`
- Deploy a producción en 20 minutos
- Verificado con usuario afectado

**Aprendizajes:**
- Documentar timeouts específicos por región
- Crear alerta si 3DS tarda >40s
- Agregar retry automático para timeouts

**Próximos pasos:**
- [ ] Crear ticket para refactorizar configuración de timeouts
- [ ] Agregar tests para este edge case

### Gestión del estrés y autoconocimiento

**Tips prácticos:**
* Si llevas 2 horas sin resolver algo crítico → **Escala, no te quemes**
* Toma breaks de 5 minutos cada hora, aunque estés en medio de un incidente
* No te lleves trabajo mental fuera del horario de guardia
* Pide feedback después de tu semana: "¿Qué puedo mejorar?"

**Señales de que debes escalar:**
* Sientes pánico o bloqueo mental
* El incidente supera tu nivel de conocimiento técnico
* Han pasado 30+ minutos sin avance en un crítico
* Necesitas tomar una decisión de arquitectura importante

---

## 6. Beneficios Reales (no es solo sufrimiento)

Sé que ser guardia puede sonar agotador, pero cuando lo implementas bien:

✅ **El equipo puede concentrarse** en completar el sprint sin interrupciones<br>
✅ **Los incidentes se resuelven más rápido** (de horas a minutos)<br>
✅ **Mejora la satisfacción del cliente** porque los bugs se atienden inmediatamente<br>
✅ **Se fortalece la cultura de ownership** compartido<br>
✅ **Se documenta mejor** porque el guardia tiene tiempo para escribir<br>

En proyectos anteriores donde implementé este rol:

* ⬇️ **MTTR bajó de 4 horas a 45 minutos**
* ⬆️ **Sprint completion rate subió del 65% al 85%**
* 📈 **Customer satisfaction aumentó 20 puntos**

---

## 6. Buenas Prácticas para No Morir en el Intento

Después de años haciendo esto, aprendí qué funciona y qué no:

### 1. Canal dedicado y estructura de requests

Los requests del guardia pueden llegar por diferentes canales, **dependiendo de las herramientas que use tu empresa**:

**Canales comunes:**
* **Slack/Teams:** Canal dedicado como `#oncall-incidents` o `#guardia-sprint`
* **Jira/Linear:** Tickets con label `[GUARDIA]` o `[TRIAGE]`
* **PagerDuty/Opsgenie:** Para incidentes críticos de producción
* **Email:** Para reportes de clientes o soporte (menos común)

**Estructura de un Request bien formado:**

Todo request debe contener esta información mínima para ser atendido eficientemente:

**📋 Template de Request para Guardia**

- **Título:** [PROD] Timeout en checkout de pagos
- **Prioridad:** 🔴 Critical / 🟠 High / 🟡 Medium / 🟢 Low

**Descripción:**
Usuario no puede completar el pago. Al hacer clic en "Pagar", la página se queda cargando indefinidamente.

**Flujo de Reproducción:**
1. Ir a https://app.ejemplo.com/checkout
2. Seleccionar método de pago "Tarjeta de crédito"
3. Ingresar datos: 4242 4242 4242 4242
4. Click en "Pagar"
5. ❌ Error: La página se queda en loading

**Logs/Screenshots/Video:**
- Video: https://loom.com/share/abc123
- Screenshot del console: [adjunto]
- Error en logs: "Stripe timeout after 30s"

**Usuario afectado:**
- Email: cliente@ejemplo.com
- ID: 12345
- Browser: Chrome 120 / MacOS

**Reportado por:** @soporte-team
**Fecha/Hora:** 2025-10-10 14:30 UTC

**Ejemplo en Slack:**
```
#oncall-incidents

@guardia 🔴 URGENT

**Título:** Payment gateway down - Stripe webhooks failing

**Descripción:**
Últimos 50 webhooks de Stripe están fallando.
Pagos se procesan pero no se confirman en el sistema.

**Logs:**
https://datadog.com/logs?query=stripe+webhook+500

**Impacto:**
~20 usuarios afectados en últimos 15 minutos

**Acción inmediata sugerida:**
Revisar Sidekiq queue y status de workers
```

**Ejemplo en Jira:**

| Campo | Valor |
|-------|-------|
| **Tipo** | Bug - Guardia |
| **Prioridad** | High |
| **Labels** | [GUARDIA], [PROD], [PAYMENTS] |
| **Título** | Usuario no puede editar perfil |
| **Descripción** | Ver template arriba |
| **Attachments** | video.mp4, screenshot.png, logs.txt |
| **Asignado a** | Guardia actual (rotar automáticamente) |

### 2. Tablero de triage con prioridades y estados

**Todo request debe tener dos dimensiones: Prioridad y Estado.**

**Prioridades y SLAs:**

| Prioridad | SLA | Acción |
|-----------|-----|--------|
| 🔴 Critical | < 15 min | Escala inmediatamente |
| 🟠 High | < 2 horas | Resuelve en el día |
| 🟡 Medium | < 1 día | Agenda para próximos días |
| 🟢 Low | Backlog | Envía a sprint planning |

**Estados del ciclo de vida:**

| Estado | Descripción | Quién lo actualiza |
|--------|-------------|-------------------|
| **📥 To Do** | Request recibido, pendiente de revisión | Sistema/Reporter |
| **🔍 Investigating** | Guardia está analizando logs, reproduciendo el bug | Guardia |
| **🚧 In Progress** | Solución en desarrollo o aplicándose | Guardia |
| **⏸️ Blocked** | Requiere información adicional o depende de otro equipo | Guardia |
| **✅ Done** | Resuelto y verificado en producción | Guardia |
| **📋 Backlog** | No urgente, se agenda para próximo sprint | Guardia/Tech Lead |
| **🔄 Escalated** | Requiere intervención del tech lead o equipo completo | Guardia |

**Ejemplo de flujo completo en Jira:**

1. Soporte crea ticket → Estado: 📥 To Do
2. Guardia lo toma → Estado: 🔍 Investigating
3. Reproducido, inicia fix → Estado: 🚧 In Progress
4. Necesita info del usuario → Estado: ⏸️ Blocked
5. Info recibida, continúa → Estado: 🚧 In Progress
6. Fix deployado y verificado → Estado: ✅ Done

**Pro tip:** Configura un dashboard tipo Kanban con estas columnas para visualizar el estado en tiempo real.

### 3. Automatiza alertas
```yaml
# datadog-monitors.yml
monitors:
  - name: "Stripe Webhook Failures"
    query: "sum(last_5m):sum:stripe.webhook.failed > 10"
    message: "@slack-#oncall URGENT: Stripe webhooks failing"

  - name: "Sidekiq Queue Blocked"
    query: "avg(last_10m):avg:sidekiq.queue_latency > 300"
    message: "@pagerduty High latency detected"
```

### 4. Retrospectiva de incidentes
Cada semana, en la retro del sprint:

* ¿Cuántos incidentes hubo?
* ¿Cuáles fueron recurrentes?
* ¿Qué podemos automatizar o prevenir?
* ¿El guardia tuvo suficiente soporte?

---

## 7. Caso Real: Una Semana como Guardia del Sprint

**Lunes 9:00 AM**
* Recibo el pase de guardia del compañero anterior
* Reviso el dashboard: 3 alertas menores del fin de semana
* Clasifico y creo tickets

**Martes 2:30 PM**
* 🚨 Alerta crítica: Payment gateway timeout en Stripe
* Analizo logs → Job bloqueando Sidekiq
* Cancelo el job, libero cola, notififico
* Tiempo total: 18 minutos

**Miércoles 11:00 AM**
* Soporte reporta: "Usuario no puede reservar canchas"
* Reproduzco el bug → validación incorrecta
* Fix en 25 minutos, deploy a producción

**Jueves**
* Día tranquilo, actualizo runbooks
* Limpio jobs fallidos del mes anterior
* Reviso métricas de uso

**Viernes 4:00 PM**
* Hago handoff al siguiente guardia
* Comparto aprendizajes de la semana
* 📊 Resultado: 12 incidentes atendidos, 8 bugs resueltos, 0 escalaciones

---

## 8. Reflexión Final

Ser guardia del sprint no es solo "apagar incendios". Es cuidar la salud del producto, proteger el tiempo del equipo y asegurar que los usuarios sigan confiando en la plataforma.

Es un rol de **responsabilidad**, **empatía** y **técnica**.

Si tu equipo todavía no tiene este rol implementado, te invito a probarlo. Empieza con una semana, rota entre 2-3 personas, y mide el impacto.

Te garantizo que en un mes, no querrán volver a trabajar sin un guardia del sprint.

---

**¿Has sido guardia del sprint? ¿Qué estrategias te funcionaron mejor? Déjame saber en los comentarios o contáctame directamente.**

*Escrito desde la trinchera, con café y mucho cariño técnico.*
