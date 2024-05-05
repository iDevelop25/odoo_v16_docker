# Creación Instancia de Odoo 16 con Docker

## Detalles:

- Ubuntu 22.04
- Odoo 16
- Postgres 14

## Requisitos:

- Docker Compose (Obligatorio)
  [Instalar Docker Compose](https://docs.docker.com/compose/)
- Instalar Docker Desktop (Recomentado)
  [Instalar Docker Desktop](https://docs.docker.com/get-docker/)

## Clonando proyecto odoo_v16_docker

Vamos a clonar primero el repositorio que he creado configurado con todos los requirements necesarios.

Dentro del directorio donde vayan a trabajar vamos a ejecutar:
`git clone https://github.com/iDevelop25/odoo_v16_docker.git`

## Clonando codigo fuente de Odoo 16

Una vez clonado el repositorio odoo_v16_docker vamos a entrar a nuestro proyecto con `cd odoo_v16_docker` , luego de estar en la raiz del proyecto; creamos una carpeta llamada `src` entramos a `src` con `cd src` y unavez en src ejecutamos `git clone https://github.com/odoo/odoo.git --branch 16.0 --depth 1 --single-branch .`

## Construyendo la Imagen Base

- Nos vamos a la raiz del proyecto donde se encuentran los archivos `Dockerfile` y `docker-compose.yml`. Una vez estemos ubicados en la raiz ejecutamos el siguiente comando `docker build --no-cache -t odoo16-ubuntu22.04 .`, esperamos que nos construya todo sin errores.
- Una vez hayamos terminado el proceso de construir la imagen base, procedemos a levantar el contenedor con el comando `docker compose up`.
- Luego de haber levantado e contenedor vamos a nuestro navegador a la url `http://localhost:8016`

Con esto podremos levantar nuestra instancia de Odoo 16 en Docker.

---

¡Gracias por visitar mi repositorio! 🚀<br>
No olvides suscribirte a mi [canal de YouTube](https://www.youtube.com/channel/UCEnZOVwwMt-entEufOlmL6g){:target="\_blank" rel="noopener noreferrer"} para más contenido. 📺
Regálame una ⭐️ al repositorio si te fue útil.
