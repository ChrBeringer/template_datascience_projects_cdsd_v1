@echo off
set "PROJECT_ROOT=my_new_data_science_project"
echo Starte die Erstellung der Projektstruktur in: %PROJECT_ROOT%
echo.

:: 1. Erstelle das Hauptverzeichnis
mkdir "%PROJECT_ROOT%"
cd "%PROJECT_ROOT%"

:: 2. Erstelle Hauptordner
echo Erstelle Hauptordner...
mkdir config
mkdir data
mkdir entrypoint
mkdir notebooks
mkdir src
mkdir src\pipelines
mkdir tests
mkdir tests\unit

:: 3. Erstelle Unterordner für 'data'
echo Erstelle Daten-Unterordner...
mkdir data\01-raw
mkdir data\02-processed
mkdir data\03-features
mkdir data\04-predictions

:: 4. Erstelle Initialisierungsdateien (__init__.py) für Python-Module
echo Erstelle Python-Modul-Dateien...
type nul > config\__init__.py
type nul > entrypoint\__init__.py
type nul > src\__init__.py
type nul > src\pipelines\__init__.py
type nul > tests\__init__.py

:: 5. Erstelle die wichtigsten leeren Dateien
echo Erstelle Hauptdateien...
type nul > README.md
type nul > Dockerfile
type nul > requirements-dev.txt
type nul > requirements-prod.txt
type nul > Makefile
type nul > .gitignore

:: 6. Erstelle Beispiel-Konfigurationsdateien
echo Erstelle Beispiel-Konfigurationsdateien...
echo # Hier kommen Pfade, Metriken und allgemeine Einstellungen rein. > config\main_config.yaml
echo # Hier kommen Hyperparameter wie 'learning_rate: 0.001' rein. > config\model_params.yaml

:: 7. Erstelle die Dokumentation
echo Erstelle Dokumentation 'How_to_use_this_template.md'...
(
    echo ### 📘 How to Use This Template
    echo.
    echo Diese Vorlage dient dazu, Data Science Projekte standardisiert, modular und reproduzierbar zu gestalten.
    echo.
    echo #### 📂 Übersicht und Funktionsweise der Ordner
    echo.
    echo ^| Ordner ^| Wozu dient er? ^| Wie sollte er verwendet werden? ^|
    echo ^| :--- ^| :--- ^| :--- ^|
    echo ^| ^`config/^` ^| **Konfiguration und Parameter.** Speichert alle statischen Einstellungen. ^| Speichern Sie hier ^`*.yaml^` oder ^`*.json^` Dateien. ^|
    echo ^| ^`data/^` ^| **Datenmanagement.** Organisiert alle Daten nach ihrem Verarbeitungszustand. ^| **Niemals** Daten in ^`01-raw/^` verändern! ^|
    echo ^| ^`entrypoint/^` ^| **Anwendungsstartpunkte.** Dient als Schnittstelle für das Ausführen der Hauptaufgaben. ^| Dies sind die Skripte, die Sie direkt über die Kommandozeile aufrufen. ^|
    echo ^| ^`notebooks/^` ^| **Exploration und Prototyping.** Wird für iterative Datenanalyse (EDA) verwendet. ^| Speichern Sie hier Jupyter/IPython Notebooks. ^|
    echo ^| ^`src/^` ^| **Produktionsreifer Quellcode.** Enthält alle modularen Funktionen und Pipelines. ^| Code in ^`src/^` muss importierbar und testbar sein. ^|
    echo ^| ^`tests/^` ^| **Qualitätssicherung.** Beinhaltet Unit-Tests und Integrationstests. ^| Führen Sie Tests vor jedem Deployment aus. ^|
) > How_to_use_this_template.md

:: 8. Erstelle Basis-Skripte für entrypoint und src
echo Erstelle Basis-Skripte...

(
    echo import sys
    echo from src.pipelines import model_training
    echo 
    echo # Beispiel-Startpunkt, der die Logik aus src/ aufruft
    echo if __name__ == "__main__":
    echo     print("Starte Trainings-Pipeline...")
    echo     # Hier würde die Konfiguration geladen werden: config.load('main_config.yaml')
    echo     model = model_training.train_model()
    echo     print(f"Training beendet. Modell-Objekt: {model}")
) > entrypoint\train.py

(
    echo def train_model():
    echo     """Simuliert das Laden von Daten, das Training und die Speicherung des Modells."""
    echo     # Echte Logik: Daten aus data/03-features laden, Modell instanziieren, trainieren.
    echo     # ...
    echo     return "TrainedModelObject"
) > src\pipelines\model_training.py

(
    echo # Fügen Sie hier häufig verwendete Funktionen ein, die Sie in Notebooks importieren.
    echo def clean_text(data):
    echo     """Dummy-Funktion zur Textbereinigung."""
    echo     return f"Bereinigte Daten von {data}"
) > src\utils.py

echo.
echo Erfolgreich abgeschlossen! Die Projektstruktur wurde in ./%PROJECT_ROOT% erstellt.
echo.
echo Nächster Schritt: Wechseln Sie in das Verzeichnis und passen Sie die requirements-*.txt Dateien an.
cd ..
pause