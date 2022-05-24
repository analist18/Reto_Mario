#Se instala un Java con un Alpine en la menor version existente#
FROM openjdk:8-jre-alpine

RUN apk add --no-cache tzdata
ENV TZ='America/Lima'
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install
RUN apk --update add fontconfig ttf-dejavu

#Directorio de trabajo
WORKDIR /

RUN mkdir app && chmod 777 app
COPY target/backend-SNAPSHOT.jar /app
WORKDIR /app

#Exponemos el puerto 8080
EXPOSE 8080

#Para que empiece a desplegarse
CMD ["java","-jar","backend-0.0.1-SNAPSHOT.jar"]