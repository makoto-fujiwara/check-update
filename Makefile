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
CHECK_UPDATE=	/e/modena/git-repository/check-update/check-update-20150123
MERGE=		/e/modena/git-repository/check-update/merge-check-update

DIRECTORY=	${HOME}/public_html/pkgsrc/check-update
DATE_H!=	date +%Y%m%d-%H
# To allow 'env DATE=20150101 make -j 16' for executing beyond date boundary
DATE?=		${DATE_H}
WORK=		${DIRECTORY}/.${DATE}
RM=		/bin/rm

${DIRECTORY}/${DATE}: ${WORK}/.done
	mv ${WORK} ${DIRECTORY}/${DATE};

# Merge the results
${WORK}/.done: ${CATEGORIES:S/$/.html/}
	(cd ${WORK}; \
	${MERGE} *.html )
	touch ${WORK}/.done

# check-update by-category, output directory is ${WORK}
.for i in ${CATEGORIES}
$i.html: ${WORK}
	(cd /usr/pkgsrc; \
	${CHECK_UPDATE} -u -f -m -c $i -d ${WORK} -S $i.html ; )
.endfor

${WORK}:
	(if ! [-d ${WORK}]; then\
	mkdir ${WORK} ;\
	fi)

clean:
	${RM}  ${WORK}/.done
# gmtime tm_wday
#
#
#
#h87ming /home/makoto/public_html/pkgsrc/check-update/.20150123-11/.devel.html to /home/makoto/public_html/pkgsrc/check-update/.20150123-11/devel.html                                          
#--- /home/makoto/public_html/pkgsrc/check-update/.20150123-11/.done ---
#(cd /home/makoto/public_html/pkgsrc/check-update/.20150123-11;  /e/modena/git-repository/check-update/merge-check-update *.html )
#touch /home/makoto/public_html/pkgsrc/check-update/.20150123-11/.done
#--- /home/makoto/public_html/pkgsrc/check-update/20150123-11 ---html
#mv /home/makoto/public_html/pkgsrc/check-update/.20150123-11 /home/makoto/public_html/pkgsrc/check-update/20150123-11;
#9981.82s 4255.56s 7:26:36.19 53% 0+0k 3+0io 74437813pf+0w.done.html
#h87@makoto 18:43:44/150123(..git-repository/check-update)% lslt  ~/pu
#
#
#@makoto 18:56:46/150123(..git-repository/check-update)% find  ~/public_html/pkgsrc/check-update/ -cmin -30 -ls                                                                               
#66149495     16 drwxr-xr-x   12 makoto            wheel                  7680 Jan 23 18:35 /home/makoto/public_html/pkgsrc/check-update/
#66151145      8 drwxr-xr-x    2 makoto            wheel                   512 Jan 23 18:35 /home/makoto/public_html/pkgsrc/check-update/.20150123
#66151224   5568 -rw-r--r--    1 makoto            wheel               2808478 Jan 23 18:35 /home/makoto/public_html/pkgsrc/check-update/.20150123/00_whole.html
#66151261      8 -rw-r--r--    1 makoto            wheel                  2177 Jan 23 18:35 /home/makoto/public_html/pkgsrc/check-update/.20150123/00_Stats.html
#66151256      8 drwxr-xr-x    2 makoto            wheel                  1024 Jan 23 18:35 /home/makoto/public_html/pkgsrc/check-update/20150123-11
#66151289    896 -rw-r--r--    1 makoto            wheel                403249 Jan 23 18:35 /home/makoto/public_html/pkgsrc/check-update/20150123-11/devel.html
#66151271      0 -rw-r--r--    1 makoto            wheel                     0 Jan 23 18:35 /home/makoto/public_html/pkgsrc/check-update/20150123-11/.done
#h87@makoto 18:56:52/150123(..git-repository/check-update)%                                                                                                                                      
#[0] 0:tcsh  1:zsh- 2:tcsh*                                     
#
