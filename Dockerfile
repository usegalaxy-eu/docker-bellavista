FROM jlesage/baseimage-gui:ubuntu-22.04-v4.4.2 AS build

LABEL maintainer="Amirhossein N. Nilchi <nilchia@informatik.uni-freiburg.de>"

RUN apt-get update -y && \
    apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        libgl1 \
        qt5dxcb-plugin \
        libxcb-xinerama0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-randr0 \
        libxcb-render-util0 \
        libxcb-xkb1 \
        libxkbcommon-x11-0 \
        python3 \
        python3-pip \
        python3-venv \
        wget && \
    rm -rf /var/lib/apt/lists/*

ARG VERSION=0.0.2

RUN mkdir -p /opt/bellavista &&\
    chmod 777 /opt/bellavista &&\
    cd /opt/bellavista/ && \
    wget -q https://pypi.org/packages/source/b/bellavista/bellavista-$VERSION.tar.gz &&\
    python3 -m venv bellavista && \
    chmod -R 755 bellavista/bin && \
    chmod +x bellavista/bin/activate && \
    . bellavista/bin/activate && \
    pip install bellavista-0.0.2.tar.gz && \
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
ENV DISPLAY=:0
ENV QT_DEBUG_PLUGINS=1
ENV KEEP_APP_RUNNING=1
ENV TAKE_CONFIG_OWNERSHIP=1
