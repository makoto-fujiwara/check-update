# check-update

Tool for pkgsrc tree. Reading whole tree and generates the list
of To-Be-Updated packges.

## Files

File name  | Description
---------- | -------------
README.md	      |   [Markdown](https://help.github.com/articles/markdown-basics/) document  (this file)
environment-sample.mk |  local setup example (to be read from Makefile below)
[Makefile](https://github.com/makoto-fujiwara/check-update/blob/master/Makefile) |   for example 'make -j 24' for 16 thread machine (BSD makefile)
check-update	      | Main Script to find a new version of each package  (perl script) 
merge-check-update    | Merge by-category results into 00_Whole.html  (perl script) 
collect-stats	      | Compile table from the directory into [00_Summary.html](http://www.ki.nu/~makoto/pkgsrc/check-update/00_Summary.html)  (perl script) 

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
