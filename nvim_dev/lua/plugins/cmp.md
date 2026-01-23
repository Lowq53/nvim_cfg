# 📚 LuaSnip Configuration Documentation

## 1. Plugin Configuration Analysis (`snippets.lua`)

### Current Setup
Your config uses **blink.cmp + LuaSnip** hybrid approach:
- **LuaSnip** = snippet engine (handles expansion, jumps, choices)
- **blink.cmp** = completion menu (shows suggestions, faster than nvim-cmp)
- **friendly-snippets** = VSCode-format snippets library

### Key Features
```lua
-- ✓ Auto-loads snippets from both sources:
require("luasnip.loaders.from_vscode").lazy_load()  -- friendly-snippets
require("luasnip.loaders.from_lua").lazy_load()     -- custom Lua snippets

-- ✓ Extends "all" filetype to every file:
ls.filetype_extend("_", { "all" })
```

### Keybindings Active in Your Config

**LuaSnip (Insert/Select mode):**
- `Ctrl+k` → Expand snippet or jump forward
- `Ctrl+j` → Jump backward
- `Ctrl+n` → Next choice in choice_node
- `Ctrl+p` → Previous choice in choice_node
- `Ctrl+l` → Cycle choices (duplicate of Ctrl+n)

**blink.cmp (Completion menu):**
- `Ctrl+n` / `Ctrl+p` → Navigate suggestions
- `Tab` / `Shift+Tab` → Jump forward/backward in snippet
- `Enter` / `Ctrl+l` / `Ctrl+y` → Accept suggestion
- `Ctrl+k` → Show/hide documentation

**⚠️ Conflict:** `Ctrl+k` is used by both LuaSnip (jump) and blink (docs). Consider remapping.

---

## 2. Snippet Documentation (`all.lua`)

### Installation Path
```
~/.config/nvim/lua/snippets/all.lua
```
Or on Windows:
```
C:\Users\LOWq_53\AppData\Local\nvim\lua\snippets\all.lua
```

### Available Snippets

#### **Separators**
| Trigger | Output | Description |
|---------|--------|-------------|
| `h1` | `▰▰▰▰▰...` (72 chars) | Thick block |
| `h2` | `∎∎∎∎∎...` | Square |
| `h3` | `═════...` | Double line |
| `h4` | `─────...` | Thin line |
| `eq` | `=====...` | Equal signs |
| `emd` | `—————...` | Em dash |
| `und` | `‗‗‗‗‗...` | Underscore |
| `wave` | `﹋﹋﹋﹋﹋...` | Wavy line |
| `wave2` | `◤◢◣◥◤◢...` | Pattern |
| `sep` | Choice menu | Press `Ctrl+n` to cycle all separators |

**Example:**
```lua
-- Type: h1
-- Result in Lua file:
-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

-- Type: h3
-- Result in Python:
# ════════════════════════════════════════════════════════════════════════════
```

#### **Timestamp Header**
| Trigger | Output |
|---------|--------|
| `ht` | Timestamp + separator + cursor |

**Example:**
```lua
-- Type: ht
-- Result:
-- 14:23 23 01 25 / Block 1
-- ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
-- [cursor here]
```

#### **Full Header**
| Trigger | Output |
|---------|--------|
| `header` | Title + date + separators |

**Example:**
```lua
-- Type: header
-- Result:
-- ------------------------------------------------------------------------
-- TITLE: [your text here]
-- DATE:  2025-01-23
-- ------------------------------------------------------------------------
```

#### **Todo Checkboxes**

| Trigger | Indent | Checkbox | Example Output |
|---------|--------|----------|----------------|
| `t` | None | `[ ]` or `( )` | `-- - [ ] zadanie` |
| `todo` | None | `[ ]` or `( )` | `-- - [ ] zadanie` |
| `t1` | 2 spaces | `[ ]` or `( )` | `--   - [ ] podpunkt` |
| `t2` | 4 spaces | `[ ]` or `( )` | `--     - [ ] głębszy` |
| `todo2` | Nested | Both | See below |

**Auto-detection by filetype:**

```python
# Python file - type: t
# - [ ] task

# Type: t1
#   - [ ] subtask
```

```markdown
<!-- Markdown file - type: t -->
- [ ] task

<!-- Type: t1 -->
  - [ ] subtask
```

```lua
-- Lua file - type: t
-- - [ ] task

-- Type: t1
--   - [ ] subtask
```

**Checkbox switching:**
1. Type `t` → inserts `- [ ] zadanie`
2. Press `Ctrl+n` → changes to `- ( ) zadanie`
3. Press `Ctrl+n` again → back to `[ ]`

**`todo2` nested example:**
```lua
-- Type: todo2
-- Result:
-- - [ ] główne zadanie
--   - ( ) podpunkt
--   - ( ) kolejny podpunkt  ← optional, press Ctrl+n to add
```

### Navigation Flow

```
1. Type trigger (e.g., "t")
2. Snippet expands
3. Press Ctrl+k to jump to next field
4. Press Ctrl+n to cycle checkbox [ ] ↔ ( )
5. Press Ctrl+j to jump back
```

---

## 3. Improvements

### High Priority

**A. Fix Keybinding Conflicts**
```lua
-- Current conflict: Ctrl+k (LuaSnip jump vs blink docs)
-- Solution: Remap blink docs to Ctrl+h

-- In blink.cmp opts:
keymap = {
  ["<C-h>"] = { "show_documentation", "hide_documentation" },  -- Changed
  ["<C-k>"] = nil,  -- Remove conflict
}
```

**B. Add Snippet Reload Command**
```lua
-- Add to snippets.lua config:
vim.api.nvim_create_user_command("SnippetReload", function()
  require("luasnip.loaders.from_lua").load({
    paths = vim.fn.stdpath("config") .. "/lua/snippets"
  })
  vim.notify("Snippets reloaded!", vim.log.levels.INFO)
end, {})
```

**C. Enable Snippet Search**
```lua
-- Add keymap to browse available snippets:
vim.keymap.set("n", "<leader>ss", function()
  require("luasnip.extras.snippet_list").open()
end, { desc = "Search snippets" })
```

### Medium Priority

**D. Add Context-Aware Todos**
```lua
-- Detect if inside code block vs comment
-- Auto-select ( ) for in-progress tasks, [ ] for pending
```

**E. Expand Comment Detection**
```lua
-- Current: handles Lua (--), Python (#), etc.
-- Add: C/C++ (//), HTML (<!--), CSS (/* */)

local function comment_prefix()
  local cs = vim.bo.commentstring or "# %s"
  -- Add multi-line comment detection for /* */ and <!-- -->
  if cs:match("/%*") then
    return "/* "
  elseif cs:match("<!%-%-") then
    return "<!-- "
  end
  -- ... existing logic
end
```

**F. Add Date Formats**
```lua
-- New snippets:
s("date", { f(function() return os.date("%Y-%m-%d") end) })
s("time", { f(function() return os.date("%H:%M:%S") end) })
s("datetime", { f(function() return os.date("%Y-%m-%d %H:%M") end) })
```

### Low Priority

**G. Visual Snippet Selection**
```lua
-- Select text in visual mode, type trigger to wrap
-- Example: Select "important" → type "bold" → **important**
```

**H. Add Template Snippets**
```lua
-- File-specific templates:
-- - Lua module boilerplate
-- - Python class skeleton
-- - Markdown frontmatter
```

**I. Snippet Debugging**
```lua
-- Show snippet source when expanding:
vim.g.luasnip_debug = true  -- Add to config
```

---

## 4. Quick Reference Card

```
EXPANSION:          Ctrl+k (or Tab in some contexts)
JUMP BACK:          Ctrl+j (or Shift+Tab)
CYCLE CHOICE:       Ctrl+n / Ctrl+p
ACCEPT COMPLETION:  Enter / Ctrl+y
SHOW DOCS:          Ctrl+k (in completion menu)

CONFLICTS TO FIX:
  Ctrl+k = Both LuaSnip jump AND blink docs
  → Suggest: Remap blink docs to Ctrl+h
```

---

## 5. Troubleshooting

**Snippets not showing:**
```bash
# Check if files exist:
ls ~/.config/nvim/lua/snippets/all.lua

# Reload snippets:
:SnippetReload  # (after adding the command from improvements)

# Debug LuaSnip:
:lua print(vim.inspect(require("luasnip").get_snippets("all")))
```

**Choice not cycling:**
```
1. Make sure cursor is INSIDE the choice field
2. Press Ctrl+n (not Tab)
3. Check if choice_node is defined in snippet
```

**Comment prefix wrong:**
```lua
-- Check your filetype:
:set ft?

-- Test comment detection:
:lua print(vim.bo.commentstring)
```
