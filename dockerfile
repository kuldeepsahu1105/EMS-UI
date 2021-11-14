FROM node:latest as node
WORKDIR /app

COPY . .

ENV PATH /app/node_modules/.bin:$PATH

RUN yes | npm install
RUN yes | npm install --save core-js@^3 --unsafe 
RUN yes | npm install jquery --save --unsafe
RUN yes | npm install --save bootstrap --unsafe
RUN yes | npm install -g @angular/cli@latest --save --unsafe

COPY jquery-3.4.1.min.js /app/node_modules/bootstrap/dist/js/jquery-3.4.1.min.js

RUN npm run build --prod

#CMD ng serve --host 0.0.0.0

FROM nginx:latest
COPY --from=node /app/dist/my-employee-crud /usr/share/nginx/html
