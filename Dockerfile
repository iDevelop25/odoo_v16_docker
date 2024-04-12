FROM ubuntu:20.04
LABEL Creator: "Johannes Moreno"

RUN apt-get update \
    && apt-get upgrade -y

RUN apt-get install -y \
    openssh-server fail2ban

#RUN adduser --system --home=/opt/odoo --group odoo
RUN adduser --disabled-password --gecos "Odoo" odoo

RUN apt-get install -y \
    python3-pip

RUN apt-get update \
    && \
    apt-get install -y npm \
    && \
    npm install -g less less-plugin-clean-css \
    && \
	apt-get install -y node-less
	
RUN apt-get update \
    && \
    apt-get install -y \
    nano

RUN mkdir /opt/odoo

WORKDIR /opt/odoo

COPY src/requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt
RUN apt-get update \
    && \
    apt-get install -y \
    python3-dev \
    python3-pip \
    libxml2-dev \
    libxslt1-dev \
    libevent-dev \
    libsasl2-dev \
    libldap2-dev \
    libpq-dev \
    libjpeg-dev \
    poppler-utils \
    node-less \
    node-clean-css

RUN apt-get install -y wget gdebi-core

RUN pip3 install lxml_html_clean


RUN pip3 install libsass==0.20.1

#RUN apt-get -f install -y

RUN apt install python3-daemonize

RUN pip3 install phonenumbers

RUN apt-get install git -y

RUN python3 -m pip install --upgrade pip


RUN apt-get install -y unoconv

RUN pip3 install pandas

RUN pip install pylint --no-cache-dir
RUN pip install zeep --no-cache-dir
RUN pip install workalendar --no-cache-dir
RUN pip install erppeek --no-cache-dir
RUN pip install ics==0.5 --no-cache-dir	 
RUN pip install DateTime --no-cache-dir
RUN pip install ZODB --no-cache-dir
RUN pip install unoconv --no-cache-dir
RUN pip install appy
RUN pip install treepoem --no-cache-dir
RUN pip3 install pyPDF3 --no-cache-dir
RUN pip3 install numpy --no-cache-dir
RUN pip install Unidecode
RUN pip install py-moneyed
RUN pip install PyPDF2
RUN pip install passlib
RUN pip install Werkzeug
RUN pip install decorator
RUN pip install psutil
RUN pip install jinja2
RUN pip install reportlab
RUN pip install polib==1.1.0
RUN pip3 install pyopenssl==20.0.1
RUN pip3 install cryptography==3.4.8

RUN apt-get install default-jre -y

RUN apt-get install libreoffice libreoffice-script-provider-python -y
RUN echo '#!/bin/sh' | tee /etc/init.d/office
RUN echo '/usr/bin/libreoffice --headless --accept="socket,host=localhost,port=8100,tcpNoDelay=1;urp;"&' | tee -a /etc/init.d/office
RUN chmod +x /etc/init.d/office
RUN update-rc.d office defaults
RUN /etc/init.d/office

RUN apt install unoconv -y

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb

RUN apt install -y ./wkhtmltox_0.12.5-1.bionic_amd64.deb

RUN apt-get update

RUN apt-get install -y postgresql-client

RUN pip install psycopg2-binary

# Asegúrate de configurar el directorio de trabajo correctamente
WORKDIR /opt/odoo

# Instalar el paquete python3-ldap
RUN apt-get install -y python3-ldap




# Copia tu archivo .odoorc al directorio /opt/odoo (asegúrate de que el archivo .odoorc esté presente)
COPY .odoorc /opt/odoo/.odoorc

# CMD se utiliza para proporcionar comandos predeterminados para un contenedor en ejecución
CMD ["/opt/odoo/odoo-bin", "-c", "/opt/odoo/.odoorc"]