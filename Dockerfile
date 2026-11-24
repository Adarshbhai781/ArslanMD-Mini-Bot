FROM node:20-bookworm-slim

ENV NODE_ENV=production \
    PORT=10000

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
      git ffmpeg python3 make g++ \
    && rm -rf /var/lib/apt/lists/*

COPY package.json ./
RUN npm install --omit=dev --no-audit --no-fund || npm install --no-audit --no-fund

COPY . .

# session folder for Baileys auth state
RUN mkdir -p session data

EXPOSE 10000

CMD ["node", "index.js"]
