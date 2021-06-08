## Representación de Arquitectura de Software



## Resumen

Cuando nosotros diseñamos una Arquitectura de Software necesitamos representarla en documentos de tal manera que podamos describir y comunicar a nuestro clientes, equipo de desarrollo, dueños de productos etc.,  con el objetivo de trasmitir de forma sencilla, clara todas las tecnologías, componentes que estaremos utilizando en el diseño de Software.

En este articulo tratare de mostrar algunos enfoques para la documentación del diseño de arquitectura, estos enfoques me han servido en mi experiencia laboral y las he utilizado con algunos cliente que he llegado a tener. Así mismo tratare de mencionar algunas recomendaciones y ventajas sobre representaciones de Software. Este articulo no lo hago para que tu lo utilices al pie de la letra sino para que puedan conocer los enfoques que he manejado y estoy aprendiendo, por lo tanto tu puedes decidir la herramienta y el enfoque que mas se adecue a tu proyecto. 

## Contexto

Actualmente tenemos varias notaciones y herramientas para representar y modelar el diseño de una Arquitectura de Software. Pero cuando estamos realizando un proyecto para una empresa consolidada o que tenga un departamento de desarrollo, nos solicitaran una documentación sobre la representación de nuestra arquitectura, por lo cual nosotros tenemos que elegir la representación que mas se adecue a nuestro proyecto, también debo mencionar que algunas empresas no piden ninguna representación de la arquitectura ó la documentación del software, solo les importa que software funcione. 

## Cuerpo

Bueno cuando nosotros empezamos a diseñar debemos elegir el enfoque de documentación que tengan todas las características que necesitamos para representar nuestro proyecto.  Entre las representaciones de diseño de arquitectura tenemos los siguientes:

- Modelo C4: El modelo C4 se creó como una forma de ayudar a los equipos de desarrollo de software a describir y comunicar la arquitectura de software, tanto durante las sesiones de diseño iniciales como al documentar retrospectivamente una base de código existente. [Model C4](https://c4model.com/)
- ADR: Cada proyecto de software incluye un conjunto de decisiones de arquitectura que definen límites y restricciones para un mayor diseño e implementación. Es importante documentar esas decisiones de alguna manera o, de lo contrario, es posible que un equipo de desarrollo no sepa qué decisiones se tomaron y con qué suposiciones. [Managing Architecture Decision Records with ADR-Tools](https://www.hascode.com/2018/05/managing-architecture-decision-records-with-adr-tools/), [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
- ARC42: Es una opilación de experiencia practica de muchos sistemas en varios dominios, desde sistemas de información y web, en tiempo real e integrados hasta inteligencia empresarial y almacenes de datos, proporciona una plantilla para la [**documentación y comunicación**](https://www.notion.so/Arc42-Notion-Template-b3662172ccec40e69a9c3d64ef2c6223) y admite **tecnologías y herramientas arbitrarias**. [ARC42](https://arc42.org/)
- Modelo de Vistas de Arquitectura: También llamado **4+1**, es un modelo diseñado por Philippe Kruchten para describir la arquitectura de sistemas software, basados en el uso de múltiples vistas concurrentes. [Modelo de Vistas de Arquitectura 4+1](https://es.wikipedia.org/wiki/Modelo_de_Vistas_de_Arquitectura_4%2B1)
-  Y Notaciones de UML: El lenguaje de modelado unificado ayuda a especificar, visualizar y documentar modelos de sistemas de software, incluida su estructura y diseño, de una manera que cumpla con todos estos requisitos [UML](https://www.uml.org/what-is-uml.htm)

Cada una de los representaciones anteriores mencionadas tienen sus fortalezas y debilidades por lo cual nosotros deberemos elegir con todo el equipo de desarrollo.

En mi opinión una de las representación mas utilizada es el Modelo C4 el cual tiene como objetivo describir nuestra arquitectura desde un nivel bajo hasta un nivel alto, es decir desde un nivel de clases y componentes hasta un nivel de arquitectura el cual podra ser entendido por nuestros clientes y el equipo de desarrollo de software.

A continuación responderemos las siguientes preguntas:

### ¿Qué criterios debemos utilizar para definir dicho método de representación como bueno?

Todos los criterios dependerán del tamaño de Proyecto que estemos realizando, pero los criterios mas comunes que deberíamos utilizar son los siguientes:

- **Cambios en el tiempo:** la representación que utilicemos debería adecuarse a posibles cambios que exista en el proyecto o en la arquitectura de software, es decir nuevos requerimientos de funcionalidades o nuevas tecnologías.
- **La documentación no debe se pesada:** La representación de arquitectura de contener la  documentación  necesaria y no así demasiados diagramas porque luego se vuelven inservibles y no se llegan a utilizar.
- **La documentación debe representar al código:**  
- **Niveles de Abstracción:** La representación que se elija debe contener todas las notaciones básicas para  demostrar los niveles de abstracción del diseño de nuestra arquitectura como por ejemplo:
  1. **Forma:**  Es aquella que representa los componentes y estructura del software como patrones de diseño por ejemplo: API, Monolitics Web, MVC, MVP etc. En este punto podremos identificar que es el sistema y contiene el sistema.
  2. **Comportamiento:** Describe el comportamiento, funcionalidades del sistema las cuales son representadas por diagramas como Casos de Uso. 
  3. **Operaciones:** Describe la infraestructura que utiliza el sistema, es importante que podamos identificar para ver cómo organizar y que tecnologías se utilizaran por ejemplo: Multi-tenant despliegue, Micro-services, Load-Balances service etc.

### ¿Qué ventajas aporta el método de representación a los habitantes del sistema?

Los habitantes del sistemas son todos aquellas personas que interactúan con el software, por los cual si se elige una  representación donde nuestros habitantes lleguen a entender y comprender sera fácil hacer cambios al sistemas como también se tendrá claro el alcance que puede tener nuestro software. 

### ¿Qué recomendaciones de mejora tiene sobre el método de representación?

Mi recomendación es apegarse a la representación que se llegue a elegir ocupando todas sus notaciones y herramientas que nos provee, porque si solo seguimos a medio nuestra representación fracasara y el sistemas no podrá  ser comprendida por ningún  integrante del equipo.



## Conclusión 

Existen diferentes tipos de representación para el diseño de Arquitectura de software, por lo cual es importante utilizar alguna de ellas para extender la vida de nuestro software, ademas de tener un panorama amplio de las formas, comportamientos y como sera el despliegue de nuestro sistema.

En este articulo he presentado mis investigaciones he ideas sobre las representaciones de una arquitectura de software. Cada una de estas características merece una discusión más larga y también hay otras características que no se mencionado. 



 