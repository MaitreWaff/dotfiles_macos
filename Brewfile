# =============================================================================
# Brewfile — Configuration normale (développement complet)
# =============================================================================
# Idéal pour : machine principale de développement
# Inclut : tout le profil minimal + outils DevOps, cloud, frontend, backend
# Les outils de pentest sont dans Brewfile.pentest (séparé, opt-in)
#
# Installation :
#   brew bundle
#
# Pour installer également le profil minimal au préalable (optionnel,
# toutes les formules sont déjà incluses ici) :
#   brew bundle --file=Brewfile.minimal && brew bundle
# =============================================================================

tap "hashicorp/tap"
tap "ngrok/ngrok"
tap "pulumi/tap"

# ─── CLI — Shell & navigation ─────────────────────────────────────────────────
brew "bat"          # Remplacement de cat avec coloration syntaxique
brew "bat-extras"   # Scripts intégrant bat (batgrep, batman, batdiff…)
brew "curl"         # Transferts HTTP/HTTPS/FTP
brew "eza"          # Remplacement moderne de ls (icônes, couleurs, git)
brew "less"         # Paginateur de texte
brew "nano"         # Éditeur texte léger
brew "tmux"         # Multiplexeur de terminal
brew "wget"         # Téléchargeur HTTP avec reprise de téléchargement
brew "zsh"          # Shell recommandé

# ─── CLI — Git & qualité ──────────────────────────────────────────────────────
brew "git"          # Gestionnaire de versions
brew "git-flow"     # Extensions git-flow (branching model)
brew "gitleaks"     # Scan de secrets dans les dépôts git
brew "gnupg"        # Chiffrement et signatures GPG
brew "shellcheck"   # Linter statique pour scripts shell/bash

# ─── CLI — Langages & runtimes ────────────────────────────────────────────────
brew "go"           # Langage Go (compilateur + outils)
brew "n"            # Gestionnaire de versions Node.js
brew "node"         # Node.js (version Homebrew, gérée aussi via n)
brew "python@3.13"  # Python 3.13
brew "pipx"         # Exécution d'outils Python dans des envs isolés

# ─── CLI — Infrastructure & DevOps ───────────────────────────────────────────
brew "ansible"                  # Automatisation déploiements et configurations
brew "autoconf"                 # Générateur de scripts de configuration
brew "docker"                   # Runtime de conteneurs (CLI)
brew "kompose"                  # Migration docker-compose → Kubernetes
brew "kubernetes-cli"           # kubectl — CLI Kubernetes
brew "libvirt"                  # API de virtualisation C (pilote QEMU/KVM)
brew "mas"                      # CLI pour le Mac App Store
brew "minikube"                 # Cluster Kubernetes local pour développement
brew "pkgconf"                  # Métadonnées compilateur/linker (remplace pkg-config)
brew "qemu"                     # Émulateur et virtualiseur générique
brew "socket_vmnet"             # Daemon vmnet.framework pour QEMU rootless
brew "hashicorp/tap/terraform"  # Infrastructure as Code HashiCorp
brew "pulumi/tap/pulumi"        # Infrastructure as Code multi-cloud (IaC moderne)

# ─── CLI — Web & réseau ───────────────────────────────────────────────────────
brew "httpie"       # Client HTTP en ligne de commande (remplace curl pour le dev)
brew "pnpm"         # Gestionnaire de paquets Node.js rapide et économe en espace

# ─── CLI — Data & documents ───────────────────────────────────────────────────
brew "exiftool"     # Lecture/écriture de métadonnées EXIF (images, vidéos)
brew "pandoc"       # Conversion de formats (Markdown → PDF, DOCX, HTML…)
brew "poppler"      # Bibliothèque PDF (pdfinfo, pdftotext, pdftoppm…)
brew "postgresql@14" # Base de données PostgreSQL 14

# ─── CLI — Générateurs de site & contenus ────────────────────────────────────
brew "hugo"         # Générateur de site statique ultra-rapide (Go)

# ─── CLI — Utilitaires ────────────────────────────────────────────────────────
brew "asciinema"    # Enregistrement et partage de sessions terminal
brew "autoconf"     # Constructeur de scripts configure
brew "cowsay"       # Vache ASCII qui parle (fortune | cowsay 🐮)
brew "fontconfig"   # API de configuration de polices
brew "fortune"      # Générateur de citations aléatoires
brew "telnet"       # Protocole TELNET (test de ports, debug réseau)
brew "ungit"        # Interface web pour git (visual git log)
brew "watchman"     # Surveillance de fichiers et déclenchement d'actions

# ─── Apps GUI — Productivité & communication ──────────────────────────────────
cask "alfred"             # Lanceur d'applications et productivité (remplace Spotlight)
cask "appcleaner"         # Désinstalleur propre
cask "discord"            # Chat vocal et textuel (communautés dev)
cask "keyboard-maestro"   # Automatisation macOS (macros, raccourcis clavier)
cask "dropbox"            # Stockage cloud et synchronisation
cask "google-drive"       # Stockage cloud Google
cask "libreoffice"        # Suite bureautique open source
cask "macdown"            # Éditeur Markdown avec prévisualisation live
cask "monitorcontrol"     # Contrôle luminosité/volume des écrans externes
cask "microsoft-teams"    # Visioconférence et collaboration Microsoft
cask "notion"             # Base de connaissance et gestion de projet
cask "notion-calendar"    # Agenda intégré à Notion
cask "notion-mail"        # Client mail intégré à Notion
cask "obsidian"           # Prise de notes en Markdown (graphe de connaissances)
cask "royal-tsx"          # Gestionnaire de connexions distantes (SSH, RDP, VNC)
cask "tella"              # Enregistrement vidéo d'écran
cask "texmaker"           # Éditeur LaTeX

# ─── Apps GUI — Navigateurs ───────────────────────────────────────────────────
cask "arc"            # Navigateur Chromium (gestion par espaces)
cask "brave-browser"  # Navigateur axé vie privée (bloqueur ads intégré)
cask "firefox"        # Navigateur web
cask "google-chrome"  # Navigateur Google Chrome

# ─── Apps GUI — Développement ─────────────────────────────────────────────────
cask "db-browser-for-sqlite" # Interface graphique pour bases SQLite
cask "docker-desktop"        # Docker avec UI (orchestrateur de conteneurs)
cask "expo-orbit"            # Builds et simulateurs Expo/React Native depuis la menu bar
cask "git-credential-manager" # Gestion centralisée des credentials git
cask "github"                # Client desktop GitHub
cask "gitkraken"             # Client git graphique avancé
cask "hex-fiend"             # Éditeur hexadécimal (analyse binaire)
cask "iterm2"                # Terminal avancé
cask "ngrok"                 # Tunnels HTTPS vers localhost (webhooks, démos)
cask "postman"               # Plateforme de développement et test d'API
cask "sublime-text"          # Éditeur de texte léger et rapide
cask "visual-studio-code"    # Éditeur de code

# ─── Apps GUI — Cloud & virtualisation ────────────────────────────────────────
cask "utm"                     # VMs macOS/Linux/Windows (arm64, basé sur QEMU)
cask "vagrant"                 # Gestion d'environnements de développement virtualisés
cask "vagrant-manager"         # Interface menu bar pour Vagrant
cask "vagrant-vmware-utility"  # Plugin Vagrant pour VMware
cask "virtualbox"              # Hyperviseur x86 open source
cask "windows-app"             # Connexion bureau à distance Windows (ex RDP)
cask "xquartz"                 # Système X Window pour macOS (apps Linux via X11)

# ─── Apps GUI — IA & assistants ───────────────────────────────────────────────
cask "chatgpt"      # App desktop ChatGPT officielle (OpenAI)
cask "claude"       # App desktop Claude officielle (Anthropic)
cask "claude-code"  # Assistant IA terminal Claude Code

# ─── Apps GUI — Utilitaires & médias ─────────────────────────────────────────
cask "adobe-acrobat-reader" # Lecteur PDF Adobe
cask "appcleaner"           # Désinstalleur propre (supprime les fichiers associés)
cask "binance"              # Exchange crypto
cask "the-unarchiver"       # Extraction d'archives (zip, rar, 7z, tar…)
cask "vlc"                  # Lecteur multimédia universel

# ─── Mac App Store ────────────────────────────────────────────────────────────
mas "CmdRef", id: 956853496           # Référence de commandes (cheatsheets)
mas "Data Jar", id: 1453273600        # Stockage de données pour Raccourcis Siri
mas "Developer", id: 640199958        # App développeur Apple officielle
mas "Jayson", id: 1468691718          # Viewer/éditeur JSON interactif
mas "Kindle", id: 302584613           # Liseuse Kindle
mas "OX Drive", id: 818195014         # Client Open-Xchange Drive
mas "Quick Note", id: 1472935217      # Notes rapides depuis la barre de menu
mas "Stockfish", id: 801463932        # Moteur d'échecs open source
mas "SysNetInfo", id: 1118988797      # Informations système et réseau
mas "webextension", id: 6502697899    # Capacities Web Extension
mas "Xcode", id: 497799835            # IDE Apple (requis pour iOS/macOS dev)

# ─── VS Code — Extensions ────────────────────────────────────────────────────
# Essentielles (reprises du profil minimal)
vscode "aaron-bond.better-comments"
vscode "christian-kohler.path-intellisense"
vscode "dbaeumer.vscode-eslint"
vscode "eamodio.gitlens"
vscode "editorconfig.editorconfig"
vscode "esbenp.prettier-vscode"
vscode "formulahendry.auto-close-tag"
vscode "formulahendry.auto-rename-tag"
vscode "github.github-vscode-theme"
vscode "mhutchie.git-graph"
vscode "oderwat.indent-rainbow"
vscode "pkief.material-icon-theme"
vscode "redhat.vscode-yaml"
vscode "streetsidesoftware.code-spell-checker"
vscode "usernamehw.errorlens"
vscode "yoavbls.pretty-ts-errors"
# Langages — TypeScript / JavaScript
vscode "burkeholland.simple-react-snippets"
vscode "cardinal90.multi-cursor-case-preserve"
vscode "christian-kohler.npm-intellisense"
vscode "dsznajder.es7-react-js-snippets"
vscode "formulahendry.code-runner"
vscode "herrlax.ts-interface-from-class"
vscode "infeng.vscode-react-typescript"
vscode "mattpocock.ts-error-translator"
vscode "mike-co.import-sorter"
vscode "ms-vscode.vscode-typescript-next"
vscode "rodrigovallades.es7-react-js-snippets"
vscode "rvest.vs-code-prettier-eslint"
vscode "sgryt.typescript-pack"
vscode "shibu.nextjs-js-ts-code-snippets"
vscode "steoates.autoimport"
vscode "xabikos.javascriptsnippets"
# Langages — Python
vscode "donjayamanne.python-environment-manager"
vscode "donjayamanne.python-extension-pack"
vscode "johnguo.simply-view-image-for-python-opencv-debugging"
vscode "kevinrose.vsc-python-indent"
vscode "ms-python.debugpy"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-python.vscode-python-envs"
vscode "njpwerner.autodocstring"
vscode "gsgupta.opencv-snippets"
# Langages — Go
vscode "golang.go"
# Langages — Rust
vscode "rust-lang.rust-analyzer"
# Langages — C/C++
vscode "ms-vscode.cmake-tools"
vscode "ms-vscode.cpp-devtools"
vscode "ms-vscode.cpptools"
vscode "ms-vscode.cpptools-extension-pack"
vscode "ms-vscode.cpptools-themes"
vscode "ms-vscode.makefile-tools"
vscode "twxs.cmake"
# Langages — Web (HTML/CSS)
vscode "austenc.tailwind-docs"
vscode "bradlc.vscode-tailwindcss"
vscode "ecmel.vscode-html-css"
vscode "formulahendry.docker-explorer"
vscode "ritwickdey.liveserver"
vscode "stylelint.vscode-stylelint"
# Langages — Vue / Angular
vscode "nrwl.angular-console"
vscode "vue.volar"
# Langages — Astro / MDX / Jinja
vscode "astro-build.astro-vscode"
vscode "unifiedjs.vscode-mdx"
vscode "wholroyd.jinja"
# Langages — Django / Python web
vscode "batisteo.vscode-django"
# Langages — Markdown
vscode "bierner.markdown-yaml-preamble"
vscode "cungen.markdown-slide"
vscode "dalirnet.rtl-markdown"
vscode "davidanson.vscode-markdownlint"
vscode "fantasy.markdown-all-in-one-for-web"
vscode "gera2ld.markmap-vscode"
vscode "gitbook.gitbook-vscode"
vscode "hnw.vscode-auto-open-markdown-preview"
vscode "marp-team.marp-vscode"
vscode "pomdtr.markdown-kroki"
vscode "shd101wyy.markdown-preview-enhanced"
vscode "takumii.markdowntable"
vscode "tchayen.markdown-links"
vscode "toramameseven.markdown-docx"
vscode "yzane.markdown-pdf"
vscode "yzhang.markdown-all-in-one"
vscode "zhaouv.vscode-markdown-draw"
# Langages — YAML / TOML / JSON
vscode "tamasfe.even-better-toml"
vscode "yamlhunter.yamltemplatemaker"
vscode "zainchen.json"
vscode "grapecity.gc-excelviewer"
# Conteneurs & DevOps
vscode "docker.docker"
vscode "jeff-hykin.better-dockerfile-syntax"
vscode "ms-azuretools.vscode-containers"
vscode "ms-azuretools.vscode-docker"
vscode "ms-vscode-remote.remote-containers"
vscode "ms-vscode-remote.remote-ssh"
vscode "ms-vscode-remote.remote-ssh-edit"
vscode "ms-vscode-remote.remote-wsl"
vscode "ms-vscode-remote.vscode-remote-extensionpack"
vscode "ms-vscode.remote-explorer"
vscode "ms-vscode.remote-repositories"
vscode "ms-vscode.remote-server"
vscode "okteto.remote-kubernetes"
vscode "p1c2u.docker-compose"
vscode "techiecouch.docker-essentials"
# Infrastructure as Code
vscode "4ops.terraform"
vscode "dannysteenman.cloudformation-yaml-snippets"
vscode "hashicorp.terraform"
vscode "itayadler.terraform-ssm"
vscode "loganarnett.lambda-snippets"
vscode "sameeramin.cdk-snippets-for-python"
# AWS
vscode "amazonwebservices.amazon-q-vscode"
vscode "amazonwebservices.aws-toolkit-vscode"
vscode "antstack.aws-js-code-snippet"
vscode "boto3typed.boto3-ide"
vscode "congnguyendinh0.aws-amplify-flutter-snippet"
vscode "jabrythehutt.awsrd"
vscode "john-goldsmith.vscode-aws-cloudformation-auto-template-generator"
vscode "mark-tucker.aws-cli-configure"
vscode "ms-vscode.azure-repos"
vscode "mziyabo.vscode-codedeploy"
vscode "necatiarslan.aws-access-vscode-extension"
vscode "necatiarslan.aws-s3-vscode-extension"
vscode "poyashad.display-aws-amplify-environment"
vscode "rafaelrodrigues.convertto-ssm"
vscode "rafwilinski.dynamodb-vscode-snippets"
vscode "teetangh.aws-essentials"
vscode "vscode-aws-console.vscode-aws-console"
vscode "azurepaas-tools.vscode-learncloud"
# Base de données
vscode "alexcvzz.vscode-sqlite"
vscode "qwtel.sqlite-viewer"
# Test & qualité
vscode "firsttris.vscode-jest-runner"
vscode "kisstkondoros.vscode-codemetrics"
vscode "orta.vscode-jest"
vscode "sonarsource.sonarlint-vscode"
# Git avancé
vscode "donjayamanne.githistory"
vscode "github.codespaces"
vscode "github.remotehub"
vscode "github.vscode-github-actions"
vscode "henriquebruno.github-repository-manager"
vscode "vsls-contrib.gitdoc"
# API & HTTP
vscode "eridem.vscode-postman"
vscode "humao.rest-client"
vscode "postman.postman-for-vscode"
vscode "rangav.vscode-thunder-client"
# Jupyter & data science
vscode "ms-toolsai.jupyter"
vscode "ms-toolsai.jupyter-keymap"
vscode "ms-toolsai.jupyter-renderers"
vscode "ms-toolsai.vscode-jupyter-cell-tags"
vscode "ms-toolsai.vscode-jupyter-slideshow"
# IA & assistance au code
vscode "10nates.ollama-autocoder"
vscode "anthropic.claude-code"
vscode "codium.codium"
vscode "danielsanmedium.dscodegpt"
vscode "technovangelist.ollamamodelfile"
# UI & thèmes
vscode "adpyke.codesnap"
vscode "corernd.wai-vscode"
vscode "igorsbitnev.error-gutters"
vscode "jacobdufault.fuzzy-search"
vscode "johnpapa.vscode-peacock"
vscode "pnp.polacode"
vscode "tonybaloney.vscode-pets"
vscode "vscode-extensions-farshid.vscode-extensions-farshid"
vscode "vscode-icons-team.vscode-icons"
vscode "wattenberger.footsteps"
vscode "xuangeaha.vsmarketplace-badges"
# Productivité & snippets
vscode "albert.tabout"
vscode "alefragnani.bookmarks"
vscode "binarybytes.snippets"
vscode "ctc.vscode-tree-extension"
vscode "deerawan.vscode-dash"
vscode "eliostruyf.vscode-front-matter"
vscode "fallenmax.mithril-emmet"
vscode "foam.foam-vscode"
vscode "jacobdufault.fuzzy-search"
vscode "monish.regexsnippets"
vscode "node-projects.vscode-designer-addon"
vscode "oouo-diogo-perdigao.docthis"
vscode "quicktype.quicktype"
vscode "searking.preview-vscode"
vscode "shinotatwu-ds.file-tree-generator"
vscode "tyriar.lorem-ipsum"
vscode "wallabyjs.console-ninja"
vscode "wallabyjs.quokka-vscode"
# Diagrammes & visualisation
vscode "hall.draw"
vscode "hediet.vscode-drawio"
vscode "pomdtr.excalidraw-editor"
# Débogage navigateur
vscode "firefox-devtools.vscode-firefox-debug"
vscode "ms-vscode.vscode-js-profile-flame"
# PDF & documents
vscode "tomoki1207.pdf"
# Autres langages
vscode "gluestack.gluestack-vscode"
vscode "prisma.prisma"
vscode "suhelmakkad.shadcn-ui"
