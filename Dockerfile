FROM node:alpine

WORKDIR /express-app

COPY src/package.json .

RUN npm install

COPY . .

EXPOSE 3000

CMD [ "node", "src/index.js" ]


# This Dockerfile sets up a Node.js environment, installs dependencies, 
# and prepares the application to run inside a container, listening on port 3000