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
	devel \
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

CHECK_UPDATE=	/export/git-repository/check-update/check-update
CHECK_UPDATE=	/e/modena/git-repository/check-update/check-update
MERGE=		/e/modena/git-repository/check-update/merge-check-update

DIRECTORY=${HOME}/public_html/pkgsrc/check-update
DATE!=date +%Y%m%d
WORK=${DIRECTORY}/.${DATE}

# get the last digit of the date
DAY=${DATE:C/.*([0-9])$/\1/}

all: ${WORK}/.done


${WORK}/.done: ${CATEGORIES:S/$/.${DAY}.html/} ${WORK}
	(cd ${WORK}; \
	echo '  ****  ' ${MERGE} *.html )

.for i in ${CATEGORIES}
$i.${DAY}.html:
	(cd /usr/pkgsrc; \
	echo	${CHECK_UPDATE} -u -f -m -c $i -d ${WORK} -S $i.${DAY}.html -h ; )
.endfor

# gmtime tm_wday
