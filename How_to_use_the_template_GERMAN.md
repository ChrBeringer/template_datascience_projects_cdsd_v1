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
    ├── __init__.py
    └── unit/                    # Unit-Tests für src/
        └── test_utils.py
