FROM nginx:mainline-alpine

LABEL traefik.enable=true
LABEL traefik.backend=www.robbast.nl
LABEL traefik.frontend.rule=Host:www.robbast.nl
LABEL traefik.port=8000
LABEL traefik.docker.network=traefik

WORKDIR /srv

COPY ["nginx.conf", "/etc/nginx/"]
COPY ["index.html", "me.jpg", "pubkey.asc", "robots.txt", "style.css", "/srv/"]

RUN touch /var/run/nginx.pid \
 && chown -R nginx /srv /var/cache/nginx /var/run/nginx.pid \
 && chmod 700 /srv \
 && chmod 600 /srv/*

USER nginx
