#This is the Makefile for element-tiles theme for the rEFInd bootloader

#Configuration variables
THEMENAME=element-tiles
THEMEVARIANT=dark
DESTDIR=output/$(THEMENAME)

#Source setup variables
SOURCEICONS=$(wildcard theme/icons/*.svg)
SOURCEBACKGROUND=theme/backgrounds/dark.svg
SOURCEFONT=theme/fonts/testfont.otf

#Destination setup variables
DESTICONS=$(pathsubst ,$(DESTDIR)/icons/%.png,)


#Recipie
all: $(DESTICONS) $(DESTBACKGROUND) $(DESTFONT) $(DESTSELECTION)
	
clean:
	rm -rf $(DESTDIR)
