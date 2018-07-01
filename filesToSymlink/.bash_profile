# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
export PATH="$HOME/dotfiles/scripts:$PATH";
export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}";


#ignore DS_Store
export FIGNORE=DS_Store

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


eval $(/usr/libexec/path_helper -s)
