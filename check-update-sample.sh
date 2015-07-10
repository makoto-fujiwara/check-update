#!/bin/sh
CVSROOT=:pserver:anoncvs@anoncvs.jp.netbsd.org:/cvs/cvsroot
WIPROOT=:pserver:anoncvs@pkgsrc-wip.cvs.sourceforge.net:/cvs/pkgsrc-wip/cvsroot
SITE_PATCH=${HOME}/public_html/pkgsrc/mk/fetch-sites.mk.diff
# ---------------------------
# sysctl -w kern.maxproc=2088
# unlimit
JOBS=36

# Check if required packages installed
FAIL=0
echo ' *** (1) Checking packages required'
for p in httping curl git-base p5-Net-DNS p5-Algorithm-Diff mozilla-rootcerts; do
   NOT_EXIST=0
   pkg_info -q -c $p  > /dev/null 2>&1
   RC=$?
   if [ $RC = 1 ] ; then
      echo ' *** Package' $p 'is required.'
      FAIL=1
   fi
   done;

if [ $FAIL = 1 ] ; then exit; fi

echo ' *** (2) Updating from git repository'

git pull

echo ' *** (3) Updating from cvs repository'
if [ ! -d /tmp/pkgsrc ] ; then
  (cd /tmp ;        time -c cvs -Q -d ${CVSROOT} co pkgsrc )
else
  (cd /tmp/pkgsrc;        time -c cvs -Q update -dPA . )
fi

echo ' *** (4) Applying mk/fetch/sites.mk patch'

(cd /tmp/pkgsrc ; patch -s -N -p0 < ${SITE_PATCH} )

echo ' *** (5) Applying mk/fetch/sites.mk patch'

if [ ! -f environment.mk ]; then cp environment-sample.mk environment.mk ; fi

echo ' *** (6) Now real make '

env PKGSRC=/tmp/pkgsrc make -j ${JOBS}
