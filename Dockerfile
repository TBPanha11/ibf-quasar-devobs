# Use multi-platform base image with Node 20
FROM --platform=$BUILDPLATFORM node:20-alpine AS build

# Set build arguments
ARG BUILDPLATFORM
ARG TARGETPLATFORM

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Build the Quasar app
RUN npm run build

# Production stage - use multi-platform nginx
FROM --platform=$TARGETPLATFORM nginx:alpine

# Copy built app
COPY --from=build /app/dist/spa /usr/share/nginx/html

# Copy nginx config if you have one
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
