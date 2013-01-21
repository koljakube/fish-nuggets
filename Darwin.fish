# Various locations for TextMate's mate command
if test -f "$HOME/.usrlocal/bin/mate"
  set -x EDITOR "$HOME/.usrlocal/bin/mate -w"
else if test -f "/usr/local/bin/mate"
	set -x EDITOR "/usr/local/bin/mate -w"
else
	set -x EDITOR "/usr/bin/mate -w"
end

set BROWSER open

function ff -d "open Finder at current location"
  open -a Finder.app .
end
