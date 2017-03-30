#!/bin/sh
CVSROOT=:pserver:anoncvs@anoncvs.jp.netbsd.org:/cvs/cvsroot
CVSROOT=:pserver:anoncvs@anoncvs.netbsd.org:/cvsroot

# dedicated pkgsrc directory for this purpose
TMP=/tmp
TMP_PKGSRC=${TMP}/pkgsrc

WIPROOT=:pserver:anoncvs@pkgsrc-wip.cvs.sourceforge.net:/cvs/pkgsrc-wip/cvsroot
SITE_PATCH=${HOME}/public_html/pkgsrc/mk/fetch-sites.mk.diff
# ---------------------------
# sysctl -w kern.maxproc=2088
# unlimit
JOBS=36

# Check if required packages installed
FAIL=0
echo ' *** (1) Checking packages required'
for p in httping curl git-base p5-Net-DNS p5-Algorithm-Diff mozilla-rootcerts w3m; do
   NOT_EXIST=0
   pkg_info -q -c $p  > /dev/null 2>&1
   RC=$?
   if [ $RC = 1 ] ; then
      echo ' *** Package' $p 'is required.'
      FAIL=1
   fi
   done;

if [ $FAIL = 1 ] ; then exit; fi

if [ -d .git ] ; then
echo ' *** (2) Updating from git repository'

git pull
git checkout release
HASH=`git log --format="%H" -1`
export HASH
fi

echo ' *** (3) Updating from cvs repository'
if [ ! -d ${TMP_PKGSRC} ] ; then
  (cd ${TMP};           time -c cvs -Q -d ${CVSROOT} co pkgsrc )
else
  (cd ${TMP_PKGSRC};    time -c cvs -Q update -dPA . )
fi

if [ -f ${SITE_PATCH} 
echo ' *** (4) Applying mk/fetch/sites.mk patch'
(cd ${TMP_PKGSRC} ; patch -s -N -p0 < ${SITE_PATCH} )
fi

echo ' *** (5) copy environment-sample.mk if environment.mk not found '

if [ ! -f environment.mk ]; then cp environment-sample.mk environment.mk ; fi

echo ' *** (6) Now real make '

env PKGSRC=${TMP_PKGSRC} make -j ${JOBS}
