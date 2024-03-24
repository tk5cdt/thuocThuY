FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
COPY . .
RUN npm install -g npm@10.5.0
RUN apk add --update python3 make g++ && rm -rf /var/cache/apk/*
RUN npm install --force

CMD ["npm", "start"]

EXPOSE 3000