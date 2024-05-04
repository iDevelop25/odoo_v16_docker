# Uso de una imagen base de Ubuntu 22.04
FROM ubuntu:22.04

# Metadatos del creador
LABEL Creator="Johannes Moreno"

# Evitar interacciones durante la instalación de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar el índice de paquetes e instalar dependencias
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    openssh-server \
    fail2ban \
    nano \
    wget \
    gdebi-core \
    git \
    npm \
    python3-dev \
    libxml2-dev \
    libxslt-dev \
    libevent-dev \
    libsasl2-dev \
    libldap2-dev \
    libpq-dev \
    libjpeg-dev \
    poppler-utils \
    unoconv \
    default-jre \
    libreoffice \
    libreoffice-script-provider-python \
    postgresql-client \
    wkhtmltopdf \
    tzdata  # Instala tzdata para configurar la zona horaria

# Configura la zona horaria de Colombia
RUN ln -fs /usr/share/zoneinfo/America/Bogota /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Instalar paquetes a través de pip sin caché interactivo
RUN apt-get install -y python3-pip && \
    pip3 install --no-cache-dir \
    ptvsd \
    lxml-html-clean \
    libsass \
    phonenumbers

# Copiar archivo de requisitos y renombrarlo
COPY .requirements /opt/odoo/src/requirements.txt

# Instalar los requisitos de Odoo
RUN pip3 install --no-cache-dir -r /opt/odoo/src/requirements.txt

# Configurar usuario Odoo
RUN adduser --disabled-password --gecos "Odoo" odoo && \
    mkdir -p /opt/odoo && \
    chown -R odoo:odoo /opt/odoo

# Copiar archivo de configuración de Odoo al directorio src/
COPY .odoorc /opt/odoo/src/

# Configurar directorio de trabajo
WORKDIR /opt/odoo

# Configurar LibreOffice como servicio
RUN echo '#!/bin/bash' > /etc/init.d/office && \
    echo '/usr/bin/libreoffice --headless --accept="socket,host=localhost,port=8100,tcpNoDelay=1;urp;" &' >> /etc/init.d/office && \
    chmod +x /etc/init.d/office && \
    update-rc.d office defaults && \
    service office start

# CMD predeterminado para ejecutar Odoo
CMD ["/usr/local/bin/odoo-bin", "-c", "/opt/odoo/.odoorc"]
