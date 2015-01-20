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

DIRECTORY=	${HOME}/public_html/pkgsrc/check-update
DATE!=		date +%Y%m%d
WORK=		${DIRECTORY}/.${DATE}
RM=		/bin/rm

# get the last digit of the date
DAY=		${DATE:C/.*([0-9])$/\1/}

all: ${WORK}/.done


${WORK}/.done: ${CATEGORIES:S/$/.${DAY}.html/} ${WORK}
	(cd ${WORK}; \
	${MERGE} *.html )
	mv ${WORK} ${DIRECTORY}/${DATE};
	touch  ${WORK}/.done

.for i in ${CATEGORIES}
$i.${DAY}.html:
	(cd /usr/pkgsrc; \
	${CHECK_UPDATE} -u -f -m -c $i -d ${WORK} -S $i.${DAY}.html ; )
.endfor

clean:
	${RM}  ${WORK}/.done
# gmtime tm_wday

# --- /home/makoto/public_html/pkgsrc/check-update/.20150120/.done ---
# (cd /home/makoto/public_html/pkgsrc/check-update/.20150120;  /e/modena/git-repository/check-update/merge-check-update *.html )
# mv /home/makoto/public_html/pkgsrc/check-update/.20150120 /home/makoto/public_html/pkgsrc/check-update/20150120;
# touch  /home/makoto/public_html/pkgsrc/check-update/.20150120/.done
# touch: /home/makoto/public_html/pkgsrc/check-update/.20150120/.done: No such file or directory
# *** [/home/makoto/public_html/pkgsrc/check-update/.20150120/.done] Error code 1
# 
# make: stopped in /e/modena/git-repository/check-update
# 1 error
# 
# make: stopped in /e/modena/git-repository/check-update
# 8094.36s 4150.30s 5:15:12.15 64% 0+0k 94+0io 75680999pf+0w
# h87@makoto 04:43:01/150121(..git-repository/check-update)%
