# ClubTracker

Dashboard mis en place pour tracker l'activité des clubs de l'ENSAE Pierre Ndiaye de Dakar

# Développement
Ce projet a été développé en utilisant principalement Flask comme cadre de développement Web. Le tableau de bord utilise Python 3.11.9 comme langage pour les processus (core) et HTML, JS et CSS pour les pages (front).

## Comment lancer localement
L'application est construite sur Python 3.11.9. Une version de Python égale ou supérieure à celle-ci est nécessaire pour le projet construit. Notez que vous devriez probablement vous assurer que Python existe sur votre ordinateur et que sa version est >= 3.11.9.
Ouvrez un terminal sur votre machine et tapez <python --version>.

- Téléchargez d'abord le fichier zip du dépôt et décompressez-le localement.
- Naviguez jusqu'au dossier du projet : Ouvrez un terminal et naviguez jusqu'au dossier où le référentiel est décompressé.
- Créer un environnement virtuel : tapez <python -m venv env> : Cela créera un environnement virtuel dans un dossier nommé env.
- Activez l'environnement virtuel : 
Sous Windows : <.\env\Scripts\activate>
Sous macOS/Linux : « source env/bin/activate »

- Installer les paquets à partir du fichier requirements.txt : <pip install -r requirements.txt>
- Lancer l'application : <python app.py>

Vous devriez voir s'afficher l'application sur un port en localhost

