# template_datascience_projects_cdsd_v1
Ein template für wissenschaftliche Data-Science-Projekte basierend auf der Cookie-Cutter-Struktur (CDSD).
Eine standardisierte, vorstrukturierte Projektvorlage (Template), die entwickelt wurde, um die Reproduzierbarkeit und Organisation von Data-Science-Projekten zu gewährleisten.

# Grundprinzipien
1. Strikte Trennung von Daten: Der data/-Ordner wird in 01-raw, 02-processed, etc. unterteilt. Dies ist der wichtigste Beitrag zur Reproduzierbarkeit, da klar ist, welche Datenversion für welche Pipeline verwendet wird.
2. Trennung von Exploration und Produktion: Notebooks (notebooks/) sind getrennt vom modularen, testbaren Code (src/).
3. Standardisierte Entrypoints: Die Skripte in entrypoint/ ermöglichen eine einfache Automatisierung.

Dadurch:
- Reproduzierbarkeit,"Jeder Schritt, von den Rohdaten bis zur finalen Analyse, ist nachvollziehbar."
- Standardisierung,"Neue Teammitglieder finden sich sofort zurecht, da die Struktur immer gleich ist."
- Modularität,"Der Code ist in kleine, testbare Einheiten (Module in src/) unterteilt."
- Organisation,"Dokumente, Konfiguration, Code und Daten sind logisch getrennt."
- Automatisierung,Durch klare Entrypoints und Abhängigkeitsdateien lässt sich der gesamte Prozess automatisieren (CI/CD).

## 📁 Projektstruktur im Detail

Die Ordnerstruktur trennt Code, Daten und Konfiguration strikt, um Klarheit und Modularität zu maximieren.

| Ordner | Zweck | Hauptinhalt |
| :--- | :--- | :--- |
| **`config/`** | **Konfiguration** | Statische Parameter, Hyperparameter, und Pfade (`.yaml`, `.json`). |
| **`data/`** | **Datenversionierung** | Alle Datasets, getrennt nach Verarbeitungsstadium. |
| **`entrypoint/`** | **Start-Skripte** | Hauptskripte zur Orchestrierung der Pipelines (`train.py`, `inference.py`). |
| **`notebooks/`** | **Exploration (EDA)** | Jupyter Notebooks für iterative Analyse und Prototyping. |
| **`src/`** | **Quellcode** | Modularer, testbarer Code und wiederverwendbare Pipelines (`utils.py`, `pipelines/`). |
| **`tests/`** | **Qualitätssicherung** | Unit-Tests zur Überprüfung der Korrektheit des Codes in `src/`. |


# Wie sollte die Struktur verwendet werden?

## config/
Konfiguration und Parameter. Speichert alle statischen Einstellungen, die sich je nach Umgebung oder Experiment ändern können, ohne den Code zu berühren.Speichern Sie hier *.yaml oder *.json Dateien für Pfade, Hyperparameter, Seed-Werte etc. Die Skripte in entrypoint/ und src/ lesen diese Dateien ein.data 

## /data 
Organisiert alle Daten nach ihrem Verarbeitungszustand (Rohdaten bis Endergebnisse), um die Nachvollziehbarkeit zu gewährleisten. Niemals Daten in 01-raw/ verändern! Die Skripte in src/pipelines/ generieren die nachfolgenden Stufen (02-processed/, 03-features/).

## /entrypoint
Anwendungsstartpunkte. Dient als Schnittstelle für das Ausführen der Hauptaufgaben des Projekts. Enthält keine Logik, sondern orchestriert die Pipelines aus src/.Dies sind die Skripte, die Sie direkt über die Kommandozeile aufrufen (z.B. python entrypoint/train.py). Sie werden für die Automatisierung (CI/CD) verwendet.

## notebooks/
Exploration und Prototyping. Wird für iterative Datenanalyse (EDA), Visualisierungen und schnelles Testen von Logik verwendet.Speichern Sie hier Jupyter/IPython Notebooks. Versuchen Sie, Logik, die sich bewährt hat, schnellstmöglich nach src/ zu migrieren.

## src/
Produktionsreifer Quellcode. Enthält alle modularen Funktionen, Klassen und Pipelines, die die Kernlogik des Projekts abbilden.Jede Datei in src/ sollte importierbar und testbar sein. Der entrypoint/ Ordner ruft diese Module auf.

## tests/
Qualitätssicherung. Beinhaltet Unit-Tests und Integrationstests, um die Korrektheit des Codes in src/ zu überprüfen. Führen Sie Tests vor jedem Deployment aus (z.B. mit pytest). Dies sichert die Code-Qualität und beugt Regressionen vor.

## 💾 Daten-Workflow: Die `data/`-Struktur

Die Ordner unter `data/` dienen der Versionierung und dem Schutz der Datenintegrität. Die Daten fließen sequenziell durch diese Ordner, gesteuert durch die Skripte in `src/pipelines/`.

| Ordner | Funktion | Git-Status |
| :--- | :--- | :--- |
| **`01-raw/`** | **Originaldaten** | Die **unveränderlichen** Quelldaten. NIEMALS manuell verändern. |
| **`02-processed/`** | **Bereinigte Daten** | Daten nach Bereinigung (Fehlwerte, Formatierung) – bereit für das Feature Engineering. |
| **`03-features/`** | **Feature-Sets** | Daten, die alle benötigten Features und Codierungen enthalten – direkter Input für das Modell. |
| **`04-predictions/`** | **Modellergebnisse** | Die Ausgabe der Inferenz-Skripte (`inference.py`) wie Vorhersagewerte oder Metriken. |

### 🚨 Wichtiger Hinweis zur Versionierung

Da die Dateien in `data/` oft sehr groß sind, werden sie in der Regel in der `.gitignore` **ignoriert**.

* Um die leere Ordnerstruktur dennoch in Git zu verfolgen, enthalten alle Unterordner die Platzhalterdatei **`.gitkeep`**.
* Für die Versionierung der **tatsächlichen Daten** verwenden Sie bitte **DVC (Data Version Control)**.

---

## 🛠 Entwicklung und Tests

* **Tests ausführen:**
    ```bash
    python -m pytest tests/
    ```
* **Code in Notebooks:** Führen Sie explorativen Code in `notebooks/` aus. Sobald die Logik ausgereift ist, migrieren Sie diese in die Module in `src/` (z.B. in `src/pipelines/data_processing.py`), damit sie testbar und reproduzierbar wird.
    ├── __init__.py
    └── unit/                    # Unit-Tests für src/
        └── test_utils.py
