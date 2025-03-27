#!/bin/bash
# Script interattivo per sincronizzare la configurazione di Neovim
# dal repository alla directory live.
#
# La repository è organizzata in questo modo:
# - README.md, sync.sh, LICENSE nella root
# - La configurazione di Neovim è contenuta in una sottocartella chiamata "nvim"
#
# Lo script sincronizzerà solo i file presenti nella cartella "nvim" della repository.

# Chiedi all'utente il percorso della repository di configurazione
read -p "Inserisci il percorso della repository di configurazione (default: $HOME/github/neovim-config): " REPO_CONFIG
REPO_CONFIG=${REPO_CONFIG:-"$HOME/github/neovim-config"}

# Chiedi all'utente il percorso della configurazione live
read -p "Inserisci il percorso della configurazione live (default: $HOME/.config/nvim): " LIVE_CONFIG
LIVE_CONFIG=${LIVE_CONFIG:-"$HOME/.config/nvim"}

echo "Repository configurazione: $REPO_CONFIG"
echo "Configurazione live: $LIVE_CONFIG"

# Verifica che la cartella "nvim" esista all'interno della repository
if [ ! -d "$REPO_CONFIG/nvim" ]; then
  echo "Errore: la cartella 'nvim' non esiste in $REPO_CONFIG."
  echo "Assicurati che la configurazione di Neovim sia posizionata in '$REPO_CONFIG/nvim'."
  exit 1
fi

# Se la directory live non esiste, chiedi se crearla
if [ ! -d "$LIVE_CONFIG" ]; then
  read -p "La directory live non esiste. Vuoi crearla? (y/n): " create_live
  if [[ "$create_live" =~ ^[Yy]$ ]]; then
    mkdir -p "$LIVE_CONFIG"
  else
    echo "Interruzione dello script."
    exit 1
  fi
fi

# Chiedi se eseguire un backup della configurazione live prima di sincronizzare
read -p "Vuoi creare un backup della configurazione live? (y/n): " do_backup
if [[ "$do_backup" =~ ^[Yy]$ ]]; then
  BACKUP_DIR="${LIVE_CONFIG}/backup_$(date +%Y%m%d%H%M%S)"
  mkdir -p "$BACKUP_DIR"
  echo "Backup della configurazione live creato in: $BACKUP_DIR"
  cp -R "$LIVE_CONFIG"/. "$BACKUP_DIR"
fi

echo "Inizio sincronizzazione interattiva dei file dalla cartella 'nvim' del repository alla configurazione live..."

# Itera ricorsivamente sui file presenti nella cartella "nvim" del repository
find "$REPO_CONFIG/nvim" -type f | while read -r repo_file; do
  # Calcola il percorso relativo del file rispetto alla cartella "nvim"
  rel_path="${repo_file#$REPO_CONFIG/nvim/}"
  live_file="$LIVE_CONFIG/$rel_path"

  # Crea la directory di destinazione se non esiste
  live_file_dir=$(dirname "$live_file")
  if [ ! -d "$live_file_dir" ]; then
    mkdir -p "$live_file_dir"
  fi

  if [ -f "$live_file" ]; then
    # Mostra le differenze tra il file del repository e quello live
    diff_output=$(diff -u "$repo_file" "$live_file")
    if [ -n "$diff_output" ]; then
      echo "----------------------------------------"
      echo "Differenze per il file: $rel_path"
      echo "$diff_output"
      echo "----------------------------------------"
      read -p "Vuoi sincronizzare questo file? (y/n): " answer
      if [[ "$answer" =~ ^[Yy]$ ]]; then
        cp "$repo_file" "$live_file"
        echo "File sincronizzato: $rel_path"
      else
        echo "File saltato: $rel_path"
      fi
    else
      echo "File $rel_path identico, nessuna azione necessaria."
    fi
  else
    echo "Il file $rel_path non esiste nella configurazione live."
    read -p "Vuoi copiarlo? (y/n): " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
      cp "$repo_file" "$live_file"
      echo "File copiato: $rel_path"
    else
      echo "File saltato: $rel_path"
    fi
  fi
done

echo "Sincronizzazione interattiva completata."
