# BeatForge

BeatForge è un prototipo di rhythm game locale-first sviluppato in Flutter. Il progetto si distingue per un'interfaccia grafica scura dal forte impatto visivo ispirata all'estetica pop-futuristica e arcade di giochi come *Project DIVA* e *Project Sekai*, senza far uso di asset proprietari. 

L'obiettivo principale dell'applicazione è consentire agli utenti di importare e organizzare la propria musica locale in modo completamente indipendente, ponendo le basi per un futuro editor e un motore di gioco.

---

## Stato del Progetto

Il progetto è attualmente in **fase di prototipo iniziale (Work in Progress)**. 

Le fondamenta dell'interfaccia utente responsive, del sistema di navigazione e della persistenza dei dati tramite database locale sono state completate con successo. Attualmente, l'applicazione supporta l'importazione, la classificazione e la rimozione di file audio locali (MP3). I moduli di riproduzione audio e di editor di beatmap non sono ancora presenti e verranno introdotti nei prossimi step.

---

## Obiettivi del Progetto

- **Locale-First & Privato**: Nessun backend centralizzato obbligatorio. Tutti i dati, i metadati e i file importati rimangono sul dispositivo dell'utente.
- **Interfaccia Dinamica**: Offrire un'esperienza fluida ed estremamente reattiva su schermi di qualsiasi dimensione, ottimizzata sia per input touch sia per mouse.
- **Libertà di Mappatura**: Consentire in futuro di creare mappe beat personalizzate per qualunque traccia audio caricata dall'utente.

---

## Feature Attuali

- **UI Adaptable & Responsive**: Shell applicativa con adattamento automatico da `NavigationBar` inferiore (su schermi mobile) a `NavigationRail` laterale (su tablet e desktop).
- **Stile Dark Neon**: Design dark integrato con bagliori neon, animazioni al tocco/passaggio del mouse ed effetti di transizione curati.
- **Importazione MP3**: Selezione di file audio locali e caricamento automatico all'interno dell'applicazione.
- **Database Locale Drift (SQLite)**: Persistenza affidabile per tracce, categorie e collegamenti molti-a-molti.
- **Gestione Categorie**: Seed iniziale di categorie (*Practice*, *Favorites*, *Test*, *Custom*) e possibilità per l'utente di associare o rimuovere tag ai brani tramite dialog interattivo.
- **Gestione del File System**: Cancellazione fisica del file audio dal disco su piattaforme native all'eliminazione del brano dalla libreria.
- **Supporto Web (Chrome)**: Gestione dei limiti di sandboxing del browser tramite archiviazione dei byte in formato BLOB (`AudioTrackData`) e sincronizzazione asincrona.

---

## Roadmap Tecnica

- [x] Struttura dell'interfaccia responsive e tema grafico neon.
- [x] Integrazione del database Drift con supporto multi-piattaforma.
- [x] Importazione, categorizzazione ed eliminazione di tracce audio locali.
- [ ] Implementazione del player audio locale (riproduzione da file system/database).
- [ ] Definizione dello standard e della struttura dati per le beatmap.
- [ ] Creazione dell'editor visivo delle note musicali.
- [ ] Implementazione dell'engine di gameplay (timing dei tap, scorrimento note, punteggi).

---

## Stack Tecnico

- **Core**: [Flutter](https://flutter.dev) & [Dart](https://dart.dev) (supporto multi-piattaforma).
- **Persistenza**: [Drift](https://drift.simonbinder.eu) (SQLite) per la gestione del database relazionale.
- **File Picker**: [file_picker](https://pub.dev/packages/file_picker) per l'interazione con il file system del dispositivo.
- **Web Assembly**: `sqlite3.wasm` e `drift_worker.js` per garantire il funzionamento del database SQLite nel browser.
- **Tipografia**: Outfit e Orbitron (tramite Google Fonts).

---

## Struttura del Progetto

Il codice segue una struttura **feature-first** ordinata per garantire modularità ed estendibilità:

```text
lib/
├── app/                  # Inizializzazione dell'app e configurazioni globali
├── data/                 # Layer di accesso ai dati
│   ├── local/
│   │   └── database/     # Definizione delle tabelle e configurazione di Drift (app_database.dart)
│   └── repositories/     # Logica di business e astrazione query (AudioRepository)
├── features/             # Funzionalità dell'app divise per modulo
│   ├── home/             # Schermata principale e collegamenti rapidi
│   ├── library/          # Schermata di importazione e gestione brani (Libreria)
│   ├── navigation/       # AppShell reattiva (NavigationBar/NavigationRail)
│   └── settings/         # Schermata di configurazione impostazioni
└── shared/               # Risorse e widget neon riutilizzabili a livello globale
scripts/                  # Script di utilità (es. download delle librerie WASM per il web)
web/                      # Asset di build web (compresi sqlite3.wasm e drift_worker.js)
```

---

## Requisiti

- **Flutter SDK**: `>=3.0.0`
- **Dart SDK**: `>=3.0.0`
- **Python 3**: Necessario esclusivamente in fase di sviluppo web per eseguire lo script di sincronizzazione degli asset WebAssembly.

---

## Installazione

1. Clona il repository GitHub:
   ```bash
   git clone https://github.com/biagio-scaglia/beatforge.git
   cd beatforge
   ```

2. Installa le dipendenze del progetto:
   ```bash
   flutter pub get
   ```

---

## Note per lo Sviluppo Locale

### Sviluppo su Piattaforma Web (Chrome)
Poiché Drift su ambiente web fa affidamento su WebAssembly e Web Worker per gestire in background le transazioni SQLite, è necessario scaricare i binari corretti prima dell'esecuzione. 

Abbiamo automatizzato questa operazione con uno script Python che analizza le versioni installate nel tuo `pubspec.lock` e scarica i file adatti:

```bash
python scripts/download_wasm.py
```
*Esegui questo comando prima di avviare il progetto su Chrome.*

### Generazione del Codice (Build Runner)
Drift richiede la generazione del codice di supporto per mappare le tabelle. Se modifichi il file `app_database.dart` per aggiungere o cambiare colonne, esegui il generatore:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## Comandi Utili

Di seguito sono elencati i comandi di uso comune pronti da copiare:

* **Installare le dipendenze**:
  ```bash
  flutter pub get
  ```
* **Avviare l'app in locale**:
  ```bash
  flutter run
  ```
* **Avviare specificamente su Chrome**:
  ```bash
  flutter run -d chrome
  ```
* **Analizzare il codice (Lint & Deprecazioni)**:
  ```bash
  flutter analyze
  ```
* **Eseguire i test**:
  ```bash
  flutter test
  ```

---

## Linee Guida per lo Sviluppo

- **Pulizia del codice**: Evita spaghetti-code. Mantieni la UI nei widget e la logica di accesso al database all'interno del repository.
- **Nessuna API deprecata**: Non utilizzare metodi obsoleti. Ad esempio, usa `color.withValues(alpha: ...)` al posto del vecchio `color.withOpacity` e sfrutta `activeThumbColor`/`activeTrackColor` nei widget di selezione.
- **Lingua**: Tutta la documentazione interna e i commenti al codice devono essere scritti in **italiano**.

---

## Contribuire

I contributi sono sempre i benvenuti! 
1. Fai un **Fork** del progetto.
2. Crea un branch per la tua feature (`git checkout -b feature/la-tua-feature`).
3. Effettua i tuoi commit seguendo le convenzioni dei [Conventional Commits](https://www.conventionalcommits.org/) (es. `feat: add audio visualizer`).
4. Esegui il push sul tuo branch (`git push origin feature/la-tua-feature`).
5. Apri una **Pull Request** descrivendo le modifiche introdotte.

---

## Licenza

Questo progetto è un prototipo open-source distribuito a scopo dimostrativo e di studio. I dettagli relativi a una licenza formale verranno definiti nelle successive fasi di sviluppo.
