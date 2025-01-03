# Stage 1: Build Stage
FROM node:16 AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .

# Stage 2: Runtime Stage
FROM nginx:alpine
COPY --from=builder /app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
