#This is the Makefile for element-tiles theme by satyamtg for the rEFInd bootloader

#Configuration variables
THEMENAME=element-tiles
THEMEVARIANT=dark
DESTDIR=output/$(THEMENAME)

#Source setup variables
SOURCEICONS=$(wildcard theme/icons/icons_stock/*.svg)
SOURCEBACKGROUND=theme/backgrounds/dark.svg
SOURCEFONTS=theme/fonts/testfont.otf
SOURCESELECTIONBG=

#Destination setup variables
DESTICONS=$(patsubst %.svg,$(DESTDIR)/icons/%.png,$(notdir $(SOURCEICONS)))
DESTBACKGROUND=$(patsubst %.svg,$(DESTDIR)/backgrounds/%.png,$(notdir $(SOURCEBACKGROUND)))
DESTFONTS=$(patsubst %.svg,$(DESTDIR)/fonts/%.png,$(notdir $(SOURCEFONTS)))
DESTSELECTIONBG=$(patsubst %.svg,$(DESTDIR)/selection/%.png,$(notdir $(SOURCESELECTIONBG)))

#Recipie
.SECONDEXPANSION:

all: envsetup $(DESTICONS)

envsetup:
	mkdir -p $(DESTDIR)/icons
	mkdir $(DESTDIR)/backgrounds
	mkdir $(DESTDIR)/fonts
	mkdir $(DESTDIR)/selection

$(filter $(DESTDIR)/icons/os_%.png,$(DESTICONS)): $$(filter %$$(basename $$(notdir $$@)).svg,$$(SOURCEICONS))
	scripts/mkpng.sh "$@" "$^" 128
	
clean:
	rm -rf $(DESTDIR)
