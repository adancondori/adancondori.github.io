---
layout: post

title: "Una buena Arquitectura de Software - Spanish"

modified:

categories:

excerpt: >

 Mis notas acerca de buena arquitectura

tags: []

image:

feature:

date: 2021-05-29T08:23:53-07:00


---

# A good Software Architecture



## Resumen 

En la actualidad los productos de software son muy variados y por lo tanto se utiliza una variedad de arquitecturas de software. Las cuales demuestran el éxito de un proyecto de software y la aceptación como una buena arquitectura, es por eso que en este ensayo estaremos hablando acerca de los beneficios, practicas, recomendaciones y conceptos fundamentales  para llegar a tener una buena arquitectura de software. Debo mencionarles que no se hablara acerca de tecnologías porque estas cambian rápidamente en nuestra profesión.

## Contexto 

Entonces empecemos hablando sobre ¿Qué es una Arquitectura de Software?, No existe una definición correcta para referirse a qué es la Arquitectura de Software. Sin embargo existen varias definiciones que tienen el mismo concepto, Ejemplo  "Una Arquitectura de Software representa la estructura o estructura del sistema, que consta de componentes de software, las propiedades visibles externas de esos componentes y la relación entre ellos.", teniendo como base la anterior definición podemos comentar e inferir que la arquitectura de software no solo se limita a definir los componentes y sus relaciones, sino a tener claro las relaciones entre objetos, identificación de tecnologías adecuadas para construir el sistemas, por otro lado es importante entender los requisitos no funcionales del sistema, documentar y comunicar a las partes interesadas.

## Cuerpo 

La Arquitectura de Software sirve como vision de un plano para el equipo de desarrollo de software quienes  estarán implementando los requerimientos del negocio puedan tener mejor idea. La arquitectura de software no es un plano estático mas al contrario es un proceso de evolución en estrategias, técnicas, patrones de diseño, diseños arquitectónicos y componentes. Al construir una buena arquitectura podremos identificar los riesgos de diseño y mitigarlos con anticipación.

Algo que he aprendido con los años de experiencia en el desarrollo de software  es que ni siquiera el cliente sabra lo que quiere. Por lo tanto es importante tener algún documento para todos los requerimientos funcionales y no funcionales, ademas de una serie de entrevistas con todos los involucrados al software, todo esto con el objetivo de entender el negocio. De esta manera podremos definir una arquitectura base acorde a las necesidades del cliente, también se podrá definir las tecnologías que se adecuen al sistema. 

A continuación responderemos las siguientes preguntas:

- ### Which criteria do you use to define such architecture as good?

  Hay muchos criterios de calidad del sistema que podemos discutir, pero para mí, las siguientes características de la arquitectura son una base sólida para obtener una buena arquitectura de software.

  1. **Comprensibilidad**.- Significa que nuestra arquitectura es de fácil de entender por el equipo de desarrollo y las partes interesadas, al mismo tiempo debe abarcar todos los requisitos del negocio.  
  2. **Facilidad de uso y Aprendizaje**.- Este punto esta relacionado con los requerimientos de  UX/UI lo cual es importante al momento de definir la tecnología en la que se desarrollara el software. Los arquitectos deben ser consciente a la hora de definir la tecnología y la arquitectura. 
  3. **Seguridad**.- Es un factor importante para el software, consiste en restringir el acceso de los usuarios ó componente basándose en la autenticación. De esta manera se podrá proteger de ataques DDoS, inyección de SQL y alertar al sistema. De esta manera se resguardaran los datos.
  4. **Fiabilidad y Disponibilidad**.- Es muy importante en el diseño de la arquitectura de software porque las fiabilidad es un atributo del sistema responsable de la capacidad de seguir funcionando en condiciones predefinidas y la Disponibilidad representa que el sistemas estará funcionando el 99,9 %, caso contrario se debe tener medidas de contingencia como correos, notificaciones.
  5. **Interoperabilidad**.- La mayoría de los servicios de las aplicaciones deben comunicarse con sistemas externos para proporcionar servicios completos. Una arquitectura de software bien diseñada facilita la interoperabilidad de la aplicación para comunicarse e intercambiar datos con sistemas externos o sistemas heredados.
  6. **Testablidad**.-  La base de una buena arquitectura de software se base en asegurase de que el diseño de cada componente sea testeable. Una arquitectura testable debe mostrar claramente todas las interfaces, y la integración entre los componentes. Todos los requisitos funcionales y no funcionales (NFR) del negocio deben ser coherentes y completamente comprobables. Asegúrese de que todos los entornos DEV, TEST, UAT y PRODUCCIÓN sean similares.
  7. **Escalabilidad**.- La arquitectura tecnológica definida debe ser capas de escalar sin afectar el rendimiento. Hay dos tipos de escalado: el escalado vertical y el escalado horizontal. El escalado vertical consiste en añadir más hardware de CPU/memoria/disco al servidor existente. El escalado horizontal consiste en dividir la carga y responder a las peticiones añadiendo más servidores/instancias al clúster de servidores. El escalado horizontal es recomendado.

- ### Which benefits does the architecture provide over the inhabitants of the system?

  Los beneficios de una buenas arquitectura son:

  1. Crear un plano o base solidad para el proyecto de software
  2. Escalabilidad del Proyecto de software.
  3. Reduce costos de mantenimiento.
  4. Aumenta el rendimiento del Proyecto de software.
  5. Mejor mantenibilidad en el código.
  6. Permite cambios rápidos en el proyectos.
  7. Ayuda en la gestión de riesgos . Ayuda a reducir los riesgos y la posibilidad de fallas.
  8. Mayor adaptabilidad para nuevos requerimiento, ya que la arquitectura del software crea una clara separación de preocupaciones. 
  9. Mejor comunicación con las partes interesadas
  10. Auditable y testeable.

  

- ### Which trade-offs have been made in the system to keep the architecture?

  En el Diseño de Arquitectura existen consideraciones importantes a tomar decisiones:

  - **Flexibilidad frente a simplicidad** 

  - **Espacio contra tiempo**

  - **Latencia frente a rendimiento**

  - **Seguridad, Estabilidad, Mantenibilidad**

    

- ### Which recommendations for improvements you have over the architecture?

  Para el diseño de una buena arquitectura es importante tener un equipo multi-diciplinario y algunos de sus integrantes tengan varios años de experiencia en el desarrollo de software, a continuación voy a listar algunas recomendaciones que utilidad y investigado cuando he desarrollado software.

  1. Analizar y Verificar si existen dependencias con componentes, API, externos. En caso de existir se debe definir el protocolo de comunicación.
  2. Tener estrecha comunicación  con el cliente para conocer el proceso y los requerimientos de la solución. 
  3. Definir qué patrones de arquitectura se va a utilizar.
  4. Definir qué componentes se va utilizar  o se va crear.
  5. Recomendar que el equipo tenga conocimientos de algunos conceptos como SOLID, KISS, DRY y YAGNI, estos conceptos ayudara a que el equipo pueda realizar un código mantenible. 
  6. Conocer y aplicar patrones de diseño, refactorización los cuales nos ayudaran a tener un código limpio.

## Conclusión 

En este articulo he presentado mis investigaciones he ideas sobre cuáles deberían ser las características de una buena arquitectura de software. Cada una de estas características merece una discusión más larga y también hay otras características que no se tocan. 

La arquitectura de software que diseñes siempre debe estar enfocada a lo que necesita el cliente, en entender que es lo que nuestro software va a trabajar y cómo lo va a hacer. Pudiendo ser capaces de conocer los pro y contras de cada opción que tomemos desde antes de empezar a codificar.



