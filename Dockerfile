FROM node:12

RUN mkdir /app
WORKDIR /app

COPY . .

EXPOSE 3000

CMD ["tail", "-f", "/dev/null"]