--[[
--- NAME
-- nvim-colorizer.lua (NvChad Fork)

--- OVERVIEW
-- Najszybszy silnik podświetlania kolorów dla Neovim napisany w Lua.
-- Rozpoznaje kody kolorów w tekście i nakłada na nie kolory w czasie rzeczywistym.
-- Używać w: projektach frontendowych, konfiguracjach UI, plikach CSS/Tailwind.

--- REQUIREMENTS
-- - Neovim v0.7+
-- - Terminal z obsługą True Color (GUI-like colors)

--- USAGE
-- Wtyczka aktywuje się automatycznie przy zdarzeniu `BufReadPre`.
-- Obsługuje formaty: Hex, RGB, HSL, nazwy kolorów oraz klasy Tailwind CSS.

--- CONFIGURATION DETAILS
-- @filetypes: Definiuje, w jakich plikach jakie parsery są aktywne.
-- @user_default_options:
--   - mode: "background" (koloruje tło pod tekstem)
--   - tailwind: "both" (obsługuje klasy Tailwind przez LSP i silnik wbudowany)
--   - names: true (obsługuje nazwy typu "Red", "Blue")

--- REFERENCES
-- Repository: https://github.com/NvChad/nvim-colorizer.lua
--]]

return {
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup({
				filetypes = {
					"*",
					css = { rgb_fn = true, css = true },
					scss = { rgb_fn = true, css = true },
				},
				user_default_options = {
					RGB = true,
					RRGGBB = true,
					css = true,
					mode = "background",
				},
			})

			-- Autocommand: auto-attach dla .scss/.css
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = {
					"*.scss",
					"*.css",
					"*.html",
					"*.jsx",
					"*.tsx",
					"*.js",
					"*.ts",
					"*.vue",
					"*.lua",
					"*.vim",
				},
				callback = function()
					require("colorizer").attach_to_buffer(0, { css = true })
				end,
			})
		end,
	},
}
