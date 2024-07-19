FROM node:20-alpine AS builder

# Update and add ruby
RUN apk -U --no-cache upgrade && \
    apk add ruby

# Add bundler
RUN gem install bundle

# Set-up env vars
ENV PORT 4001 \
    ENV ASTRO_TELEMETRY_DISABLED=1

WORKDIR /app

# Copy everything for now
# [TODO] Should be slimmmed down (also use 2nd stage - app only)
COPY . .

# Install dependencies
RUN yarn install
RUN bundle install

# Start
ENTRYPOINT [ "yarn", "run", "dev" ]
