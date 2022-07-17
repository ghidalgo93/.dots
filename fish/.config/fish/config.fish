if status is-interactive
    # Commands to run in interactive sessions can go here
end

## App configs

# starship sourcing
starship init fish | source
# 1password
# op completion fish | source


## Files to source
source ~/.env

#### Abbreviations

## CLI
abbr cat "bat"
abbr mkdir "mkdir -pv"
abbr c "clear"
abbr tree "tree -C"
if type -q exa
  abbr ll "exa -l -g --icons"
  abbr lla "exa -l -g --icons -a"
end

## Editor
abbr v "nvim"
abbr n "~/bin/nvb"

## Git
abbr gi "git init"
abbr gs "git status"
abbr gp "git push"
abbr ga "git add"
abbr gc "git commit -m"
abbr gb "git branch"
abbr gd "git diff"
abbr gco "git checkout"
abbr gra "git remote add"
abbr gpo "git push origin"
abbr gpom "git push origin master"

#### FZF config
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fzf_configure_bindings --git_log=\cg
fzf_configure_bindings --dir=\cf
set fzf_fd_opts --hidden --exclude=.git
set fzf_preview_dir_cmd exa --all --color=always

## Fix vi mode new line issue 
function fish_vi_cursor; end
## Set fish user key bindings
set fish_key_bindings fish_user_key_bindings
