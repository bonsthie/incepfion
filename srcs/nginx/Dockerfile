FROM debian:bullseye

RUN apt update  && apt install -y nginx openssl zsh && mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -out /etc/nginx/ssl/certificate.crt -keyout /etc/nginx/ssl/certificate.key -subj "/C=FR/ST=IDF/L=Angouleme/O=42/OU=42/CN=babonnet.42.fr/UID=babonnet" 

RUN mkdir -p var/run/nginx

COPY nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
