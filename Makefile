#This is the Makefile for element-tiles theme for the rEFInd bootloader

#Variables
ICONS=theme/icons/*.svg
BACKGROUND=theme/backgrounds/dark.svg
FONTS=theme/fonts/testfont.otf
DESTDIR=output

#Recipie
all: $(ICONS) $(BACKGROUNDS) $(FONTS)
	
clean:
	rm -f $(DESTDIR)
