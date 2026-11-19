#!/bin/bash
# Auto-publicacion: lo ejecuta un cron en cPanel cada 15 min.
# Solo copia si hay cambios nuevos en GitHub. Nunca borra archivos del servidor.
REPO="$HOME/repositories/landing"
DEST="$HOME/public_html/jugadorestrella.com"
cd "$REPO" || exit 1
OLD=$(git rev-parse HEAD)
git pull -q origin main || exit 1
NEW=$(git rev-parse HEAD)
[ "$OLD" = "$NEW" ] && [ "$1" != "--force" ] && exit 0
/bin/cp -f index.html partners.html favicon.ico apple-touch-icon.png icon-192.png icon-512.png icon.svg site.webmanifest "$DEST/"
/bin/cp -Rf images gallery videos descargas "$DEST/"
echo "$(date '+%F %T') publicado $NEW" >> "$HOME/landing-deploy.log"
