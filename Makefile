.SUFFIXES: .pdf .ps .roff .txt

SRCS  = ch1.roff ch2.roff ch3.roff ch4.roff ch5.roff ch6.roff ch7.roff appnx.roff
PDF   = catb.pdf
PS    = ${PDF:.pdf=.ps}
OUT   = ${PDF:.pdf=.out}

all: ${PDF}

.ps.pdf:
	ps2pdf '-sPAPERSIZE=isob5' $< $@

.out.ps:
	dpost <$< >$@

${OUT}: mb.tmac fonts.roff title.roff index.roff ${SRCS}
	troff -mpictures mb.tmac fonts.roff title.roff index.roff ${SRCS} 2>/dev/null >${OUT}

index.roff: mb.tmac fonts.roff ${SRCS}
	troff -mpictures mb.tmac fonts.roff ${SRCS} 2>&1 >/dev/null | grep '^index:' | sed 's/index://' >index.roff

clean:
	-rm ${PDF} ${PS} ${OUT} index.roff

.PHONY: all clean
