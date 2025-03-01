# Menggunakan image Node.js
FROM node:16-buster-slim

# Set working directory
WORKDIR /app

# Copy semua file ke dalam container
COPY . .

# Install dependencies
RUN npm install

# Build aplikasi React
RUN npm run build

# Jalankan aplikasi
CMD ["npm", "start"]
