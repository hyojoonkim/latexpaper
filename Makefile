REPORT=paper
LATEX=latex
BIBTEX=bibtex --min-crossrefs=100
REF1=ref
REF2=rfc

TEX = $(wildcard *.tex)
SRCS = $(TEX)
REFS=$(REF1).bib

all: pdf

############################################################

spell:
	make clean
	for i in *.tex; do ispell $$i; done


$(REPORT).dvi: $(SRCS) #$(REFS)
	$(LATEX) $(REPORT)
	$(BIBTEX) $(REPORT)
	#%perl -pi -e "s/%\s+//" $(REPORT).bbl
	$(LATEX) $(REPORT)
	$(LATEX) $(REPORT)
#	ps2pdf14 -dPDFSETTINGS=/prepress -dSubsetFonts=true -dEmbedAllFonts=true $<
#	ps2pdf $< $(REPORT).pdf


$(REPORT).ps: $(REPORT).dvi
	dvips -t letter -G0 -P cmz $(REPORT).dvi -o $(REPORT).ps


view: pdf
	xdvi $(REPORT).pdf

pdf: $(REPORT).ps
	ps2pdf14 -dPDFSETTINGS=/prepress -dSubsetFonts=true -dEmbedAllFonts=true $<

printer: $(REPORT).ps
	lpr $(REPORT).ps

tidy:
	rm -f *.dvi *.aux *.log *.blg *.bbl

clean:
	rm -f *~ *.dvi *.aux *.log *.blg *.bbl $(REPORT).ps $(REPORT).pdf 

web:
	cp $(REPORT).pdf /var/www/tmp
