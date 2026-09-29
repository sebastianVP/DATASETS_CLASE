# REPOSITORIO DATASET
---
Contiene la informacion de multiples datasets para prueba y ejemplos.
1. Voy a probar automatizar la generación y el envio  de un archivo csv en este directorio.
2. Otro batch se va a encargar de subir el archivo nuevo  al repositorio en github.
3. El archivo se llama send_reporte.sh
4- Probar que funcione en varias consolas diferentes.
---
# Observaciones
1. El paso siguiente es subirlo a crontab
2. Corregir los bugs.
3. Previsamente a todo el proceso se genero la llave. https://github.com/sebastianVP/CREAR_KEY_SSH_GITHUB

# UPDATE

# Automatización de Reportes 2026

Este directorio contiene scripts desarrollados para automatizar la generación, identificación y publicación de reportes correspondientes al año 2026.

## Scripts desarrollados

### 1. `auto_scanner_2026.py`

Script encargado de realizar el **escaneo y detección automática de los archivos de reporte** correspondientes al periodo 2026.

Su función principal es identificar los archivos requeridos y facilitar su posterior procesamiento.

### 2. `auto_reporte_2026.py`

Script encargado de realizar el **procesamiento y generación automática de los reportes 2026**.

Este módulo permite centralizar la generación de los archivos:

* `REPORTE_AUTOMATIZADO_2026.csv`
* `REPORTE_DIGDT_2026.csv`

De esta manera, se reduce la intervención manual y se mantiene un flujo reproducible para la actualización de los datos.

### 3. `auto_send_2026.sh`

Script Bash encargado de realizar el **envío automático de los reportes al repositorio Git**.

El proceso realiza las siguientes acciones:

1. Verifica que existan los archivos de reporte.
2. Copia los archivos desde `/home/soporte/Documents`.
3. Los coloca en el repositorio `DATASETS_CLASE`.
4. Agrega únicamente los archivos de reporte al control de versiones.
5. Genera un commit con la actualización.
6. Ejecuta `git push` para publicar los cambios en GitHub.
7. Registra el proceso en `subida_2026.log`.

Los archivos publicados son:

```text
REPORTE_AUTOMATIZADO_2026.csv
REPORTE_DIGDT_2026.csv
```

## Flujo de automatización

El flujo general desarrollado es:

```text
Fuentes / archivos de datos
          │
          ▼
auto_scanner_2026.py
          │
          ▼
Detección de archivos
          │
          ▼
auto_reporte_2026.py
          │
          ▼
Generación de reportes
          │
          ├── REPORTE_AUTOMATIZADO_2026.csv
          └── REPORTE_DIGDT_2026.csv
                         │
                         ▼
                auto_send_2026.sh
                         │
                         ▼
                    Git / GitHub
```

## Ubicación

Repositorio local:

```text
/home/soporte/Documents/DATASETS_CLASE
```

Repositorio remoto:

```text
github.com/sebastianVP/DATASETS_CLASE
```

## Objetivo

La automatización busca reducir tareas manuales, estandarizar la generación de reportes y facilitar su actualización periódica en el repositorio GitHub, manteniendo un registro de las operaciones realizadas.
