#!/bin/bash

# Obtener la ruta del script (directorio donde está ubicado)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# echo "HOLA $SCRIPT_DIR"

COMMIT_MSG="Subida automatica utilizando bash"
LOG_FILE= "$SCRIPT_DIR/subida.log"

# Verificar si el archivo de log existe, si no, crearlo
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"  # 🔹 Crea el archivo vacío
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Log creado" >> "$LOG_FILE"
fi

# Moverse al repositorio
cd "$SCRIPT_DIR" || { echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: No se pudo acceder al repositorio" >> "$LOG_FILE"; exit 1; }


# Iniciar log con fecha y hora
echo "🕒 Inicio de ejecución: $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG_FILE"


# AGREGAR EL ARCHIVO AL REPOSITORIO
if git add . &&  git commit -m "$COMMIT_MSG" && git push; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Archivo subido con éxito a GitHub" >> "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error al subir archivo a GitHub" >> "$LOG_FILE"
    exit 1
fi
# Mensaje final en consola
echo "Archivo subido con éxito. Revisa el log en $LOG_FILE"
