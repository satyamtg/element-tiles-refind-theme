#This is the Makefile for element-tiles theme by satyamtg for the rEFInd bootloader

#Configuration variables
THEMENAME=element-tiles
THEMEVARIANT=dark
DESTDIR=output/$(THEMENAME)
MAKEEXTRAS=true

#Source setup variables
ifeq ($(MAKEEXTRAS),true)
SOURCEICONS=$(wildcard theme/icons/icons_stock/*.svg) $(wildcard theme/icons/icons_extras/*.svg)
else
SOURCEICONS=$(wildcard theme/icons/icons_stock/*.svg)
endif

ifeq ($(THEMEVARIANT),dark)
SOURCEBACKGROUND=theme/backgrounds/dark.svg
SOURCESELECTIONBG=$(wildcard theme/selection_imgs/*lightbg.svg)
else ifeq ($(THEMEVARIANT),light)
SOURCEBACKGROUND=theme/backgrounds/light.svg
SOURCESELECTIONBG=$(wildcard theme/selection_imgs/*lightbg.svg)
endif

SOURCEFONTS=theme/fonts/testfont.otf

#Destination setup variables
DESTICONS=$(patsubst %.svg,$(DESTDIR)/icons/%.png,$(notdir $(SOURCEICONS)))
DESTBACKGROUND=$(patsubst %.svg,$(DESTDIR)/backgrounds/%.png,$(notdir $(SOURCEBACKGROUND)))
DESTFONTS=$(patsubst %.svg,$(DESTDIR)/fonts/%.png,$(notdir $(SOURCEFONTS)))
DESTSELECTIONBG=$(patsubst %.svg,$(DESTDIR)/selection/%.png,$(notdir $(SOURCESELECTIONBG)))

#Recipie
.SECONDEXPANSION:

all: envsetup $(DESTICONS) $(DESTSELECTIONBG)

envsetup:
	mkdir -p $(DESTDIR)/icons
	mkdir $(DESTDIR)/backgrounds
	mkdir $(DESTDIR)/fonts
	mkdir $(DESTDIR)/selection

#Make DESTICONS
$(filter $(DESTDIR)/icons/os_%.png $(DESTDIR)/icons/boot_%.png,$(DESTICONS)): $$(filter %$$(basename $$(notdir $$@)).svg,$$(SOURCEICONS))
	scripts/mkpng.sh "$@" "$^" 256
	
$(filter $(DESTDIR)/icons/tool_%.png $(DESTDIR)/icons/arrow_%.png $(DESTDIR)/icons/func_%.png,$(DESTICONS)): $$(filter %$$(basename $$(notdir $$@)).svg,$$(SOURCEICONS))
	scripts/mkpng.sh "$@" "$^" 96

$(filter $(DESTDIR)/icons/vol_%.png,$(DESTICONS)): $$(filter %$$(basename $$(notdir $$@)).svg,$$(SOURCEICONS))
	scripts/mkpng.sh "$@" "$^" 64

#Make DESTFONTS
#Make DESTBACKGROUND



#MAKE DESTSELECTIONBG
$(DESTDIR)/selection/selection_big%.png: theme/selection_imgs/selection_big%.svg
	scripts/mkpng.sh "$@" "$^" 256

$(DESTDIR)/selection/selection_small%.png: theme/selection_imgs/selection_small%.svg
	scripts/mkpng.sh "$@" "$^" 256

clean:
	rm -rf $(DESTDIR)
