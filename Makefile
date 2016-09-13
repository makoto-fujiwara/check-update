.include "environment.mk"

PKGSRC?=	/usr/pkgsrc
DIRECTORY?=	${HOME}/public_html/pkgsrc/check-update/HEAD
URL?=		http://www.ki.nu/~makoto/pkgsrc/check-update/

GIT_WORK?=	/export/git-work/check-update
CHECK_UPDATE?=	${GIT_WORK}/check-update
MERGE?=		${GIT_WORK}/merge-check-update
COLLECT_STATS?=	${GIT_WORK}/collect-stats -u ${URL} -d ${DIRECTORY}
SUMMARY_DIFF?=	${GIT_WORK}/summary-diff  -u ${URL} -d ${DIRECTORY}

# the order is important if you make -j 24 etc to speed up
CATEGORIES?= \
	sysutils \
	net \
	www \
	x11 \
	archivers \
	audio \
	benchmarks \
	biology \
	cad \
	chat \
	comms \
	converters \
	cross \
	databases \
	editors \
	emulators \
	filesystems \
	finance \
	fonts \
	games \
	geography \
	graphics \
	ham \
	inputmethod \
	lang \
	mail \
	math \
	mbone \
	misc \
	multimedia \
	news \
	parallel \
	pkgtools \
	print \
	security \
	shells \
	textproc \
	time \
	wm \

DEVEL?= devel1 devel2 devel3

DATE_H!=	env TZ=UTC date +%Y%m%d-%H
# To allow 'env DATE=20150101-12 make -j 16' for executing beyond date boundary
# and Please note  that DATE= is necessay almost always

DATE?=		${DATE_H}
WORK=		${DIRECTORY}/.${DATE}
RM=		/bin/rm

all: ${DIRECTORY}/${DATE}/00_Summary.html

${DIRECTORY}/${DATE}/00_Summary.html: ${DIRECTORY}/${DATE}/diff
	cp -p ${DIRECTORY}/00_Summary.html	${DIRECTORY}/00_Summary.bak.html
	(cd ${DIRECTORY}; ${COLLECT_STATS} );

${DIRECTORY}/${DATE}/diff:  ${DIRECTORY}/${DATE}
	(cd ${DIRECTORY}; ${SUMMARY_DIFF} );

${DIRECTORY}/${DATE}: ${WORK}/.done
	mv ${WORK} ${DIRECTORY}/${DATE};

# Merge the results (slower to start ealiear)
${WORK}/.done: ${DEVEL:S/$/.html/} ${CATEGORIES:S/$/.html/} 
	(cd ${WORK}; \
	${MERGE} *.html )
	touch ${WORK}/.done

# devel category special
.for y in 1 2 3 
devel$y.html: ${WORK}
	${CHECK_UPDATE} -f -m -p ${PKGSRC} -c devel -y $y -d ${WORK} -S ${.TARGET}
.endfor

# check-update by-category, output directory is ${WORK}
.for i in ${CATEGORIES}
$i.html: ${WORK}
	${CHECK_UPDATE} -f -m -p ${PKGSRC} -c $i -d ${WORK} -S $i.html;
.endfor

${WORK}:
	(if ! [ -d ${WORK} ]; then\
	mkdir ${WORK} ;\
	fi)

clean:
	${RM}  ${WORK}/.done
