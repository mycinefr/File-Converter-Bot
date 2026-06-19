FROM python:3.10-slim

# Installation des dépendances système requises pour les conversions locales
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libreoffice \
    calibre \
    imagemagick \
    tesseract-ocr \
    p7zip-full \
    g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Installation des dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt [cite: 3]

# Copie du reste des fichiers du bot
COPY . .

# Droits d'exécution sur les utilitaires locaux restants
RUN chmod +x tgsconverter

# Lancement simultané de Flask et du Bot
CMD flask run -h 0.0.0.0 -p 10000 & python3 main.py
