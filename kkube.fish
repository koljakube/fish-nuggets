# i don't need no help
set fish_greeting "Hi."

# my own executables
set PATH $HOME/.usrlocal/bin $PATH

# make rbenv work with fish
set PATH $HOME/.rbenv/bin $PATH
rbenv init

# some convenience functions
function b -d "run command through `bundle exec`"
  bundle exec $argv
end
function s -d "shortcut for git status"
  git status
end
function pi -d "SSH into Raspberry Pi"
  ssh -R 52698:127.0.0.1:52698 dyn.koljaku.be
end
function mpi -d "Mosh into Raspberry Pi"
  mosh dyn.koljaku.be
  # mosh --server='\"LC_CTYPE=en_US.UTF-8 mosh-server\"' dyn.koljaku.be
end

# prompt
function parse_git_dirty -d "sets color to red or green depending on the status of the current branch of git in pwd"
  if test (echo (git status 2> /dev/null | tail -n1)) = "nothing to commit, working directory clean"
    set_color green
  else
    set_color red
  end
end
function fish_prompt -d "Write out the prompt"

	# Color writeable dirs green, read-only dirs red
	if test -w "."
		printf '%s%s' (set_color green) (prompt_pwd)
	else
		printf '%s%s' (set_color red) (prompt_pwd)
	end

  # Print subversion tag or branch
  if test -d ".svn"
          printf ' %s%s%s' (set_color normal) (set_color blue) (parse_svn_tag_or_branch)
  end
        
	# Print subversion revision
	if test -d ".svn"
		printf '%s%s@%s' (set_color normal) (set_color blue) (parse_svn_revision)
	end

	# Print git branch
	if test -d ".git"
		printf '%s[%s%s%s]' (set_color normal) (parse_git_dirty) (parse_git_branch) (set_color normal)
	end
	printf '%s$ ' (set_color normal)
end