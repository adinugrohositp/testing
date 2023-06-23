### STAGE 1:BUILD ###
# Defining a node image to be used as giving it an alias of "build"
# Which version of Node image to use depends on project dependencies
# This is needed to build and compile our code
# while generating the docker image
# FROM node:18.12-alpine AS build
# Create a Virtual directory inside the docker image
FROM tkddev2:89/lib/nginx:lates AS ngi
WORKDIR /dist/src/app
# Copy files to virtual directory
# COPY package.json package-lock.json ./
# Run command in Virtual directory
# RUN npm cache clean --force
# Copy files from local machine to virtual directory in docker image
COPY . .
# RUN npm config rm proxy
# RUN npm config rm https-proxy
# RUN npm config set registry https://registry.npmjs.org/
# RUN npm config set registry https://skimdb.npmjs.com/registry -g
# RUN npm config set fetch-retries 10 -g
# RUN rm -rf package-lock.json
# RUN rm -rf yarn.lock
# RUN npm config set ssl-strict=false
# RUN npm install --registry http://registry.npmjs.org/ --prefer-offline --no-audit --force --without-ssl --insecure
# RUN npm install --registry https://skimdb.npmjs.com/registry --prefer-offline --no-audit --force --without-ssl --insecure
# RUN npm run build --prod


### STAGE 2:RUN ###
# Defining nginx image to be used
# FROM nginx:latest AS ngi
# Copying compiled code and nginx config to different folder
# NOTE: This path may change according to your project's output folder
# COPY ./dist/* /usr/share/nginx/html
# COPY ./dist/* /usr/share/nginx/html/tkd/
COPY ./dist/ /usr/share/nginx/html/tkd/
# COPY ./dist/ubold-angular/tkd /usr/share/nginx/html/tkd/
COPY ./nginx.conf  /etc/nginx/conf.d/default.conf
# Exposing a port, here it means that inside the container
# the app will be using Port 80 while running
EXPOSE 7000
