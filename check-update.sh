#!/bin/sh
CVSROOT=:pserver:anoncvs@anoncvs.jp.netbsd.org:/cvs/cvsroot
WIPROOT=:pserver:anoncvs@pkgsrc-wip.cvs.sourceforge.net:/cvs/pkgsrc-wip/cvsroot
SITE_PATCH=${HOME}/public_html/pkgsrc/mk/fetch-sites.mk.diff-6
JOBS=24
JOBS=12

FAIL=0
for p in httping curl git-base ; do
   NOT_EXIST=0
   pkg_info -q -c $p  > /dev/null 2>&1
   RC=$?
#   echo 'RC = ' $RC
   if [ $RC = 1 ] ; then
      echo ' *** Package' $p 'is required.'
      FAIL=1
   fi
   done;

if [ $FAIL = 1 ] ; then exit; fi

git pull

if [ ! -d /tmp/pkgsrc ] ; then
  (cd /tmp ;        time -c cvs -Q -d ${CVSROOT} co pkgsrc )
else
  (cd /tmp/pkgsrc;        time -c cvs -Q update -dPA . )
fi

(cd /tmp/pkgsrc ; patch -s -p0 < ${SITE_PATCH} )

if [ ! -f environment.mk ]; then cp environment-sample.mk environment.mk ; fi
env PKGSRC=/tmp/pkgsrc make -j ${JOBS}
