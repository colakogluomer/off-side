FROM node:16

WORKDIR /backend

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json /backend/
RUN npm install -g nodemon
RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

COPY . /backend/
