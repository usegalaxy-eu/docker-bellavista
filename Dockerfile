FROM jlesage/baseimage-gui:ubuntu-22.04-v4.4.2 AS build

LABEL maintainer="Amirhossein N. Nilchi <nilchia@informatik.uni-freiburg.de>"

# install dependencies
RUN apt-get update -y && \
    apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libgl1 \
        qt5dxcb-plugin \
        python3 \
        python3-pip \
        python3-venv \
        wget && \
    rm -rf /var/lib/apt/lists/*

# Install BellaVista
ARG VERSION=0.0.2

RUN mkdir -p /opt/bellavista &&\
    chmod 777 /opt/bellavista &&\
    cd /opt/bellavista/ && \
    wget -q https://pypi.org/packages/source/b/bellavista/bellavista-$VERSION.tar.gz &&\
    python3 -m venv bellavista && \
    chmod -R 755 bellavista/bin && \
    . bellavista/bin/activate && \
    pip install bellavista-$VERSION.tar.gz && \
    rm bellavista-$VERSION.tar.gz

# Generate and install favicons.
RUN APP_ICON_URL=https://bellavista.readthedocs.io/en/latest/_static/bellavista_logo_favicon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Set up Python virtual environment as default
ENV PATH="/opt/bellavista/bellavista/bin:$PATH"
ENV VIRTUAL_ENV="/opt/bellavista/bellavista"

# Add virtual environment activation to startup
RUN echo '. /opt/bellavista/bellavista/bin/activate' >> /etc/cont-init.d/50-bellavista-setup.sh && \
    chmod +x /etc/cont-init.d/50-bellavista-setup.sh

EXPOSE 5800

COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

ENV APP_COMMAND=/startapp.sh

# Set the name of the application.
ENV APP_NAME="bellavista"