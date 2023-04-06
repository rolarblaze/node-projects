# Use a specific version of Node.js as the base image
FROM node:16.20-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy the package files and install dependencies
COPY package.json package-lock.json /app/
RUN npm install --production

# Copy the source code and build the application
COPY src /app/src
RUN npm install webpack --save-dev

# Create a new image with only the necessary files
#FROM node:14-alpine 

#WORKDIR /app 
#COPY --from=builder /app/dist .
EXPOSE 3000

#USER node
#ARG NODE_ENV=production 
#ENV NODE_ENV=$NODE_ENV

# Start the application 
# CMD ["npm", "run", "start:production"]
CMD ["npm", "run", "dev"]


