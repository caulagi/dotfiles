local opt = vim.opt
local fn = vim.fn

opt.listchars = {
    tab = "→ ",
    eol = "¬",
    trail = "⋅",
    extends = "❯",
    precedes = "❮",
}
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.wildmode = longest,list,full
opt.wildmenu = true
opt.ignorecase = true
opt.undofile = true

if fn.executable("rg") then
    -- if ripgrep installed, use that as a grepper
    opt.grepprg = "rg --vimgrep --no-heading"
    opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
    -- create autocmd to automatically open quickfix window when grepping
    vim.cmd([[autocmd QuickFixCmdPost [^l]* nested cwindow]])
end
