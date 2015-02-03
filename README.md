# check-update

Tool for pkgsrc tree. Reading whole tree and generates the list
of To-Be-Updated packges.

## Files
- Makefile
- environment-sample.mk
- README.md	      (Markdown document, this file)
- check-update	      (perl script) Main Script to find a new version of the package
- collect-stats	      (perl script) Compile table into [00_Summary.html](www.ki.nu/~makoto/pkgsrc/check-update/00_Summary.html)
- merge-check-update  (perl script) Merge by-category result into 00_Whole.html

## check-update
>  check-update -h

will tell you the other options.

>  check-update -u

is the most typical usage. Reading /usr/pkgsrc and by category
it will 'cvs update', and generates the report as

>  ~/public_html/pkgsrc/check-update/yyyy-dd-mm.html

(eval `ssh-agent`; ssh-add ) may be recommended to get
cvs udpate done smoothly).

But it will take several tens of hours.
Instead, make -j 12 may be good to finish in several hours
(make is assumed as BSD make).

>  check-update -x d -c category -P packagename

is the way to debug particular package.
