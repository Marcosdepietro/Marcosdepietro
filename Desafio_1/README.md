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
| Dato  | Descripción |
| ------------- |:-------------:|
| Login      | Es un identificador único que se compone del nombre y el apellido |
| Nombre y Apellido    | Nombre y Apellido del usuario |
| Departamento      | Este es el grupo que corresponde al área del usuario. Estos grupos son contabilidad, finanzas, tecnología. |

2. Requiere que la automatización generé un password temporal que sea asignado al usuario, que luego el 
usuario final deberá cambiar en el primer inicio de sesión.
3. El operador requiere que pueda obtener la password temporal para copiarla y enviarla por email al usuario 
final.



El pipeline de tiene 3 parametros, dos de ellos String (nombre y apellido) y el tercero es un tipo Choice (contabilidad, finanzas, tecnologia).

En el script se utiliza la variable de “environment” USER_NAME, que concatena los parámetros nombre y apellido ingresados previamente,
separados por un guion bajo para formar el nombre de usuario final.

Luego en el stage de “Crear password temporal” se genera la contraseña temporal random.

Se muestra el usuario, la contraseña y el grupo elegido.

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
