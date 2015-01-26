CATEGORIES= \
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
	net \
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
	www \
	x11 \

DEVEL = devel1 devel2 devel3

CHECK_UPDATE=	/e/modena/git-repository/check-update/check-update
MERGE=		/e/modena/git-repository/check-update/merge-check-update
SUMMARY=	/e/modena/git-repository/check-update/collect-stats

DIRECTORY=	${HOME}/public_html/pkgsrc/check-update
DATE_H!=	env TZ=UTC date +%Y%m%d-%H
# To allow 'env DATE=20150101-12 make -j 16' for executing beyond date boundary
# and Please note  that DATE= is necessay almost always

DATE?=		${DATE_H}
WORK=		${DIRECTORY}/.${DATE}
RM=		/bin/rm

all: ${DIRECTORY}/${DATE}
	(cd ${DIRECTORY}; ${SUMMARY} );

${DIRECTORY}/${DATE}: ${WORK}/.done
	mv ${WORK} ${DIRECTORY}/${DATE};

# Merge the results
${WORK}/.done: ${CATEGORIES:S/$/.html/} ${DEVEL:S/$/.html/}
	(cd ${WORK}; \
	${MERGE} *.html )
	touch ${WORK}/.done

# check-update by-category, output directory is ${WORK}
.for i in ${CATEGORIES}
$i.html: ${WORK}
	(cd /usr/pkgsrc; \
	${CHECK_UPDATE} -f -m -c $i -d ${WORK} -S $i.html ; )
.endfor

# devel category special
.for y in 1 2 3 
devel$y.html: ${WORK}
	(cd /usr/pkgsrc; \
	${CHECK_UPDATE} -f -m -c devel -y $y -d ${WORK} -S ${.TARGET} ; )
.endfor

${WORK}:
	(if ! [ -d ${WORK} ]; then\
	mkdir ${WORK} ;\
	fi)

clean:
	${RM}  ${WORK}/.done
