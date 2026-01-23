FROM node:18-alpine as builder

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci --only=production=false

COPY . .

RUN  npm run build

FROM nginx:alpine

RUN addgroup -g 1000 appuser && adduser -D -u 1000 -G appuser appuser

COPY --from=builder /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/cache/nginx /var/log/nginx /var/run && \
    chown -R appuser:appuser /usr/share/nginx/html && \
    chown -R appuser:appuser /var/cache/nginx && \ 
    chown -R appuser:appuser /var/log/nginx && \
    chown -R appuser:appuser /etc/nginx/conf.d && \ 
    touch /var/run/nginx.pid && \ 
    chown -R appuser:appuser /var/run/nginx.pid

USER appuser
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
