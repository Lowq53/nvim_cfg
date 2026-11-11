# Schowek Neovima przez SSH

## Zmiana

W `lua/tmp/cpy_linux.lua` provider OSC 52 dla sesji z `SSH_CONNECTION` miał nieczytelne formatowanie. Uporządkowałem definicję i dodałem `cache_enabled = 0`, aby provider nie korzystał z cache Neovima. Provider nadal obsługuje kopiowanie i wklejanie przez OSC 52. Wklejanie z lokalnego schowka wymaga, żeby terminal (oraz ewentualny tmux) obsługiwał odpowiedź na zapytanie OSC 52.

Poza SSH wybór pozostaje bez zmian: Wayland używa `wl-copy`/`wl-paste`, a X11 `xclip` lub `xsel`.

## Diagnostyka wykonana

Polecenia:

```sh
uname -a
cat /etc/os-release
env | sort | rg '^(SSH|DISPLAY|WAYLAND|TERM|TMUX|XDG_SESSION|SHELL|PATH)'
command -v nvim
nvim --version | head -3
for c in wl-copy wl-paste xclip xsel ssh tmux; do command -v "$c" || true; done
tmux show-options -g
tmux show-options -s
rg -n -i 'set-clipboard|allow-passthrough|clipboard|osc52|wl-copy|xclip' ~/.tmux.conf ~/.config/tmux ~/.config/kitty ~/.zshrc 2>/dev/null
```

Wykryte środowisko: Arch Linux, połączenie SSH, tmux 3.8 i Kitty. Dostępne były `wl-copy`, `wl-paste` i `xclip`; w bieżącej sesji brakowało `WAYLAND_DISPLAY`, więc gałąź Wayland nie zostałaby wybrana. W konfiguracji tmux znaleziono `set-clipboard on` oraz `allow-passthrough on`.

## Walidacja

Sprawdziłem składnię i aktualne zachowanie providera w źródle Neovima: `vim.ui.clipboard.osc52` wysyła kopię przez OSC 52, a przy wklejaniu czeka na odpowiedź terminala do 10 sekund. Próba uruchomienia Neovima w trybie headless do inspekcji providera zakończyła się błędem zapisu pliku ShaDa, ponieważ środowisko diagnostyczne ma katalog stanu tylko do odczytu. Nie przeprowadzono testu kopiowania w interaktywnej sesji SSH.
