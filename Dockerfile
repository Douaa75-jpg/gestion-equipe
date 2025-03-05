# Utilise l'image officielle de Node.js
FROM node:18 AS build

# Définit le répertoire de travail dans le conteneur
WORKDIR /app

# Copie le package.json et package-lock.json pour installer les dépendances
COPY package*.json ./

# Installe les dépendances backend
RUN npm install

# Copie le code source du backend
COPY . .

# Compile l'application NestJS
RUN npm run build

# Expose le port de l'API backend (3000 par défaut)
EXPOSE 3000

# Démarre l'application backend
CMD ["npm", "run", "start:prod"]
