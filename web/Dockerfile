FROM nginx 

COPY nginx.conf /etc/nginx.conf
#COPY nginx/certs etc/nginx/ssl

#COPY ./nginx/crt/mkcert_development_CA_169063637024374089507269603795709268942.crt /usr/local/share/ca-certificates/certificate.crt

#RUN update-ca-certificates

COPY . /usr/share/nginx/html

EXPOSE 8080
