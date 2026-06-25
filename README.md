[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/30wG3ZmR)


## Recuperatorio de Objetos 2025

Fecha: 6/11/2025

La empresa Paradigmas SAS desea automatizar el monitoreo de los servicios que corren en su infraestructura. 
Para ello, un equipo de la empresa comenzo a desarrollar el modelado de los objetos que van a representar a cada servicio.
La idea es tener un servicio que monitoree el estado de los servicios y si estos estan disponibles (su [uptime](https://es.wikipedia.org/wiki/Uptime)).
Para ello, este equipo comenzo considerando 2 grandes categorias de servicios que se corren la nube de la empresa:
- Servicios web: De ellos se conoce la URL (la direccion en la que pueden ser accedidos) y el puerto por el cual se accede al servicio.
- Base de datos: De ellos se conoce el puerto por el cual se accede al servicio.

El gran problema surge cuando se dan cuenta que el equipo que lo estaba desarrollando no seguia buenas practicas de programacion. Parte del problema fue no seguir un estilo de programacion orientada a objetos adecuado. La otra gran parte fue que no testearon nada.

Por ello, la empresa decide contratar a usted para que desarrolle el modelado de los objetos que van a representar a cada servicio. Tomando como base el codigo desarrollado hasta ahora (en el archivo `parcial.wlk`).

1. Identificar todas las oportunidades de mejora del codigo actual, explicando (desde un punto teorico y practico) por que son oportunidades de mejora.
2. Implementar lo identificado en el punto anterior.
3. Realizar un testeo del codigo implementado. Sabiendo que el servicio de uptime debe poder responder si los servicios registrados estan disponibles o no.
- Un servicio web esta disponible cuando responde a la ruta `/health` con el estado `ok`.
- Un servicio base de datos esta disponible cuando tiene datos almacenados.
4. Agregar otro tipo de servicio al modelo de manera que se pueda monitorear su estado. La manera en la que se testea su disponibilidad debe ser distinta a la de los servicios web y base de datos.
5. Se desea conocer todos los servicios que no estan disponibles. Para ello se debera agregar la logica necesaria en el servicio de uptime. 