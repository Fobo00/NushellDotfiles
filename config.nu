# config.nu
#
# Installed by:
# version = "0.110.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config.completions.algorithm = "substring"
$env.config.edit_mode = "vi"
$env.config.highlight_resolved_externals = true
$env.config.buffer_editor = "nvim"

$env.FZF_DEFAULT_OPTS = r#'--style full 
    --border --padding 1,2 
    --border-label ' Demo ' --input-label ' Input ' --header-label ' File Type ' 
    --bind 'result:transform-list-label:
        if [[ -z $FZF_QUERY ]]; then
          echo " $FZF_MATCH_COUNT items "
        else
          echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
        fi
        ' 
    --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Previewing [%s] " {}' 
    --bind 'focus:+transform-header:file --brief {} || echo "No file selected"' 
    --bind 'ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)' 
    --color 'border:#aaaaaa,label:#cccccc' 
    --color 'preview-border:#9999cc,preview-label:#ccccff' 
    --color 'list-border:#669966,list-label:#99cc99' 
    --color 'input-border:#996666,input-label:#ffcccc' 
    --color 'header-border:#6699cc,header-label:#99ccff''#


# Check if some command available in current shell
def 'is-installed' [ app: string ] {
		  ((which $app | length) > 0)
}

#############################################################
# CARAPACE
#---------------------------------------------------
if (is-installed carapace) {
	$env.CARAPACE_BRIDGES = 'fish,bash,inshellisense' # optional
	mkdir $"($nu.cache-dir)"
	carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

	# ${UserConfigDir}/nushell/config.nu
	source $"($nu.cache-dir)/carapace.nu"
}


#############################################################
# STARSHIP
#---------------------------------------------------
if (is-installed starship) {
	mkdir ($nu.data-dir | path join "vendor/autoload")
	starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
}
