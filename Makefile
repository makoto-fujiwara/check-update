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
	regress \
	security \
	shells \
	sysutils \
	textproc \
	time \
	wm \
	www \
	x11 \

CHECK_UPDATE= /export/git-repository/check-update/check-update

SAMPLES= xterm kterm

all: ${CATEGORIES:S/$/.html/}
#all: ${SAMPLES}

.for i in ${CATEGORIES}
$i.html:
	(cd /usr/pkgsrc; \
	${CHECK_UPDATE} -u -f -m -c $i  -S $i.9.html;)
.endfor
