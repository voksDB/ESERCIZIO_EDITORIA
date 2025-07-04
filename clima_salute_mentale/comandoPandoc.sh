# senza template: 
pandoc -s articolo_completo.md --bibliography=bibliografia.bib --citeproc --metadata-file=metadati.yaml  -o articolo_completo.tex

# con template: (NOOOO)
pandoc documento.md -o output.pdf --template=template.tex --citeproc
pandoc articolo_completo.md -o output.pdf --metadata-file=metadati.yaml --template=template.tex --citeproc


# unire i file md
pandoc sintesi_1.md sintesi_2.md sintesi_3.md --from markdown --to markdown --bibliography=bibliografia.bib --citeproc -o --metadata-file=metadati.yaml articolo_completo.md
