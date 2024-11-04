# Desafio 2

## Objetivo
Este desafío tiene como objetivo realizar la configuración de un webhook en un repositorio de Github y también 
crear un simple pipeline para ejecutar un build y testear un proyecto nodejs.

## Escenario
Nuestra organización nos encomendó la tarea de realizar una prueba de concepto para crear un CI/CD de 
nodejs, necesitan entender cómo se debe realizar el proceso de build para una API hecha en nodejs. Por este 
motivo, nos entregaron una aplicación de ejemplo hecha en esta tecnología, este proyecto cuenta con una 
prueba integrada hecha en la herramienta Jest propia de este framework de desarrollo. El referente de 
desarrollo, nos encargó realizar la configuración de un webhook que permita hacer un build automático cada 
vez que se produzca un push o un pull request, esto puede ayudar para automatizar la ejecución del job para 
este CI/CD.

## Requisitos

1. Crear un fork de un repo con una app de NodeJs

2. Realizar la configuración del github webhook para inicializar el job cada vez que se produce un push o un se 
crea un PR. 
3. Exponer mediante ngrok el servicio de Jenkins
4. Elaborar un jenkins pipeline para que ejecute los pasos para desarrollo, tomar las instrucciones del 
README.md.

## Desarrollo:

### NGROK

* Primero se debe instalar ngrok desde https://ngrok.com/ y crear una cuenta
* Desde una instancia en Ubuntu, clonar el repositorio mediante el comando “git clone 
https://github.com/edgaregonzalez/nodejs-helloworld-api.git”
* Desde la pagina de ngrok ir a Linux, copiar y pegar el codigo para instalarlo:

curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
&& echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
| sudo tee /etc/apt/sources.list.d/ngrok.list \
&& sudo apt update \
&& sudo apt install ngrok

*Luego correr el siguiente comando para agregar tu token
ngrok config add-authtoken <token>
*Para levantar el servicio de ngork ejecutar lo siguiente
ngrok http http://localhost:808
*ir a la URL de Forwarding e iniciar sesión en Jenkins

#### Configurar el Webhook de Github:
*Vamos a Settings dentro de nuestro Fork del proyecto y agregamos un nuevo Webhook
*En Payload URL ingresamos la URL de Forwarding
*En Content Type seleccionamos "application/json"
*En las acciones seleccionamos Pull request y Pushes

### Jenkins



