# Multi-stage Dockerfile for Quasar Application
# Optimized for AMD64 builds

# --- Build Stage ---
FROM node:20-alpine AS build

WORKDIR /app
COPY . .

# Clean npm install and build
RUN npm ci --no-audit --no-fund && \
    npx quasar build

# --- Serve Stage ---
FROM nginx:alpine

# Copy built application
COPY --from=build /app/dist/spa /usr/share/nginx/html

# Simple nginx config for SPA
RUN echo 'server { \
    listen 80; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
