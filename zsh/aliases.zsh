alias reload!='exec "$SHELL" -l'

# alias v='vim'
alias vi='vim'

alias ls='exa -la'
alias tree='exa --tree'

alias wget='wget -c'

alias history='history 0'
alias h='history'

alias gmailctlbashme='$HOME/.asdf/installs/golang/1.14.1/packages/bin/gmailctl --config=$HOME/.gmailctl-bashme'

alias gmailctlfyc='$HOME/.asdf/installs/golang/1.14.1/packages/bin/gmailctl --config=$HOME/.gmailctl-fyc'

alias orgmode="emacsclient -n -e '(my/create-org-frame)'"
alias runphp="docker run --rm -v $(pwd):/app -w /app php:cli php $1"
alias treport="/usr/lib/tsung/bin/tsung_stats.pl; google-chrome-stable report.html"

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	size=$(
		stat -f"%z" "${tmpFile}" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
	);

	local cmd="";
	if (( size < 52428800 )); then
		if hash zopfli 2> /dev/null; then
			# the .tar file is smaller than 50 MB and Zopfli is available; use it
			cmd="zopfli";
		elif hash pigz 2> /dev/null; then
			cmd="pigz -11"
		fi;
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz";
		else
			cmd="gzip";
		fi;
	fi;

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";

	zippedSize=$(
		stat -f"%z" "${tmpFile}.gz" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}.gz" 2> /dev/null; # GNU `stat`
	);

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1   ;;
            *.tar.gz)  tar xvzf $1   ;;
            *.bz2)     bunzip2 $1    ;;
            *.rar)     unrar x $1    ;;
            *.gz)      gunzip $1     ;;
            *.tar)     tar xvf $1    ;;
            *.tbz2)    tar xvjf $1   ;;
            *.tgz)     tar xvzf $1   ;;
            *.zip)     unzip $1      ;;
            *.Z)       uncompress $1 ;;
            *.7z)      7z x $1       ;;
            *)         echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
