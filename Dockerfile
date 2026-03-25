FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    xvfb \
    libasound2 \
    libxss1 \
    libgconf-6 \
    libgtk-3-0 \
    libxcomposite1 \
    libxrandr2 \
    libxdamage1 \
    libxfixes3 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    dbus \
    at-spi2-atk \
    libdrm \
    mesa-gbm \
    libxkbcommon \
    libatspi \
    libgbm1 \
    cups-libs \
    libxshmfence \
    libxrandr \
    libxss \
    libxcursor \
    libxcomposite \
    libxdamage \
    libxfixes \
    libxi \
    libxtst \
    alsa-lib \
    pango \
    cairo \
    gdk-pixbuf \
    shared-mime-info

RUN npm install -g \
    puppeteer \
    puppeteer-core \
    puppeteer-real-browser \
    puppeteer-extra \
    puppeteer-extra-plugin-stealth \
    puppeteer-extra-plugin-user-data-dir \
    puppeteer-extra-plugin-anonymize-ua \
    rebrowser-patches \
    puppeteer-autoscroll-down

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    PUPPETEER_CACHE_DIR=/tmp \
    NODE_ENV=production

RUN mkdir -p /home/node/.n8n/nodes /home/node/.cache/puppeteer && \
    chown -R node:node /home/node

USER node
WORKDIR /home/node
