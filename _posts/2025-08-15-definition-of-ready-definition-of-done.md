---
layout: post

title: Definition of Ready y Definition of Done - Los guardianes de la calidad en desarrollo ágil

modified:

categories: Agile, Software Engineering, Best Practices

excerpt: >
  Cómo DoR y DoD transforman el caos en un proceso predecible y de alta calidad

tags: []

image:

feature:

date: 2025-08-15T08:12:53-07:00


---

## Introducción: El problema del "casi listo"

¿Cuántas veces has escuchado esto en tu carrera?

* "Esta tarea está lista para desarrollar" → Te sientas a trabajar y te faltan 10 piezas de información
* "Este feature está terminado" → Lo deploys y encuentras 5 bugs en producción
* "Solo falta un detallito" → Ese detallito toma 3 días más

En mis más de 10 años desarrollando software, he visto equipos paralizados por la falta de claridad sobre dos preguntas fundamentales:

1. **¿Cuándo una tarea está realmente lista para empezar?**
2. **¿Cuándo un feature está realmente terminado?**

La respuesta a estas preguntas son dos conceptos que separan equipos amateur de equipos profesionales:

* **Definition of Ready (DoR)** - El contrato de entrada
* **Definition of Done (DoD)** - El contrato de salida

> Este artículo es una guía práctica y técnica sobre cómo implementar DoR y DoD en equipos de desarrollo modernos, con ejemplos reales de sistemas complejos que gestionan pagos, reservaciones y operaciones críticas.

---

## 1. ¿Qué es Definition of Ready (DoR)?

**Definition of Ready es el checklist que asegura que una historia de usuario tiene suficiente claridad, contexto y detalle antes de que el equipo comience a trabajar en ella.**

### El costo de no tener DoR

Sin DoR, esto es lo que pasa:

* El desarrollador empieza a trabajar y descubre que falta información → **Bloqueo**
* Hace suposiciones incorrectas → **Retrabajo**
* Interrumpe a PM/Product constantemente → **Pérdida de foco**
* Las estimaciones están mal porque no había contexto completo → **Sprint fallido**

**Caso real que viví:**

Un desarrollador tomó un ticket que decía "Arreglar bug en pagos". Sin DoR:

* No sabía qué gateway estaba fallando (Stripe, PayPal, BAC?)
* No sabía cómo reproducir el bug
* No sabía el impacto (¿cuántos usuarios afectados?)
* Pasó 4 horas investigando antes de poder empezar

Con DoR, esas 4 horas se habrían ahorrado.

---

## 2. Criterios de DoR - El Checklist Definitivo

### 2.1 Contexto y Justificación

**Qué debe incluir:**
- Título descriptivo con número de ticket
- El "por qué" de la funcionalidad
- Valor de negocio o problema que resuelve
- Módulo/área del sistema afectada

**Ejemplo real:**

**❌ Mal (sin DoR):**
```
Ticket: Arreglar rangos de edad
```

**✅ Bien (con DoR):**
```
PLAT-2768 | Corregir rangos de edad superpuestos en pricing de turnos

**Contexto:**
Los grupos de edad 18-65 y 65-100 se superponen. Un usuario de 65 años
aparece en ambos grupos, causando precios duplicados en facturación.

**Impacto:**
- 150 usuarios afectados en último mes
- Descuadre en reportes financieros
- Confusión en clientes (+10 tickets de soporte)

**Módulo:** Pricing / Reservations
```

### 2.2 Criterios de Aceptación Verificables

**Qué debe incluir:**
- Happy path (caso de éxito)
- Edge cases y escenarios de error
- Validaciones necesarias
- Comportamiento esperado del sistema

**Ejemplo con casos reales:**

```
**Criterios de Aceptación:**

Happy Path:
✅ El rango 18-65 debe cambiar a 18-64
✅ El rango 65-100 permanece sin cambios
✅ Un usuario de 64 años debe tener precio del grupo 18-64
✅ Un usuario de 65 años debe tener SOLO precio del grupo 65-100

Edge Cases:
✅ Usuario sin edad definida → usar precio default
✅ Edad = 0 o negativa → error de validación
✅ Edad > 150 → error de validación

Validaciones:
✅ No puede haber rangos superpuestos
✅ Rangos deben cubrir todas las edades posibles (1-100+)
✅ Precio debe ser mayor a 0
```

### 2.3 Alcance Técnico Definido

**Qué debe incluir:**
- Archivos/módulos probablemente afectados
- Integraciones o dependencias externas
- Migraciones de datos si son necesarias
- Impacto en APIs (GraphQL, REST)
- Cambios en packs/packages específicos

**Ejemplo real:**

```
**Alcance Técnico:**

Backend (Ruby on Rails):
- Models: PricingRule, ShiftPrice, AgeGroup
- Validations: AgeGroupValidator (actualizar lógica de rangos)
- Services: PricingCalculator (recalcular para edades límite)
- Migrations: UpdateOverlappingAgeRanges

APIs afectadas:
- GraphQL: shiftPricing query
- REST: /api/v1/pricing/calculate (deprecado pero aún en uso)

Frontend:
- React components: PricingForm, AgeRangeSelector
- Redux: pricing slice

Migraciones:
- Actualizar ~500 registros de pricing_rules existentes
- Recalcular precios históricos afectados (opcional)

Packs/Packages:
- Core app (no packs externos)
```

### 2.4 Multi-tenancy y Consideraciones de Scope

Para sistemas SaaS o multi-tenant:

```
**Multi-tenancy:**
- Scope: Por facility (cada instalación tiene sus rangos)
- Timezone: No aplica (edad no depende de timezone)
- Datos existentes: 45 facilities con rangos a actualizar
- Configuración: Migración automática + opción manual post-deploy

**Backward Compatibility:**
- Mobile app v2.3+ soporta nuevos rangos
- Mobile app < v2.3 seguirá usando API legacy (sin cambios)
```

### 2.5 Seguridad y Compliance

```
**Seguridad:**
- Datos sensibles: No (solo rangos de edad, no PII)
- Autorización: Solo admins pueden editar pricing rules (CanCanCan :manage, PricingRule)
- Auditoría: Loggear cambios en pricing_rules_audit_log
- Compliance: No aplica PCI/GDPR

**Permisos requeridos:**
- Desarrollo: :facility_admin o :super_admin
- QA: :facility_admin en staging
```

### 2.6 Plan de Testing

```
**Testing Strategy:**

Unit Tests:
- AgeGroupValidator#validate_no_overlaps
- PricingCalculator#price_for_age(64) → grupo 18-64
- PricingCalculator#price_for_age(65) → grupo 65-100

Integration Tests:
- Crear reserva con usuario edad 64 → precio correcto
- Crear reserva con usuario edad 65 → precio correcto
- Actualizar pricing rule → validaciones funcionan

System Tests (Playwright/Cypress):
- Admin crea nuevo pricing rule con rangos válidos
- Admin intenta crear rangos superpuestos → error visible

Testing Manual:
- Verificar migración en staging antes de producción
- Probar con 3-5 facilities reales
- Validar cálculos históricos no afectados
```

### 2.7 Dependencias y Blockers

```
**Dependencias:**
- PLAT-2750: Refactor de PricingCalculator (debe estar en develop)
- Staging con datos recientes (snapshot de prod < 7 días)

**Blockers:**
- Ninguno identificado

**Riesgos:**
- Migración podría tomar >10min en prod (500k registros)
  Mitigación: Ejecutar en horario de bajo tráfico
```

---

## 3. ¿Qué es Definition of Done (DoD)?

**Definition of Done es el checklist que asegura que una historia está completamente terminada, probada, documentada y lista para producción.**

### El costo de no tener DoD

Sin DoD:

* Features "terminados" que rompen en producción
* Tests que faltan o están skippeados
* Documentación que nunca se actualiza
* Code review superficial porque no hay estándar claro
* Deuda técnica que crece exponencialmente

**Caso real:**

Un desarrollador hizo merge de un feature "terminado":

* Funcionaba en su máquina ✅
* Pero no tenía tests ❌
* Rompió el build de CI ❌
* No documentó las variables de entorno nuevas ❌
* Deployment falló en staging ❌

Resultado: 2 días de downtime, 3 desarrolladores bloqueados, PM frustrado, cliente enojado.

Con DoD, esto no habría pasado del code review.

---

## 4. Criterios de DoD - El Checklist de Calidad

### 4.1 Código Implementado y Clean

```
**Checklist:**
✅ Funcionalidad completa según criterios de aceptación
✅ Código sigue convenciones del proyecto (RuboCop, ESLint, Prettier)
✅ No hay código comentado sin justificación
✅ No hay console.log o binding.pry olvidados
✅ Variables tienen nombres descriptivos
✅ Métodos tienen responsabilidad única (SRP)

**Validación:**
bundle exec rubocop -A                    # Ruby
npm run lint                              # JavaScript
bundle exec rails runner 'system("packwerk check")'  # Pack boundaries
```

### 4.2 Tests Completos y Pasando

**El mínimo aceptable:**

```
**Unit Tests:**
✅ Toda lógica de negocio tiene tests
✅ Edge cases cubiertos
✅ Mocks/stubs usados apropiadamente
✅ Coverage no disminuye (mínimo mantener %)

**Integration Tests:**
✅ Flujos completos end-to-end
✅ Integraciones con servicios externos (Stripe, AWS, etc.)
✅ Background jobs probados

**System Tests (si aplica):**
✅ UX crítica probada (checkout, login, pagos)
✅ Tests no son flaky (usar Timecop, stubs consistentes)

**Validación:**
bundle exec rspec                         # Todos los tests
SIMPLECOV_REPORT=true bundle exec rspec   # Con coverage
bin/test_system system_specs/pricing/     # System tests
```

**Ejemplo de test bien hecho:**

```ruby
# spec/validators/age_group_validator_spec.rb
RSpec.describe AgeGroupValidator do
  describe '#validate_no_overlaps' do
    context 'when ranges overlap' do
      it 'adds error for overlapping ranges' do
        rule1 = build(:pricing_rule, age_min: 18, age_max: 65)
        rule2 = build(:pricing_rule, age_min: 65, age_max: 100)

        validator = AgeGroupValidator.new([rule1, rule2])

        expect(validator.valid?).to be false
        expect(validator.errors).to include('Age ranges cannot overlap')
      end
    end

    context 'when ranges do not overlap' do
      it 'is valid' do
        rule1 = build(:pricing_rule, age_min: 18, age_max: 64)
        rule2 = build(:pricing_rule, age_min: 65, age_max: 100)

        validator = AgeGroupValidator.new([rule1, rule2])

        expect(validator.valid?).to be true
      end
    end
  end
end
```

### 4.3 Manejo de Timezone y Time (crítico en apps globales)

```
✅ Usar Time.current en lugar de Time.now
✅ Usar Time.zone.parse en lugar de Time.parse
✅ Respetar timezone de facility/user según contexto
✅ Tests con tiempo usan Timecop.freeze para evitar flakiness

**Ejemplo correcto:**
# ❌ Mal
created_at = Time.now
due_date = Date.today + 7.days

# ✅ Bien
created_at = Time.current
due_date = 7.days.from_now

# ✅ Mejor (con timezone específico)
created_at = Time.current.in_time_zone(facility.timezone)
```

### 4.4 Consideraciones de Pago y Finanzas

Para features que tocan dinero:

```
✅ Usar transacciones de DB para operaciones financieras
✅ Jobs de pago son idempotentes
✅ Validar montos y precisión (cents vs dollars)
✅ Manejar correctamente gateway selection
✅ Loggear TODAS las operaciones financieras
✅ Nunca hacer cálculos con floats (usar Money gem o cents en integers)

**Ejemplo de idempotencia:**
def process_payment(payment_id)
  payment = Payment.find(payment_id)

  return if payment.processed? # Idempotencia

  Payment.transaction do
    result = gateway.charge(payment.amount_cents)
    payment.update!(
      status: 'processed',
      gateway_transaction_id: result.id
    )
    PaymentAuditLog.create!(payment: payment, action: 'processed')
  end
rescue Stripe::CardError => e
  payment.update!(status: 'failed', error: e.message)
  raise
end
```

### 4.5 Background Jobs Robustos

```
✅ Jobs reciben argumentos como hash con symbolized keys
✅ Validar args.is_a?(Hash) antes de procesar
✅ Variables inicializadas antes de rescue blocks
✅ Jobs son idempotentes (pueden ejecutarse múltiples veces)
✅ Retry logic configurado apropiadamente
✅ Dead letter queue para failures críticos

**Ejemplo robusto:**
class ProcessRefundJob < ApplicationJob
  queue_as :critical

  retry_on Stripe::APIConnectionError, wait: :exponentially_longer, attempts: 5
  discard_on Stripe::InvalidRequestError

  def perform(args)
    raise ArgumentError, 'Hash expected' unless args.is_a?(Hash)

    args = args.deep_symbolize_keys
    payment_id = args.fetch(:payment_id)
    reason = args.fetch(:reason, 'customer_request')

    payment = Payment.find(payment_id)

    return if payment.refunded? # Idempotencia

    # ... lógica de refund
  rescue => e
    ErrorTracker.notify(e, payment_id: payment_id)
    raise
  end
end
```

### 4.6 Seguridad y Autorización

```
✅ Endpoints tienen autorización apropiada (CanCanCan, Pundit)
✅ No se exponen IDs de DB en APIs (usar UUIDs o secure_ids)
✅ Datos sensibles están encriptados (attr_encrypted)
✅ SQL injection prevenido (usar placeholders, no string interpolation)
✅ XSS prevenido (sanitize inputs)
✅ CSRF tokens en formularios

**Ejemplo de autorización correcta:**
# app/controllers/api/v1/pricing_rules_controller.rb
class Api::V1::PricingRulesController < ApiController
  load_and_authorize_resource # CanCanCan

  def update
    # authorize! ya fue ejecutado por load_and_authorize_resource

    if @pricing_rule.update(pricing_rule_params)
      render json: @pricing_rule
    else
      render json: { errors: @pricing_rule.errors }, status: :unprocessable_entity
    end
  end

  private

  def pricing_rule_params
    params.require(:pricing_rule).permit(:age_min, :age_max, :price_cents)
  end
end

# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, PricingRule
    elsif user.facility_manager?
      can :manage, PricingRule, facility_id: user.facility_id
    else
      can :read, PricingRule
    end
  end
end
```

### 4.7 CI/CD Checks Pasando

```
✅ RuboCop sin warnings
✅ Brakeman sin vulnerabilidades nuevas
✅ Tests en CI pasando (no solo local)
✅ Coverage no disminuyó
✅ Build artifacts generados correctamente
✅ Docker image builds (si aplica)

**Validación local antes de push:**
bundle exec rails ci                    # Ejecuta todos los checks
bundle exec brakeman -z                 # Security scan
bundle exec pronto run -c develop       # Code review automatizado
```

### 4.8 Migraciones de Base de Datos

```
✅ Migraciones son reversibles (método down implementado)
✅ Migraciones de datos si es necesario (backfill)
✅ Probadas en staging antes de prod
✅ Indexes apropiados para queries nuevas
✅ Compatible con zero-downtime deployment
✅ Considera volumen de datos en producción

**Ejemplo de migración reversible:**
class UpdateAgeRangesBounds < ActiveRecord::Migration[6.1]
  def up
    # Actualizar rangos 18-65 a 18-64
    PricingRule.where(age_min: 18, age_max: 65).find_each do |rule|
      rule.update_columns(age_max: 64, updated_at: Time.current)
    end
  end

  def down
    # Revertir cambios
    PricingRule.where(age_min: 18, age_max: 64).find_each do |rule|
      rule.update_columns(age_max: 65, updated_at: Time.current)
    end
  end
end
```

### 4.9 Documentación Actualizada

```
✅ Comentarios en código complejo explicando el "por qué"
✅ Métodos públicos documentados (YARD, JSDoc)
✅ GraphQL schema tiene descriptions
✅ README actualizado si hay nuevos setup steps
✅ Variables de entorno documentadas (.env.example)
✅ API docs actualizados (Swagger/OpenAPI)
✅ Cambios arquitectónicos documentados en /docs

**Ejemplo de documentación clara:**
# app/services/pricing_calculator.rb

# Calcula el precio de una reserva considerando:
# - Edad del usuario (aplica descuentos por grupo etario)
# - Horario del turno (peak vs off-peak)
# - Membresía activa (descuentos adicionales)
# - Promociones vigentes
#
# @param user [User] Usuario que hace la reserva
# @param shift [Shift] Turno a reservar
# @return [Money] Precio final en cents
# @raise [PricingError] Si no se puede calcular precio
#
# @example
#   calculator = PricingCalculator.new(user, shift)
#   price = calculator.calculate
#   # => #<Money cents: 1500 currency: USD>
def calculate
  # ...
end
```

### 4.10 Code Review Aprobado

```
✅ PR tiene descripción clara con contexto
✅ Screenshots para cambios de UI
✅ Al menos 1 reviewer aprobó (2 para features críticos)
✅ Todos los comentarios resueltos
✅ No hay merge conflicts
✅ Branch está actualizado con develop/main

**Template de PR bien hecho:**

## 🎯 Objetivo
PLAT-2768: Corregir rangos de edad superpuestos en pricing

## 📝 Cambios
- Actualizar AgeGroupValidator para prevenir overlaps
- Cambiar rango 18-65 a 18-64 en migración
- Agregar tests para edge cases

## 🧪 Testing
- ✅ Unit tests: 12 nuevos, todos pasan
- ✅ Integration tests: Flujo completo de pricing
- ✅ Manual: Probado en staging con 5 facilities

## 📸 Screenshots
[imagen del form con validación de overlaps]

## ⚠️ Consideraciones
- Migración toma ~5min en prod (estimado)
- Ejecutar en horario de bajo tráfico
- Rollback disponible vía down migration
```

### 4.11 Performance y Queries

```
✅ No hay N+1 queries (usar includes/preload)
✅ Queries complejas optimizadas
✅ Caching donde es apropiado (Redis, Rails.cache)
✅ Background jobs para operaciones pesadas (>5 segundos)
✅ Pagination en listados grandes

**Ejemplo de prevención N+1:**
# ❌ Mal (N+1)
facilities.each do |facility|
  puts facility.owner.name  # Query por cada facility
end

# ✅ Bien
facilities.includes(:owner).each do |facility|
  puts facility.owner.name  # Una sola query
end

**Validación en Rails console:**
ActiveRecord::Base.logger = Logger.new(STDOUT)
# Ejecutar código y contar queries
```

---

## 5. Flujo de Trabajo con DoR y DoD

### El proceso ideal

```
1. Product/PM crea ticket
   ↓
2. Equipo revisa contra DoR en refinement
   ├─ ✅ Cumple DoR → Pasa a backlog "Ready"
   └─ ❌ No cumple → Regresa a PM para completar
   ↓
3. Sprint Planning: Desarrollador toma ticket de backlog "Ready"
   ↓
4. Desarrollo e implementación
   ↓
5. Desarrollador auto-revisa DoD antes de crear PR
   ↓
6. Code review verifica DoD
   ├─ ✅ Cumple DoD → Aprobado para merge
   └─ ❌ No cumple → Request changes
   ↓
7. Merge a develop → Auto-deploy a staging
   ↓
8. QA verifica en staging
   ↓
9. Deploy a producción
   ↓
10. Monitoring post-deploy (24-48h)
```

---

## 6. Adaptaciones según Contexto

### Hotfixes de Producción

**DoR simplificado:**
- Contexto: ¿Qué está roto y por qué?
- Impacto: ¿Cuántos usuarios afectados?
- Solución propuesta: ¿Cómo arreglarlo?
- Rollback plan: ¿Cómo revertir si falla?

**DoD mínimo pero NO negociable:**
- Tests (al menos el happy path)
- Code review (puede ser post-merge en casos extremos)
- Documentación (puede ser post-fix)

### Spikes de Investigación

**DoR para spikes:**
- Preguntas a responder
- Opciones a evaluar
- Criterio de decisión
- Timebox (ej: 4 horas max)

**DoD para spikes:**
- Documento con hallazgos
- Recomendación técnica
- Tickets de implementación si procede
- Actualización de arquitectura docs

### Refactors Técnicos

**DoR para refactors:**
- Justificación técnica clara (performance, mantenibilidad, etc.)
- Métricas actuales (ej: coverage 60%, tiempo de CI 15min)
- Métricas objetivo (ej: coverage 80%, tiempo de CI 8min)

**DoD para refactors:**
- Comportamiento NO cambió (tests originales siguen pasando)
- Nuevos tests agregados si hay nueva lógica
- Métricas objetivo alcanzadas
- Documentación de cambios arquitectónicos

---

## 7. Señales de Alerta

### DoR insuficiente (síntomas):

* Desarrolladores haciendo > 5 preguntas por ticket durante desarrollo
* Historias bloqueadas por dependencias no identificadas
* Estimaciones erradas por factor de 2x o más
* Retrabajo frecuente por malentendidos
* Desarrolladores rechazando tickets del backlog

### DoD no seguido (síntomas):

* Bugs en features recién desplegadas (< 48h)
* Code reviews que toman > 1 día
* Tests skippeados o pendientes en develop
* Deuda técnica creciendo sprint tras sprint
* Rollbacks frecuentes en producción
* Coverage decreciendo consistentemente

---

## 8. Caso Real Completo

### Historia: Corregir rangos de edad superpuestos

**DoR Checklist (Pre-desarrollo):**

```
✅ Contexto: Rangos 18-65 y 65-100 causan precios duplicados
✅ Impacto: 150 usuarios/mes, descuadre en reportes
✅ Criterios aceptación: Cambiar a 18-64, validar no-overlap
✅ Alcance técnico:
   - Backend: PricingRule model, AgeGroupValidator
   - Migración: UpdateAgeRangeBounds
   - Tests: Unit + integration
✅ Multi-tenancy: Por facility, 45 facilities afectadas
✅ Seguridad: Solo admins, auditoría en logs
✅ Testing plan: Definido (ver arriba)
✅ Documentación: Actualizar validator docs
✅ Dependencias: Ninguna
✅ Estimación: 5 story points (1-2 días)
```

**Desarrollo (2 días)**

Día 1:
- Actualizar AgeGroupValidator con lógica no-overlap
- Crear migración UpdateAgeRangeBounds
- Tests unitarios (12 specs nuevos)

Día 2:
- Tests de integración (flujo completo pricing)
- Probar migración en staging
- Documentar cambios
- Code review self-check

**DoD Checklist (Pre-PR):**

```
✅ Código: Validaciones implementadas, migración creada
✅ Tests: 15 specs nuevos, coverage +2%, todos pasan
✅ RuboCop: 0 warnings
✅ Brakeman: 0 issues nuevos
✅ Migraciones: Reversible, probada en staging
✅ Performance: Sin queries adicionales, usa índices existentes
✅ Documentación: Comentarios en validator, migración documentada
✅ PR: Descripción completa, screenshots de admin UI
✅ CI: Todos los checks en verde
✅ QA: Probado en staging con 5 facilities reales
```

**Code Review (1 día)**

Comentarios:
- "Agregar test para edad = null" → Agregado
- "Migración podría ser lenta en prod" → Agregada nota en PR
- "Falta docs en GraphQL schema" → Agregado

**Resultado:**
- Merge exitoso
- Deploy a producción sin issues
- 0 bugs reportados post-deploy
- Tiempo total: 3 días (según estimación)

---

## 9. Implementando DoR/DoD en tu Equipo

### Paso 1: Empezar simple

No implementes TODO de una vez. Empieza con lo básico:

**DoR mínimo viable:**
1. Título claro + número de ticket
2. Criterios de aceptación
3. Alcance técnico identificado

**DoD mínimo viable:**
1. Tests pasando
2. Code review aprobado
3. Sin linter warnings

### Paso 2: Iterar y mejorar

Cada retrospectiva:
- ¿Qué faltó en DoR que causó problemas?
- ¿Qué en DoD no se cumplió y causó bugs?
- Agregar esos puntos al checklist

### Paso 3: Automatizar

```bash
# pre-commit hook para DoD
#!/bin/bash
bundle exec rubocop || exit 1
bundle exec rspec || exit 1
echo "✅ DoD checks passed"
```

### Paso 4: Medir impacto

Métricas a trackear:
- Tiempo promedio de desarrollo por story point (debe bajar)
- Bugs en producción post-deploy (debe bajar)
- Tickets regresados por falta de información (debe bajar)
- Velocity del equipo (debe subir o estabilizarse)

---

## 10. Reflexión Final

DoR y DoD no son burocracia. Son **contratos** que protegen a todos:

**Para Desarrolladores:**
- Claridad antes de empezar
- Confianza al hacer merge
- Menos interrupciones

**Para Product/PM:**
- Expectativas alineadas
- Menos sorpresas
- Features realmente terminados

**Para el Negocio:**
- Menos bugs en producción
- Entregas predecibles
- ROI medible

Después de años implementando DoR/DoD en múltiples equipos, puedo afirmar:

> Los equipos con DoR/DoD claro son 2-3x más rápidos que equipos sin ellos. No porque trabajen más rápido, sino porque **no pierden tiempo en retrabajo, bugs y malentendidos**.

La inversión inicial de definir estos checklists se paga en la primera semana.

---

## Recursos para Profundizar

**Plantillas descargables:**
- DoR Template (Notion/Confluence/Jira)
- DoD Checklist (GitHub PR template)
- Code Review Checklist

**Herramientas recomendadas:**
- Danger.js - Automatizar code review checks
- Pronto - Code review automatizado
- SimpleCov - Coverage tracking
- Brakeman - Security scanning

**Lecturas recomendadas:**
- "User Stories Applied" - Mike Cohn
- "The DevOps Handbook" - Gene Kim
- "Accelerate" - Nicole Forsgren

---

**¿Tu equipo tiene DoR y DoD claros? ¿Qué otros criterios agregarías? Comparte tu experiencia en los comentarios.**

*Escrito desde la trinchera del desarrollo ágil, con café y muchos sprints de experiencia.*
