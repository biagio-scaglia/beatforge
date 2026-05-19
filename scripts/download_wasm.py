import os
import re
import urllib.request

def main():
    lock_path = 'pubspec.lock'
    if not os.path.exists(lock_path):
        print(f"Errore: {lock_path} non trovato. Esegui prima 'flutter pub get'.")
        return

    with open(lock_path, 'r') as f:
        content = f.read()

    # Trova la versione di drift
    drift_match = re.search(r'\bdrift:\s*[\s\S]*?version:\s*["\']?([^"\']+)["\']?', content)
    drift_version = drift_match.group(1) if drift_match else None

    # Trova la versione di sqlite3
    sqlite3_match = re.search(r'\bsqlite3:\s*[\s\S]*?version:\s*["\']?([^"\']+)["\']?', content)
    sqlite3_version = sqlite3_match.group(1) if sqlite3_match else None

    print(f"Versione drift rilevata: {drift_version}")
    print(f"Versione sqlite3 rilevata: {sqlite3_version}")

    if not drift_version or not sqlite3_version:
        print("Errore: Impossibile analizzare le versioni da pubspec.lock.")
        return

    web_dir = 'web'
    os.makedirs(web_dir, exist_ok=True)

    # 1. Scarica sqlite3.wasm
    sqlite3_wasm_url = f"https://github.com/simolus3/sqlite3.dart/releases/download/sqlite3-{sqlite3_version}/sqlite3.wasm"
    sqlite3_wasm_dest = os.path.join(web_dir, 'sqlite3.wasm')
    print(f"Scaricamento di sqlite3.wasm da {sqlite3_wasm_url}...")
    try:
        urllib.request.urlretrieve(sqlite3_wasm_url, sqlite3_wasm_dest)
        print(f"Salvato sqlite3.wasm in {sqlite3_wasm_dest}")
    except Exception as e:
        print(f"Impossibile scaricare sqlite3.wasm: {e}")

    # 2. Scarica drift_worker.js
    drift_worker_url = f"https://github.com/simolus3/drift/releases/download/drift-{drift_version}/drift_worker.js"
    drift_worker_dest = os.path.join(web_dir, 'drift_worker.js')
    print(f"Scaricamento di drift_worker.js da {drift_worker_url}...")
    try:
        urllib.request.urlretrieve(drift_worker_url, drift_worker_dest)
        print(f"Salvato drift_worker.js in {drift_worker_dest}")
    except Exception as e:
        print(f"Impossibile scaricare drift_worker.js: {e}")

if __name__ == '__main__':
    main()
