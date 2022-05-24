FROM nginx
LABEL maintainer="Mantenedor NGINX"
VOLUME /usr/share/nginx/html
VOLUME /etc/nginx
COPY /home/Stefanny/Desktop/ExamAgileOpsEngineer/nginx_configuration/nginx /etc/nginx/
COPY --from=build /app/build /usr/share/nginx/html
#Logs para troubleshooting
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
EXPOSE 8080
CMD ["nginx"]