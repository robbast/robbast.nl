FROM nginx:mainline-alpine

LABEL traefik.enable=true
LABEL traefik.backend=www.robbast.nl
LABEL traefik.frontend.rule=Host:www.robbast.nl
LABEL traefik.port=80
LABEL traefik.docker.network=traefik

WORKDIR /srv/http

COPY ["nginx.conf", "/etc/nginx/"]
COPY ["index.html", "me.jpg", "pubkey.asc", "robots.txt", "style.css", "/srv/http/"]

RUN chown -R nginx /srv/http \
 && chmod 700 /srv/http \
 && chmod 600 /srv/http/*
