import requests
from bs4 import BeautifulSoup

def get_html_metadata(url):
    """
    Scarica il contenuto HTML di una pagina e restituisce i metadati dai tag <meta>.
    """
    headers = {
        "User-Agent": "Mozilla/5.0"  # Evita blocchi da parte del sito
    }
    response = requests.get(url, headers=headers)
    
    if response.status_code != 200:
        print(f"Errore: {response.status_code} nel recuperare {url}")
        return None

    soup = BeautifulSoup(response.text, "html.parser")
    
    # Estrai <meta> con attributi name o property o citation
    metadata = {}
    for meta in soup.find_all("meta"):
        name = meta.get("name") or meta.get("property") or meta.get("itemprop")
        content = meta.get("content")
        if name and content:
            name = name.strip().replace(" ", "_").lower()
            metadata[name] = content.strip()
    
    return metadata

def save_metadata_to_file(metadata, filename):
    """
    Salva i metadati in un file YAML.
    """
    with open(filename, "w", encoding="utf-8") as file:
        for key, value in metadata.items():
            file.write(f"{key}: \"{value}\"\n")
    print(f"Metadati salvati in '{filename}'.")

# === ESEMPIO DI USO ===

urls = [
    "https://doi.org/10.1016/j.jafr.2025.102023",
    "https://doi.org/10.1016/j.jafr.2025.102024",
    "https://bmjopen.bmj.com/content/15/4/e093222"
]


for url in urls:
    print(f"\nAnalizzando: {url}")
    metadata = get_html_metadata(url)
    if metadata:
        for k, v in list(metadata.items())[:10]:  # stampa anteprima dei primi 10
            print(f"{k}: {v}")
        filename = url.split("/")[-1] + "_metadata.yaml"
        save_metadata_to_file(metadata, filename)
