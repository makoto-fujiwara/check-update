# check-update

Tool for [pkgsrc](http://www.netbsd.org/docs/software/packages.html)
tree. Reading [whole tree](http://cvsweb.netbsd.org/bsdweb.cgi/pkgsrc/)
and generates the list of To-Be-Updated packges.

To try

	cd /usr/pkgsrc/wip/check-update;
	make package-install;
	cd /usr/pkgsrc/CATEGORY/PACKAGE;
	check-update

Or
	git clone https://github.com/makoto-fujiwara/check-update
	./check-update -h
	./check-update -H

For current statistics, see either

- [HEAD] (http://www.ki.nu/~makoto/pkgsrc/check-update/HEAD/00_Summary.html) (not active)
- [release] (http://www.ki.nu/~makoto/pkgsrc/check-update/00_Summary.html)

Presentation 
- (http://www.ki.nu/~makoto/mef/20170310/)
at NetBSD BoF (AsiaBSDCon 2017 at Tokyo, opera@IIJ)

- (http://www.ki.nu/~makoto/mef/20150313/)
at NetBSD BoF (AsiaBSDCon 2015 at Tokyo)

- (http://www.ki.nu/~makoto/mef/20150711/)
at NetBSD BoF (JNUG 17th Annual Meeting 2015 at Tokyo)

## Files

File name  |.| Description
---------- |-| -------------
README.md	      | |  [Markdown](https://help.github.com/articles/markdown-basics/) document  (this file)
[environment-sample.mk](environment-sample.mk) | | local setup example for environment.mk (to be read from Makefile below)
[check-update-sample.sh](check-update-sample.sh)|0 | Shell script to drive whole thing, intending to be crontab driven. Rename it to check-update.sh
[Makefile](Makefile)		         | 1 |  for example,  'make -j 24' for 16 thread machine (BSD makefile)
[check-update](check-update)             | 2 |  Main Script to find a new version of each package  (perl script)
[merge-check-update](merge-check-update) | 3 |  Merge by-category results into 00_whole.html  (perl script)
[summary-diff](summary-diff)             | 4 |  Generate diff to previous run (perl script)
[collect-stats](collect-stats)	         | 5 |  Compile table from the directory into [00_Summary.html](http://www.ki.nu/~makoto/pkgsrc/check-update/00_Summary.html)  (perl script)
[fork-w3m](fork-w3m)                     | | misc perl script to be called from check-update
[status2gnuplot](status2gnuplot)	 | | misc perl script to generate graphical statistics
### Prerequisite
  - lang/perl5
  - net/p5-Net-DNS
  - net/curl
  - devel/p5-Algorithm-Diff (for summary-diff)
  - lang/ruby
  - rubygems (only if ruby is old one, modern ruby already has 'gem')
  - security/mozilla-rootcerts OR security/p5-Mozilla-CA
  - www/w3m
  
### Setup
  - copy environment-sample.mk to environment.mk

### First trial
  - 

### Tuning
  - /usr/pkgsrc on tmpfs

### Debugging
  - See -x options


## check-update
### help
>  check-update -h

will tell you the other options.

### Single mode

> cd /usr/pkgsrc/category/package; /PATH/TO/check-update

### Category mode

> /PATH/TO/check-update -c category

### Whole tree

> /PATH/TO/check-update

(cvs update prior to run)

> /PATH/TO/check-update -u

is the most typical usage. Reading /usr/pkgsrc and by category
it will 'cvs update', and generates the report as

>  ~/public_html/pkgsrc/check-update/yyyy-dd-mm.html

(eval `ssh-agent`; ssh-add ) may be helpful to get
cvs udpate done smoothly).

But it will take several tens of hours.
Instead, make -j 12 may be good to finish in several hours
(make is assumed to be BSD make).

>  check-update -x d -c category -P packagename

is the way to debug particular package.

### Crontab setup
(T B written)
