# DHBW Karlsruhe -  LaTeX Vorlage für Projekt- und Bachelorarbeiten (oder sonstige Abgaben 😉)

## Credit where credit is due
+ Vorlage für das wissenschaftliche Arbeiten von Daniel Sptzer am SZI der DHBW Lörrach ([Link](https://gitlab.com/spitzerd/latex-vorlage-dhbw-loerrach-szi/))
+ Angepasst von Katja  Wengler DHBW Karlsruhe, ZWI (Wie im moodle zu finden)
+ Angepasst von von mir im Laufe des Studiums!

## Vorbreitung und Nutzung (im Aufbau)
> Windows

> Linux

> Docker

> Overleaf

## Allgemeines zum Arbeiten mit der Vorlage
Alle für den Benutzer relevanten Dateien sind in dem Order text und im Wurzelverzeichnis. 
Die Datei main.tex ist die Masterdatei der Vorlage. Mit einem Klick auf "Optionen" kann man die aktuelle Masterdatei festlegen. Die Masterdatei muss die Datei main.tex sein. Durch die Option kann man das PDF-Dokument erzeugen, auch wenn man gerade nicht die Masterdatei offen hat.

Damit man das Öffnen der ganzen Dateien und die Definition der Masterdatei nicht bei jedem Start von Texmaker erledigen muss, kann man unter "Datei -> Sitzung" eine Sitzung speichern und sie wieder laden.

Bevor man mit dem Schreiben anfängt, sollte man die Datei config.tex anpassen. Dort sind Variablen für den Titel, den Autor usw. hinterlegt.

Auch ohne LaTeX-Kennnisse ist die Einarbeitungszeit gering, weil fast alle relevanten Befehle in der Vorlage als Beispiel im ersten Kapitel hinterlegt sind.

## Weiterführende Anleitungen
- Ausführliches Nachschlagewerk: https://en.wikibooks.org/wiki/LaTeX
- LaTeX-Spickzettel: http://www.starkerstart.uni-frankfurt.de/61673435/latexsheet.pdf

Weitere Anleitungen sind in der Datei [manuals.md](https://gitlab.com/spitzerd/latex-vorlage-dhbw-loerrach-szi/blob/master/manuals.md).
Folgende Abschnitte gibt es momentan:
- Schreiben mit Visual Studio Code
- Hinzufügen von weiteren Quellenarten

## Ordnerstruktur
```
.
├── config
│   ├── dhbw_logo.pdf           # Das Logo der DHBW für das Deckblatt
│   ├── company_logo.pdf        # Ein Beispiellogo für das Ausbildungsunternehmen
|   ├── declaration.tex         # Ehrenwörtliche Erklärung und Hinweis auf dem Umfang der Arbeit
│   ├── preamble.tex            # Globale Einstellungen
|   ├── config.tex              # Konfigurationsdatei für den Benutzer
│   ├── references.tex          # Quellenverzeichnis
│   ├── releaseNotice.tex       # Freigabe der Arbeit
│   └── titlepage.tex           # Deckblatt
├── text                        
│   ├── abstract.tex            # Kurzfassung
│   ├── acronym.tex             # Abkürzungsverzeichnis
│   ├── appendix.tex            # Anhang
│   ├── bibliography.bib        # Datei mit den Literaturdaten
│   ├── chapter1.tex            # Kapitel 1
│   ├── chapter2.tex            # Kapitel 2
│   ├── chapter3.tex            # Kapitel 3
│   ├── chapter4.tex            # Kapitel 4
│   ├── chapter5.tex            # Kapitel 5          
│   └── template                # Vorlagenorder. Diese Dateien müssen nicht geöffnet oder geändert werden.
|
├── LICENSE.txt                 # Die Lizenz dieser Vorlage
├── README.md                   # Diese Datei
├── main.pdf                    # Output (pdf)
└── main.tex                    # Masterdatei

```

## Schreiben mit Visual Studio Code
Man kann seine Arbeit auch bequem mit VS Code schreiben, statt mit Texmaker. Ob VS Code oder Texmaker besser zum Schreiben der Arbeit geeignet ist, muss jeder selbst wissen.

1. VS Code installieren: https://code.visualstudio.com/Download
2. Die VS Code Erweiterung "LaTeX Workshop" installieren
3. Die LaTex-Vorlage öffnen: "Datei -> Ordner öffnen..."
4. Sobald man eine .tex-Datei in der Vorlage ändert und speichert, wird ein Build-Vorgang gestartet.

Sehr zu empfehlen: Die VS Code Erweiterung "Spell Right" liefert eine Rechtschreibprüfung.

## Hinzufügen von weiteren Quellenarten
Standardmäßig gibt es im Quellenverzeichnis die Abschnitte Bücher, Sammelwerke, Artikel, Internetquellen, Interviews und interne Quellen. Man kann weitere Quellenarten hinzufügen.
Um die Anleitung etwas anschaulicher zu machen, wird als Beispiel wissenschaftliche Arbeiten als neue Quellenart angelegt.

1. Den passenden BIBTEX Database Entry Type wählen. <br> http://tug.ctan.org/info/biblatex-cheatsheet/biblatex-cheatsheet.pdf<br>
Für wissenschaftliche Arbeiten ist der Typ ```@thesis``` am besten geeignet. Falls kein Typ so richtig passt, kann man ```@misc``` nehmen.
2. In der Vorlage die Datei "text/references.tex" öffnen und folgenden Code hinzufügen:
```
\defbibheading{Arbeiten}{\noindent\large\textbf{Wissenschaftliche Arbeiten}} 
\printbibliography[type=thesis, heading=Arbeiten]
```
Mit dem Parameter "type" wird der Typ definiert, den wir im ersten Schritt gewählt haben.
3. Einen Eintrag in die Datei "text/content/bibliography.bib" hinzufügen, z. B. so:
```
@thesis{Meier2005,
  author       = {Linus Meier}, 
  title        = {LaTex in wissenschaftlichen Arbeiten},
  school       = {DHBW Lörrach},
  year         = 2005,
} 
```
4. Wenn der Eintrag zitiert wird, erscheint im Quellenverzeichnis der Abschnitt "Wissenschaftliche Arbeiten".

## Weiterentwicklung
Merge Requests und Issues sind gerne gesehen.
