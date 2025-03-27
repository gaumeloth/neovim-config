# Neovim Config Sync

Questo repository contiene la configurazione per Neovim insieme a uno script Bash interattivo per sincronizzare i file di configurazione dalla repository alla posizione "live" sul sistema. Lo script offre funzionalità di backup, controllo differenze file per file e conferma interattiva, garantendo che l'utente finale abbia il pieno controllo sulle modifiche da applicare.

## Caratteristiche

- **Interattività:**  
  - Richiede all'utente i percorsi per la repository di configurazione e per la configurazione live, con valori di default preimpostati.
  - Per ogni file, mostra le differenze tra la versione nel repository e quella "live" e chiede conferma per la sincronizzazione.

- **Backup Automatico:**  
  - Prima di eseguire la sincronizzazione, lo script può creare un backup della configurazione live (con timestamp) per facilitare un eventuale rollback.

- **Compatibilità:**  
  - Utilizza comandi standard Unix come `cp`, `diff`, `find` e `mkdir`, garantendo l'esecuzione su qualsiasi sistema Unix-like (testato su Arch Linux).

## Requisiti

- **Bash:** Versione 4.x o superiore (consigliata).
- **Comandi Standard:** `cp`, `diff`, `find`, `mkdir`.
- **Sistema Operativo:** Linux (lo script è stato testato su Arch Linux).

## Struttura della Repository
```
. 
├── README.md # Questo file di documentazione
├── sync.sh # Script interattivo per la sincronizzazione della configurazione
└── nvim/ # Cartella contenente i file di configurazione di Neovim
```
## Installazione

1. **Clonare la repository:**

   ```bash
   git clone https://github.com/tuo-username/neovim-config.git ~/github/neovim-config
   ```
2. **Personalizzare la configurazione:**

- Modifica i file di configurazione di Neovim secondo le tue esigenze.

- Aggiungi eventuali file o directory necessari.

## Utilizzo

1. Apri un terminale e naviga nella directory della repository:

```bash
cd ~/github/neovim-config
```
2. **Rendi eseguibile lo script di sincronizzazione (se non lo è già):**

```bash
chmod +x sync.sh
```
3. **Esegui lo script:**
```bash
./sync.sh
```
4. **Interazione durante l'esecuzione:**

- Lo script chiederà il percorso della repository di configurazione. Se non inserisci nulla, verrà usato il valore di default ($HOME/github/neovim-config/nvim).

- Verrà richiesto anche il percorso della configurazione live (default: $HOME/.config/nvim).

- Se la directory live non esiste, lo script chiederà se crearla.

- Ti verrà chiesto se desideri eseguire un backup della configurazione live prima della sincronizzazione.

- Per ogni file, lo script mostrerà le differenze (se presenti) e chiederà se sincronizzarlo (cioè, se copiare la versione dal repository al percorso live).

## Personalizzazione
- **Modifica dei Percorsi di Default:**
Se necessario, puoi modificare i valori di default direttamente nello script sync.sh oppure personalizzare le domande interattive.

- **Estensione a Più Configurazioni:**
Anche se lo script è stato progettato per Neovim, il medesimo approccio può essere adattato per sincronizzare altre configurazioni (dotfiles).

## Contributi
Se desideri contribuire a questo progetto, segui questi passi:

1. **Fork della Repository:**
Crea un fork del progetto sul tuo account GitHub.
2. **Crea un Branch:**
```bash
git checkout -b feature/tuo-feature
```
3. **Apporta le Modifiche:**
Effettua i commit dei tuoi cambiamenti in maniera descrittiva.
4. **Invia una Pull Request:**
Invia una PR spiegando le modifiche e il motivo del tuo contributo.

## Licenza
Questo progetto è distribuito sotto la licenza GPLv3. Vedi il file [LICENSE][LICENSE] per ulteriori dettagli.

## Contatti
Per domande, suggerimenti o segnalazioni di bug, apri un issue su GitHub.
