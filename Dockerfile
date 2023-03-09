FROM node:alpine
WORKDIR /app
ADD package*.json ./
COPY . .
#RUN npm install

ARG NODE_ENV
RUN if [ "$NODE_ENV" = "development" ]; \
        then npm install; \
        else npm install --only=production; \
        fi

ENV PORT 3000
EXPOSE $PORT  
CMD [ "node", "index.js", "dev"]