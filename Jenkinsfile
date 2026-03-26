pipeline {
    agent any
    environment {

    // Définition de variables pour le nommage
    IMAGE_NAME = 'mon-image-web-locale'
    CONTAINER_NAME ='mon-conteneur-web-local'
     PORT_HOTE = '8082' // Le port sur lequel on accèdera au site
    }
    stages {
        stage('Génération des fichiers'){
             steps {
                echo 'Création de la page web index.html à la volée...' 
                // La commande writeFile crée un fichier dans l'espace de travail de Jenkins
                writeFile file: 'index.html', text: '''
                <!DOCTYPE html>
                <html>
                <head><metacharset="UTF-8"></head>
                <body>
                <h1>Bonjour depuis mon conteneur Docker ! 🐳</h1>
                <p>Ce conteneur a été généré 100% localement par Jenkins, sans aucun Git !</p>
                </body>
                </html>
                '''
                echo 'Création du Dockerfile à la volée...' 
                writeFile file: 'Dockerfile', text: ''' 
                FROM nginx:alpine
                COPY index.html /usr/share/nginx/html/index.html
                EXPOSE 80
                '''
            }
        }
        stage('Build Image Docker') {
            steps {
                 echo 'Construction de l\'image Docker en local...'  // Le point (.) à la fin indique à Docker de chercher le Dockerfile dans le dossier courant
                 sh 'docker build -t ${IMAGE_NAME} .'
                }
        }          

        stage('Nettoyage') {
            steps {
                echo 'Suppression de l\'ancien conteneur s\'il tourne déjà...'
                 // Le "|| true" évite que le job plante si c'est la première fois qu'on le lance
                 sh 'docker rm -f ${CONTAINER_NAME} || true'
            }
        }

        stage('Lancement du Conteneur') {
            steps {
                echo 'Démarrage du nouveau conteneur...'
                sh 'docker run -d -p ${PORT_HOTE}:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}'
            }
        }
    }
 }
