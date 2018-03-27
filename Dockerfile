FROM scratch

COPY --from=nginx:mainline-alpine / /

LABEL traefik.enable=true
LABEL traefik.backend=www.robbast.nl
LABEL traefik.frontend.rule=Host:www.robbast.nl,robbast.nl,www.robbast.eu,robbast.eu,www.robbast.xyz,robbast.xyz
LABEL traefik.port=8000

RUN apk add --no-cache curl
HEALTHCHECK --interval=1m --timeout=3s \
 CMD curl --fail --head http://localhost:8000/index.html || exit 1

WORKDIR /srv

COPY ["nginx.conf", "/etc/nginx/"]
COPY ["index.html", "me.jpg", "pubkey.asc", "robots.txt", "style.css", "/srv/"]

RUN touch /var/run/nginx.pid \
 && chown -R nginx /srv /var/cache/nginx /var/run/nginx.pid \
 && chmod 700 /srv \
 && chmod 600 /srv/*

STOPSIGNAL SIGTERM
EXPOSE 8000
USER nginx

CMD ["nginx", "-g", "daemon off;"]
