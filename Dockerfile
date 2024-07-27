# Étape de construction
FROM node:16 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de configuration et installer les dépendances
COPY package.json package-lock.json ./
RUN npm install

# Copier le reste des fichiers du projet et construire l'application
COPY . .
RUN npm run build

# Étape de production
FROM nginx:alpine

# Copier les fichiers construits de l'étape précédente
COPY --from=build /app/build /usr/share/nginx/html

# Exposer le port sur lequel Nginx fonctionne
EXPOSE 80

# Commande pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
