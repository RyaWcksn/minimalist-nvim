require("lsp")
require("options")
require("netrw")
require("keymaps")
require("find")
require("grep")
require("statusline")
require("autocommands")
require("colorscheme")
require("plugins")
require("parser")
-- require("dir")


local tracker = require('tracker')

local filter = {
	"sql",
}

local db_path = "~/log_tracker.db"

tracker.setup({
	db_path = db_path,
	filter = filter,
})
