FROM node:alpine
WORKDIR /app
ADD package*.json ./
COPY . .
RUN npm install
ENV PORT 3000
EXPOSE $PORT  
CMD [ "node", "index.js", "dev"]