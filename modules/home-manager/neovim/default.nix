{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraConfig = ''
      lua require('gitsigns').setup()

      set list listchars=nbsp:¬,tab:»·,trail:·,extends:>
      set shiftwidth=4
      set softtabstop=4
      set tabstop=4
      set wildmode=longest,list,full
      set wildmenu
      autocmd ColorScheme * highlight Whitespace ctermfg=red guifg=#FF0000
      autocmd BufWritePre * :%s/\s\+$//e
      colorscheme dracula
      set undofile
      set ignorecase
      unmap Y

      " Jump to last cursor position when opening files
      " See |last-position-jump|.
      :au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    '';

    plugins = with pkgs.vimPlugins; [
      vim-commentary
      vim-fugitive
      vim-nix
      vim-rhubarb
      copilot-vim
      dracula-vim
      gitsigns-nvim
    ];
  };
}
