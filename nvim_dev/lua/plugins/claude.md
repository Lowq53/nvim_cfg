TAK - konwersacja Claude z Nvim MOŻLIWA:

=== PLUGINY NVIM → CLAUDE ===

1. agentic.nvim (POLECAM)
   - Używa Claude Code CLI
   - Chat w Nvim sidebar
   - BEZ API key (login raz: claude /login)
   - Ctrl+\ toggle chat
   - @ dodaj pliki do kontekstu

2. claudecode.nvim (oficjalny Coder)
   - WebSocket → Claude Code
   - :ClaudeCode otwiera terminal
   - Auto-context z bufora

3. pasky/claude.vim
   - Chat + diff review
   - <Leader>ci implementuj kod
   - Potrzebuje API key

=== SERWISY NAJWIĘCEJ DARMOWYCH MODELI ===

OpenRouter (WINNER):

- 30+ darmowych modeli (:free)
- deepseek-r1:free, qwen-coder:free, llama-3.3:free
- Jeden API wszystkie modele

Groq:

- 14,400 zapytań/dzień
- Llama 3.3 70B (300 tok/s)
- Najszybszy

Google AI Studio:

- 1M tokenów/minutę
- Gemini 2.5 Flash
- Multimodal (tekst+obraz)

SETUP NVIM:
require('agentic').setup({
provider = 'claude-acp'
})

KEYMAPS:

,aa - ask Claude
,ae - edit selection
,ar - refresh chat
<CR> - submit (normal mode)
<C-s> - submit (insert mode)

# METODA 2 - Użyj curl (jeśli masz Git):

curl -L https://github.com/anthropics/anthropic-tools/releases/latest/download/claude-cli-windows.exe -o claude.exe
mv claude.exe C:\Windows\System32\
