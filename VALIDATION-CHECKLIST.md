# Gentleman.Dots - Checklist de Validación

Este documento es para que Claude valide que la instalación de Gentleman.Dots está completa en una máquina nueva (Zorin OS 17 / Linux).

## Instrucciones para Claude

Ejecutá cada sección en orden. Si algo falla, reportá qué componente y qué error. Al final, dá un resumen de qué está OK y qué falta.

---

## 1. Prerequisitos del Sistema

```bash
# Verificar que existen estas herramientas
command -v git && echo "✓ git"
command -v node && echo "✓ node" && node --version
command -v npm && echo "✓ npm" && npm --version
command -v nvim && echo "✓ nvim" && nvim --version | head -1
command -v fish && echo "✓ fish"
command -v zsh && echo "✓ zsh"
command -v tmux && echo "✓ tmux"
command -v starship && echo "✓ starship"
```

### Herramientas CLI modernas (reemplazos)

```bash
command -v eza && echo "✓ eza (reemplazo de ls)"
command -v bat && echo "✓ bat (reemplazo de cat)"
command -v fd && echo "✓ fd (reemplazo de find)"
command -v rg && echo "✓ rg/ripgrep (reemplazo de grep)"
command -v sd && echo "✓ sd (reemplazo de sed)"
```

Si faltan, instalar con:

```bash
# Debian/Ubuntu/Zorin
sudo apt install eza bat fd-find ripgrep

# El binario de fd en Debian se llama fdfind, crear alias:
mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd

# sd hay que instalarlo con cargo o descargando el binario
cargo install sd
```

---

## 2. Repositorio Clonado

```bash
# Verificar que el repo está clonado
ls -la ~/Gentleman.Dots && echo "✓ Repo existe"

# Verificar remote correcto
cd ~/Gentleman.Dots && git remote -v
# Debería mostrar: https://github.com/PabloEM-23/Gentleman.Dots.git

# Verificar que está actualizado
git fetch myfork && git status
```

---

## 3. WezTerm

### Archivo de configuración

```bash
# Verificar que .wezterm.lua existe en home
ls -la ~/.wezterm.lua && echo "✓ .wezterm.lua existe"

# O verificar ubicación alternativa
ls -la ~/.config/wezterm/wezterm.lua && echo "✓ wezterm.lua en .config"

# Comparar con el del repo
diff ~/Gentleman.Dots/.wezterm.lua ~/.wezterm.lua 2>/dev/null && echo "✓ Configs iguales" || echo "⚠ Configs difieren"
```

### WezTerm instalado

```bash
command -v wezterm && echo "✓ wezterm instalado" && wezterm --version
```

### Instalar/actualizar config

```bash
# Si no existe o difiere:
cp ~/Gentleman.Dots/.wezterm.lua ~/.wezterm.lua
```

---

## 4. Neovim (GentlemanNvim)

### Configuración

```bash
# Verificar que existe la config de nvim
ls -la ~/.config/nvim/init.lua && echo "✓ nvim config existe"

# Verificar estructura LazyVim
ls ~/.config/nvim/lua/plugins/ && echo "✓ plugins dir existe"
```

### Instalar si falta

```bash
# Backup de config existente
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Copiar config
cp -r ~/Gentleman.Dots/GentlemanNvim/nvim ~/.config/nvim

# Abrir nvim para que instale plugins
nvim --headless "+Lazy! sync" +qa
```

---

## 5. Fish Shell (GentlemanFish)

```bash
# Verificar config
ls -la ~/.config/fish/config.fish && echo "✓ fish config existe"

# Verificar fisher (plugin manager)
fish -c "type fisher" 2>/dev/null && echo "✓ fisher instalado"
```

### Instalar si falta

```bash
# Copiar config
cp -r ~/Gentleman.Dots/GentlemanFish/fish ~/.config/fish

# Instalar fisher
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# Instalar plugins
fish -c "fisher update"
```

---

## 6. Zsh (GentlemanZsh)

```bash
# Verificar .zshrc
ls -la ~/.zshrc && echo "✓ .zshrc existe"

# Verificar oh-my-zsh o zinit
ls -la ~/.oh-my-zsh 2>/dev/null && echo "✓ oh-my-zsh" || ls -la ~/.zinit 2>/dev/null && echo "✓ zinit"
```

---

## 7. Tmux (GentlemanTmux)

```bash
# Verificar config
ls -la ~/.tmux.conf && echo "✓ .tmux.conf existe"

# O ubicación XDG
ls -la ~/.config/tmux/tmux.conf && echo "✓ tmux.conf en .config"

# Verificar TPM (Tmux Plugin Manager)
ls -la ~/.tmux/plugins/tpm && echo "✓ TPM instalado"
```

### Instalar si falta

```bash
# Copiar config
cp ~/Gentleman.Dots/GentlemanTmux/.tmux.conf ~/.tmux.conf

# Instalar TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Instalar plugins (dentro de tmux: prefix + I)
```

---

## 8. Zellij (GentlemanZellij)

```bash
# Verificar instalación
command -v zellij && echo "✓ zellij instalado" && zellij --version

# Verificar config
ls -la ~/.config/zellij/config.kdl && echo "✓ zellij config existe"
```

### Instalar si falta

```bash
# Copiar config
mkdir -p ~/.config/zellij
cp -r ~/Gentleman.Dots/GentlemanZellij/* ~/.config/zellij/
```

---

## 9. Starship Prompt

```bash
# Verificar instalación
command -v starship && echo "✓ starship instalado" && starship --version

# Verificar config
ls -la ~/.config/starship.toml && echo "✓ starship.toml existe"
```

### Instalar si falta

```bash
# Instalar starship
curl -sS https://starship.rs/install.sh | sh

# Copiar config
cp ~/Gentleman.Dots/starship.toml ~/.config/starship.toml
```

---

## 10. Claude Code (GentlemanClaude)

### Verificar instalación de Claude Code

```bash
command -v claude && echo "✓ claude instalado" && claude --version
```

### Verificar configuración

```bash
# Verificar archivos principales
ls -la ~/.claude/CLAUDE.md && echo "✓ CLAUDE.md existe"
ls -la ~/.claude/settings.json && echo "✓ settings.json existe"

# Verificar skills
ls ~/.claude/skills/ | wc -l | xargs -I{} echo "✓ {} skills instalados"

# Verificar agents
ls ~/.claude/agents/ | wc -l | xargs -I{} echo "✓ {} agents instalados"

# Verificar hooks
ls ~/.claude/hooks/ | wc -l | xargs -I{} echo "✓ {} hooks instalados"
```

### Verificar MCP servers

```bash
claude mcp list
# Debería mostrar: github, atlassian, chrome-devtools, codex, etc.
```

### Instalar si falta

```bash
cd ~/Gentleman.Dots/GentlemanClaude
chmod +x install.sh
./install.sh
```

---

## 11. Codex CLI (GentlemanCodex)

### Verificar instalación

```bash
# Verificar que codex está instalado
npm list -g @openai/codex 2>/dev/null && echo "✓ codex instalado"

# Verificar versión
codex --version 2>/dev/null || node $(npm root -g)/@openai/codex/bin/codex.js --version
```

### Verificar configuración

```bash
# Verificar config.toml
ls -la ~/.codex/config.toml && echo "✓ codex config existe"

# Verificar contenido crítico
grep "sandbox_mode" ~/.codex/config.toml
# Debería mostrar: sandbox_mode = "danger-full-access"

grep "web_search" ~/.codex/config.toml
# Debería mostrar: web_search = true
```

### Verificar integración MCP con Claude

```bash
claude mcp list | grep codex && echo "✓ codex MCP server configurado"
```

### Instalar si falta

```bash
cd ~/Gentleman.Dots/GentlemanCodex
chmod +x install.sh
./install.sh
```

---

## 12. Terminales Adicionales (Opcionales)

### Ghostty

```bash
command -v ghostty && echo "✓ ghostty instalado"
ls -la ~/.config/ghostty/config && echo "✓ ghostty config existe"
```

### Kitty

```bash
command -v kitty && echo "✓ kitty instalado"
ls -la ~/.config/kitty/kitty.conf && echo "✓ kitty config existe"
```

### Alacritty

```bash
command -v alacritty && echo "✓ alacritty instalado"
ls -la ~/.config/alacritty/alacritty.toml && echo "✓ alacritty config existe"
# O formato antiguo:
ls -la ~/.alacritty.toml && echo "✓ alacritty.toml en home"
```

---

## 13. Test Final de Integración

### Test Claude + Codex

```bash
# Reiniciar Claude Code y probar
claude
# Dentro de Claude, ejecutar:
# > Preguntale a Codex cuál es la capital de Argentina
# Debería responder via mcp__codex__codex
```

### Test Neovim

```bash
nvim --headless -c "checkhealth" -c "qa" 2>&1 | grep -E "(OK|ERROR|WARNING)"
```

### Test Shell

```bash
# Si usas fish
fish -c "echo 'Fish OK'"

# Si usas zsh
zsh -c "echo 'Zsh OK'"
```

---

## Resumen de Ubicaciones

| Componente | Ubicación Config          | Ubicación en Repo          |
| ---------- | ------------------------- | -------------------------- |
| WezTerm    | `~/.wezterm.lua`          | `.wezterm.lua`             |
| Neovim     | `~/.config/nvim/`         | `GentlemanNvim/nvim/`      |
| Fish       | `~/.config/fish/`         | `GentlemanFish/fish/`      |
| Zsh        | `~/.zshrc`                | `GentlemanZsh/`            |
| Tmux       | `~/.tmux.conf`            | `GentlemanTmux/.tmux.conf` |
| Zellij     | `~/.config/zellij/`       | `GentlemanZellij/`         |
| Starship   | `~/.config/starship.toml` | `starship.toml`            |
| Claude     | `~/.claude/`              | `GentlemanClaude/`         |
| Codex      | `~/.codex/`               | `GentlemanCodex/`          |
| Ghostty    | `~/.config/ghostty/`      | `GentlemanGhostty/`        |
| Kitty      | `~/.config/kitty/`        | `GentlemanKitty/`          |
| Alacritty  | `~/.config/alacritty/`    | `alacritty.toml`           |

---

## Notas para Zorin OS 17

1. **Zorin está basado en Ubuntu**, así que usa `apt` para instalar paquetes
2. **fd-find**: En Debian/Ubuntu el paquete se llama `fd-find` y el binario `fdfind`
3. **bat**: En algunas distros el binario se llama `batcat`, crear alias si es necesario
4. **Node.js**: Recomendado instalar via nvm o fnm, no via apt (versión muy vieja)

```bash
# Instalar fnm (Fast Node Manager)
curl -fsSL https://fnm.vercel.app/install | bash
fnm install --lts
```

---

## Comando Rápido de Validación

Ejecutá esto para un resumen rápido:

```bash
echo "=== VALIDACIÓN RÁPIDA ===" && \
echo "Git: $(command -v git >/dev/null && echo '✓' || echo '✗')" && \
echo "Node: $(command -v node >/dev/null && echo '✓' || echo '✗')" && \
echo "Nvim: $(command -v nvim >/dev/null && echo '✓' || echo '✗')" && \
echo "Fish: $(command -v fish >/dev/null && echo '✓' || echo '✗')" && \
echo "Tmux: $(command -v tmux >/dev/null && echo '✓' || echo '✗')" && \
echo "Starship: $(command -v starship >/dev/null && echo '✓' || echo '✗')" && \
echo "Claude: $(command -v claude >/dev/null && echo '✓' || echo '✗')" && \
echo "Codex: $(npm list -g @openai/codex >/dev/null 2>&1 && echo '✓' || echo '✗')" && \
echo "WezTerm: $(command -v wezterm >/dev/null && echo '✓' || echo '✗')" && \
echo "eza: $(command -v eza >/dev/null && echo '✓' || echo '✗')" && \
echo "bat: $(command -v bat >/dev/null && echo '✓' || echo '✗')" && \
echo "fd: $(command -v fd >/dev/null && echo '✓' || echo '✗')" && \
echo "rg: $(command -v rg >/dev/null && echo '✓' || echo '✗')"
```
