#!/bin/bash
IMAGE_NAME="mon-image-freestyle"
CONTAINER_NAME="mon-conteneur-freestyle"
PORT_HOTE="8083"
echo "=== Génération de la page web ==="
# La commande 'cat <<EOF > fichier' permet d'écrire du texte directement dans un fichier en Bash
cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"></head>
<body>
<h1>Bonjour depuis mon conteneur Docker
!</h1>
<p>Ce conteneur a été généré via un projet
Freestyle Jenkins (100% Bash, 0% Groovy
!).</p>
</body>
</html>
EOF
echo "=== Génération du Dockerfile ==="
cat <<EOF > Dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
EOF
echo "=== Construction de l'image Docker ==="
docker build -t $IMAGE_NAME .
echo "=== Nettoyage (Suppression de l'ancien
conteneur s'il existe) ==="
docker rm -f $CONTAINER_NAME || true
echo "=== Lancement du nouveau conteneur ==="
docker run -d -p $PORT_HOTE:80 --name $CONTAINER_NAME $IMAGE_NAME
echo "=== Terminé ! ==="

