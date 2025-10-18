# --- Build Stage ---
FROM node:18-alpine as build
WORKDIR /app
COPY . .
RUN npm ci && npx quasar build

# --- Serve Stage ---
FROM nginx:alpine
COPY --from=build /app/dist/spa /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
