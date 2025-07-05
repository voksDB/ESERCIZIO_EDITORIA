@echo off
REM Script per generare PDF e HTML da Markdown usando Pandoc su Windows
REM Creato con cura da ChatGPT

REM === Definizione nomi file ===
set MD_FILE=articolo_completo.md
set BIB_FILE=bibliografia.bib
set META_FILE=metadati.yaml
set TEX_FILE=articolo_completo.tex
set PDF_FILE=articolo_completo.pdf
set HTML_FILE=articolo_completo.html

echo 👉 Generazione del file .tex da %MD_FILE%...
pandoc -s "%MD_FILE%" ^
  --bibliography="%BIB_FILE%" ^
  --citeproc ^
  --metadata-file="%META_FILE%" ^
  -o "%TEX_FILE%"

IF EXIST "%TEX_FILE%" (
  echo File TeX generato con successo: %TEX_FILE%
) ELSE (
  echo Errore nella generazione del file TeX
  exit /b 1
)

echo Compilazione PDF con pdflatex...
pdflatex -interaction=nonstopmode "%TEX_FILE%" > nul

IF EXIST "%PDF_FILE%" (
  echo  PDF generato con successo: %PDF_FILE%
) ELSE (
  echo  Errore nella generazione del PDF
  exit /b 1
)

echo Generazione dell'HTML standalone...
pandoc -s "%MD_FILE%" ^
  --metadata-file="%META_FILE%" ^
  --bibliography="%BIB_FILE%" ^
  --citeproc ^
  -o "%HTML_FILE%"

IF EXIST "%HTML_FILE%" (
  echo HTML generato con successo: %HTML_FILE%
) ELSE (
  echo Errore nella generazione dell'HTML
  exit /b 1
)

echo 🎉 Tutto fatto!
pause
