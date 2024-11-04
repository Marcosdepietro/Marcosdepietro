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
![image](https://github.com/user-attachments/assets/cfa11997-ede5-4de6-9b30-ecd655931b14)


En el script se utiliza la variable de “environment” USER_NAME, que concatena los parámetros nombre y apellido ingresados previamente,
separados por un guion bajo para formar el nombre de usuario final:
![image](https://github.com/user-attachments/assets/aadc36bd-6a93-44ae-83c1-495e2ef91548)


Luego en el stage de “Crear password temporal” se genera la contraseña temporal random:
![image](https://github.com/user-attachments/assets/6c701dfd-ead0-4116-9158-5c1f1d5e1046)

Se muestra el usuario, la contraseña y el grupo elegido.
![image](https://github.com/user-attachments/assets/137e2538-8e3e-4a52-8d5b-be367ca16b7d)

Y se ejecutan los siguientes comandos (todo con permisos de root):
•	Se crea el grupo (forzosamente) 
	sh "sudo groupadd -f ${params.depto}"

•	Se agrega el usuario con su Home
	sh "sudo useradd -m ${env.USER_NAME}"

•	Se agrega el usuario al grupo
	sh "sudo usermod -aG ${params.depto} ${env.USER_NAME}"

•	Se setea la contraseña previamente generada
	sh "echo ${env.USER_NAME}:${contra} | sudo chpasswd"

•	Y por último se configura la contraseña para que sea cambiada en el siguiente inicio de sesión
	sh "sudo passwd -e ${env.USER_NAME}"
