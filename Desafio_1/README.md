# Desafio 1

### Objetivo
Este desafío tiene como objetivo desarrollar un pipeline declarativo en Jenkins que nos permite crear usuarios 
dentro de un sistema linux

### Escenario
El área de seguridad cuenta con un equipo que tiene la responsabilidad de gestionar la creación de usuarios y 
baja de usuarios en los sistemas de la empresa. Debido a que en el último tiempo hay muchos ingresos 
algunos operadores cometieron algunos errores y debido a esto nos encomendaron generar un job en jenkins 
que permita generar estos usuarios.

### Requisitos

1. El operador de seguridad desea que el al momento de crear el usuario se tomen estos datos de entrada:
![image](https://github.com/user-attachments/assets/0f43732b-d4ab-4190-914c-8c7194b0c321)

2. Requiere que la automatización generé un password temporal que sea asignado al usuario, que luego el 
usuario final deberá cambiar en el primer inicio de sesión.
3. El operador requiere que pueda obtener la password temporal para copiarla y enviarla por email al usuario 
final.

### Desarrollo:

El pipeline de tiene 3 parametros, dos de ellos String (nombre y apellido) y el tercero es un tipo Choice (contabilidad, finanzas, tecnologia):

https://github.com/Marcosdepietro/Marcosdepietro/blob/22f8043b67c27ea5abec8beaad945233e1c23a6c/Desafio_1/Jenkinsfile#L4-L8


En el script se utiliza la variable de “environment” USER_NAME, que concatena los parámetros nombre y apellido ingresados previamente,
separados por un guion bajo para formar el nombre de usuario final:

https://github.com/Marcosdepietro/Marcosdepietro/blob/91dd60fc4c05cd5f8035ce9cce3c1700d3ac48cb/Desafio_1/Jenkinsfile#L10-L13


Luego en el stage de “Crear password temporal” se genera la contraseña temporal random:

https://github.com/Marcosdepietro/Marcosdepietro/blob/91dd60fc4c05cd5f8035ce9cce3c1700d3ac48cb/Desafio_1/Jenkinsfile#L21


Se muestra el usuario, la contraseña y el grupo elegido.

https://github.com/Marcosdepietro/Marcosdepietro/blob/91dd60fc4c05cd5f8035ce9cce3c1700d3ac48cb/Desafio_1/Jenkinsfile#L22


Y se ejecutan los siguientes comandos (todo con permisos de root):
•	Se crea el grupo (forzosamente) 

https://github.com/Marcosdepietro/Marcosdepietro/blob/91dd60fc4c05cd5f8035ce9cce3c1700d3ac48cb/Desafio_1/Jenkinsfile#L23


•	Se agrega el usuario con su Home

https://github.com/Marcosdepietro/Marcosdepietro/blob/91dd60fc4c05cd5f8035ce9cce3c1700d3ac48cb/Desafio_1/Jenkinsfile#L24


•	Se agrega el usuario al grupo

https://github.com/Marcosdepietro/Marcosdepietro/blob/91dd60fc4c05cd5f8035ce9cce3c1700d3ac48cb/Desafio_1/Jenkinsfile#L25


•	Se setea la contraseña previamente generada

https://github.com/Marcosdepietro/Marcosdepietro/blob/91dd60fc4c05cd5f8035ce9cce3c1700d3ac48cb/Desafio_1/Jenkinsfile#L26


•	Y por último se configura la contraseña para que sea cambiada en el siguiente inicio de sesión

https://github.com/Marcosdepietro/Marcosdepietro/blob/91dd60fc4c05cd5f8035ce9cce3c1700d3ac48cb/Desafio_1/Jenkinsfile#L27
