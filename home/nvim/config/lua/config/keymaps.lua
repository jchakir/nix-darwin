local map = vim.keymap.set

map("n", "<S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<leader>wj", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>ws", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>wl", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split Window Right", remap = true })

map("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Selected Text/Line Down" })
map("n", "<A-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Selected Text/Line Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Selected Text/Line Down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Selected Text/Line Up" })
map("v", "<A-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Selected Text/Line Down" })
map("v", "<A-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Selected Text/Line Up" })

map("n", "<C-Right>", "<C-W>l", { desc = "Move Focus to Right Window" })
map("n", "<C-Left>", "<C-W>h", { desc = "Move Focus to Left Window" })
map("n", "<C-Up>", "<C-W>k", { desc = "Move Focus to Upper Window" })
map("n", "<C-Down>", "<C-W>j", { desc = "Move Focus to Lower Window" })

map("v", "p", '"_dP', { desc = "Keep selected text on paste in visual mode" })

-- Ctrl-c / Ctrl-v / Ctrl-x copy, paste and cut through the system clipboard
map("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
map("v", "<C-v>", '"+p', { desc = "Paste from clipboard" })
map("v", "<C-x>", '"+d', { desc = "Cut to clipboard" })

map("n", "<C-c>", '"+yy', { desc = "Copy line to clipboard" })
map("n", "<C-v>", '"+p', { desc = "Paste from clipboard" })
map("n", "<C-x>", '"+dd', { desc = "Cut line to clipboard" })
