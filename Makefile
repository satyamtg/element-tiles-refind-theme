#This is the Makefile for element-tiles theme for the rEFInd bootloader

#Variables
ICONS=theme/icons/*.svg
BACKGROUND=theme/backgrounds/dark.svg
DESTDIR=output

#Recipie
clean:
	rm -f $(DESTDIR)
