#!/bin/bash

# Imposta i nomi dei file
MD_FILE="articolo_completo.md"
BIB_FILE="bibliografia.bib"
META_FILE="metadati.yaml"
TEX_FILE="articolo_completo.tex"
PDF_FILE="articolo_completo.pdf"

# Passaggio 1: genera il file .tex da markdown con pandoc
echo "👉 Generazione del file .tex da $MD_FILE..."
pandoc -s "$MD_FILE" \
  --bibliography="$BIB_FILE" \
  --citeproc \
  --metadata-file="$META_FILE" \
  -o "$TEX_FILE"

# Verifica se il .tex è stato creato
if [ -f "$TEX_FILE" ]; then
  echo "✅ File TeX generato con successo: $TEX_FILE"
else
  echo "❌ Errore nella generazione del file TeX"
  exit 1
fi

# Passaggio 2: compila il file .tex con pdflatex
echo "👉 Compilazione PDF con pdflatex..."
pdflatex -interaction=nonstopmode "$TEX_FILE" > /dev/null

# Verifica se il PDF è stato creato
if [ -f "$PDF_FILE" ]; then
  echo "✅ PDF generato con successo: $PDF_FILE"
else
  echo "❌ Errore nella generazione del PDF"
  exit 1
fi
