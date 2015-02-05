.include "environment.mk"

# the order is important if you make -j 24 etc to speed up
CATEGORIES?= \
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
	sysutils \
	textproc \
	time \
	wm \

DEVEL?= devel1 devel2 devel3

PKGSRC?=	/usr/pkgsrc

CHECK_UPDATE?=	/export/git-work/check-update/check-update
MERGE?=		/export/git-work/check-update/merge-check-update
COLLECT_STATS?=	/export/git-work/check-update/collect-stats

DIRECTORY?=	${HOME}/public_html/pkgsrc/check-update

DATE_H!=	env TZ=UTC date +%Y%m%d-%H
# To allow 'env DATE=20150101-12 make -j 16' for executing beyond date boundary
# and Please note  that DATE= is necessay almost always

DATE?=		${DATE_H}
WORK=		${DIRECTORY}/.${DATE}
RM=		/bin/rm

all: ${DIRECTORY}/${DATE}
	(cd ${DIRECTORY}; ${COLLECT_STATS} );

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
