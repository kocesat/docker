FROM node:14.16.0-alpine3.13
# RUN command executed at the time of building the docker image
RUN addgroup app && adduser -S -G app app
USER app
# creating a working directory in the home directory of app user
WORKDIR /app/
# create a new directory with the user app to persist to a volume later
RUN mkdir data
# copy specific file (not often changed) to the working directory
COPY package*.json .
RUN npm install
# copy everything of the project root (where Dockerfile is) to the working dir
COPY . .
# If you use ADD command zippedFile is decompressed at the time of building image 
# ADD zippedFile.zip 
ENV API_URL=http://api.myapp.com/
EXPOSE 3000
# CMD instructions executed at the time of starting the container
# shell form - executed inside a seperate shell /bin/sh overridable
# CMD npm start
# exec form - uses already running shell, overridable
CMD ["npm", "start"]
# runs at the start the of the container again but cannot be overridden
ENTRYPOINT ["npm", "start"]
