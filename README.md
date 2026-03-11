# 🎮 NSUI Web — GBA to CIA Injector

**New Super Ultimate Injector Web** — Converti ROM GBA in CIA per Nintendo 3DS Virtual Console direttamente dal browser, senza installare nulla.

[![Live Demo](https://img.shields.io/badge/Live%20Demo-GitHub%20Pages-00e5ff?style=flat-square)](https://YOUR_USERNAME.github.io/nsui-web)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
![HTML5](https://img.shields.io/badge/HTML5-100%25%20Client--Side-orange?style=flat-square)

---

## 🚀 Demo Live

👉 **[https://YOUR_USERNAME.github.io/nsui-web](https://YOUR_USERNAME.github.io/nsui-web)**

---

## ✨ Funzionalità

- 🔄 **Iniezione CIA completa** — ROM GBA → CIA installabile su New 3DS CFW
- 📂 **Drag & Drop** — Trascina semplicemente i file
- 🔍 **Parsing CIA binario** — Legge header, TMD, NCCH direttamente nel browser
- 🔐 **SHA-256 via WebCrypto** — Hash reali con API nativa del browser
- 🎨 **Configurazione banner** — Icona, colore sfondo, titolo personalizzati
- 📱 **Responsive** — Funziona su PC e smartphone
- ⚡ **100% client-side** — Nessun server, nessun upload, tutto locale

---

## 📋 Requisiti

### Per usare il tool web
- Browser moderno con supporto WebCrypto (Chrome, Firefox, Edge, Safari)
- Nessuna installazione richiesta

### Per installare il CIA generato
- **New Nintendo 3DS** (N3DS) con Custom Firmware
- **Luma3DS** con sigpatches abilitate
- **FBI Manager** o **GodMode9** per l'installazione
- **VC Base CIA** estratto legalmente dal tuo 3DS (contiene l'emulatore GBA)

---

## 🛠️ Come Si Usa

### 1. Prepara i file
- **ROM GBA** (`.gba`) — il gioco che vuoi convertire (backup legale)
- **VC Base CIA** (`.cia`) — estratto dal tuo N3DS con GodMode9

### 2. Estrai il VC Base dal tuo 3DS
Con GodMode9 sul tuo N3DS:
```
SYSNAND CTRNAND > title > 00040000 > [ID gioco GBA VC] > content > *.cia
```
Copia il `.cia` sulla SD e portalo sul PC.

### 3. Usa NSUI Web
1. Vai su [https://YOUR_USERNAME.github.io/nsui-web](https://YOUR_USERNAME.github.io/nsui-web)
2. **Step 01** — Carica il tuo file `.GBA`
3. **Step 02** — Carica il VC Base `.CIA`
4. **Step 03** — Configura titolo, icona e opzioni
5. **Step 04** — Clicca **Avvia Iniezione CIA** e scarica

### 4. Installa sul 3DS
Copia il `.cia` sulla scheda SD e installalo con FBI o GodMode9.

---

## ⚙️ Come Funziona Tecnicamente

```
GBA ROM (.gba)  +  VC Base CIA (.cia)
         │                │
         └────────┬───────┘
                  ▼
         CIA Header Parser
              (JS puro)
                  │
         Ricerca ROM nel CIA
         (pattern Nintendo Logo)
                  │
         Iniezione ROM payload
                  │
         Aggiornamento hash SHA-256
           in TMD chunk record
                  │
         CIA output pronto
         per installazione CFW
```

### Struttura CIA (Nintendo 3DS)
```
[Header 0x2020]     ← Dimensioni sezioni, content size
[Certificate Chain] ← Firma Nintendo (lasciata intatta)
[Ticket]            ← Title key, Title ID
[TMD]               ← Content hash SHA-256 ← AGGIORNATO
[Content / NCCH]    ← Emulatore + ROM GBA  ← INIETTATO
[Meta]              ← Banner, icona
```

### Perché funziona su CFW?
Luma3DS con **sigpatches** abilitate bypassa la verifica della firma RSA di Nintendo. Il CIA può quindi avere una firma dummy ma deve avere hash del contenuto corretti (aggiornati da questo tool).

---

## ⚠️ Note Legali

- Questo tool è solo per uso **personale** con backup estratti legalmente dai propri giochi originali
- Non redistribuire ROM GBA coperte da copyright
- Il VC Base CIA deve essere estratto dal **tuo** Nintendo 3DS
- Compatibile solo con **New Nintendo 3DS** (N3DS) — il GBA VC è esclusiva N3DS

---

## 🔧 Deploy su GitHub Pages

### Metodo 1 — GitHub Web UI
1. Crea un nuovo repository su [github.com/new](https://github.com/new)
2. Carica i file (`index.html`, `README.md`, `.github/`)
3. Vai su **Settings** → **Pages** → Source: **GitHub Actions**
4. Il workflow si avvia automaticamente

### Metodo 2 — Script automatico (richiede `git` e `gh` CLI)
```bash
chmod +x setup.sh
./setup.sh TUO_USERNAME NOME_REPO
```

### Metodo 3 — Manuale con git
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/TUO_USERNAME/nsui-web.git
git push -u origin main
```
Poi abilita GitHub Pages nelle impostazioni del repo.

---

## 🔗 Link Utili

- [3DS Hacks Guide](https://3ds.hacks.guide) — Guida CFW
- [Luma3DS](https://github.com/LumaTeam/Luma3DS) — Custom Firmware
- [FBI Manager](https://github.com/Steveice10/FBI) — Installatore CIA
- [GodMode9](https://github.com/d0k3/GodMode9) — File manager 3DS

---

## 📄 Licenza

MIT License — vedi [LICENSE](LICENSE)
