FROM n8nio/n8n:latest

USER root

RUN ARCH=$(uname -m) && \
    wget -qO- "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/" | \
    grep -o 'href="apk-tools-static-[^"]*\.apk"' | head -1 | cut -d'"' -f2 | \
    xargs -I {} wget -q "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/{}" && \
    tar -xzf apk-tools-static-*.apk && \
    ./sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/latest-stable/main \
    -U --allow-untrusted add apk-tools && \
    rm -rf sbin apk-tools-static-*.apk

RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    xvfb

# Installer puppeteer‑real‑browser (sans puppeteer global)
RUN npm install -g \
    puppeteer-real-browser \
    puppeteer-core \
    puppeteer-extra-plugin-stealth \
    rebrowser-patches \
    cheerio

# Variables Puppeteer / puppeteer‑real‑browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer-real-browser,puppeteer-extra,puppeteer-extra-plugin-stealth,rebrowser-patches,cheerio

# Répertoires n8n
RUN mkdir -p /home/node/.n8n/nodes && \
    mkdir -p /home/node/.cache/puppeteer && \
    chown -R node:node /home/node

# Retour en node et travail dans le bon répertoire
USER node
WORKDIR /home/node
