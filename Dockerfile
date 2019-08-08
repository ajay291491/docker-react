#
# {{  Block for bulding the apps }}
#
# Pulling node:alpine image with a block alias 'build_instance'
FROM node:alpine as build
# |
# Setting up working directory
WORKDIR /app
# |
# Copy pakcage.json for npm install
COPY package.json .
# |
# Perform NPM install
RUN npm install
COPY . .
# |
# Performing React build
RUN npm run build
# |
# |
#
# {{ Block for Starting the Production version of application via nginx }}
#
# Pulling the nginx image
FROM nginx
EXPOSE 80
# |
# Copy the build image '/app/build' from Conatiner with block alias 'build_instance' to nginix  document root
RUN mkdir -p /usr/share/nginx/html
COPY --from=build /app/build /usr/share/nginx/html/
