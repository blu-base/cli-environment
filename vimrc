"" Vimrc setup
"" Destilled Setup from Chris Toomey
"" https://github.com/christoomey/dotfiles


" Need to set the leader before defining any leader mappings
let mapleader = "\<Space>"

" Remote config loading function
function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/.vim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
      execute 'source' config_file
    endif
  endfor
endfunction

" load Plugin Manager vim-plug
call plug#begin('~/.vim/bundle')
call s:SourceConfigFilesIn('rcplugins')
call plug#end()

" another remote config for post-plugin settings
call s:SourceConfigFilesIn('rcpost')
