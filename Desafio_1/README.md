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
