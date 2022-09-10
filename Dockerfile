FROM node:16.3.0-alpine AS dep

WORKDIR /app

RUN npm install -g npm@latest
RUN npm install pm2 -g

COPY package.json package-lock.json ./
RUN cd /app/ && \
    npm ci
# Bundle APP files
COPY . .

# Install app dependencies
ENV NPM_CONFIG_LOGLEVEL warn

# Show current folder structure in logs
RUN ls -al -R

CMD [ "pm2-runtime", "start", "app.json" ]