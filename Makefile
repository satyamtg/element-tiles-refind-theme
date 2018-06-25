#This is the Makefile for element-tiles theme by satyamtg for the rEFInd bootloader

#Configuration variables
THEMENAME=element-tiles
AUTHOR=satyamtg
THEMEVARIANT=dark
DESTDIR=output/$(THEMENAME)
MAKEEXTRAS=true
BIGICONSIZE=256
SMALLICONSIZE=96
FONTNAME=RobotoMono-Regular

#Source setup variables
ifeq ($(MAKEEXTRAS),true)
SOURCEICONS=$(wildcard theme/icons/icons_stock/*.svg) $(wildcard theme/icons/icons_extras/*.svg)
else
SOURCEICONS=$(wildcard theme/icons/icons_stock/*.svg)
endif

ifeq ($(THEMEVARIANT),dark)
SOURCEBACKGROUND=theme/backgrounds/dark.svg
SOURCESELECTIONBG=$(wildcard theme/selection_imgs/*darkbg.svg)
else ifeq ($(THEMEVARIANT),light)
SOURCEBACKGROUND=theme/backgrounds/light.svg
SOURCESELECTIONBG=$(wildcard theme/selection_imgs/*lightbg.svg)
endif

SOURCEFONTS=$(wildcard theme/fonts/*.otf) $(wildcard theme/fonts/*.ttf)

#Destination setup variables
DESTICONS=$(patsubst %.svg,$(DESTDIR)/icons/%.png,$(notdir $(SOURCEICONS)))
DESTBACKGROUND=$(patsubst %.svg,$(DESTDIR)/backgrounds/%.png,$(notdir $(SOURCEBACKGROUND)))
DESTFONTS=$(patsubst %.ttf,$(DESTDIR)/fonts/%.png,$(patsubst %.otf,$(DESTDIR)/fonts/%.png,$(notdir $(SOURCEFONTS))))
DESTSELECTIONBG=$(patsubst %.svg,$(DESTDIR)/selection/%.png,$(notdir $(SOURCESELECTIONBG)))

#Recipie
.SECONDEXPANSION:

all: envsetup $(DESTICONS) $(DESTSELECTIONBG) $(DESTBACKGROUND) $(DESTFONTS)
	cp theme/configuration/theme.conf $(DESTDIR)
	sed -i 's://THEME//:$(THEMENAME):g' $(DESTDIR)/theme.conf
	sed -i 's://AUTHOR//:$(AUTHOR):g' $(DESTDIR)/theme.conf
	sed -i 's://ICONS//:$(THEMENAME)/icons:g' $(DESTDIR)/theme.conf
	sed -i 's://BIGICONSIZE//:$(BIGICONSIZE):g' $(DESTDIR)/theme.conf
	sed -i 's://SMALLICONSIZE//:$(SMALLICONSIZE):g' $(DESTDIR)/theme.conf
	sed -i 's://BACKGROUND//:$(THEMENAME)/backgrounds/$(THEMEVARIANT).png:g' $(DESTDIR)/theme.conf
	sed -i 's://SELECTIONBIG//:$(THEMENAME)/selection/selection_big_$(THEMEVARIANT)bg.png:g' $(DESTDIR)/theme.conf
	sed -i 's://SELECTIONSMALL//:$(THEMENAME)/selection/selection_small_$(THEMEVARIANT)bg.png:g' $(DESTDIR)/theme.conf
	sed -i 's://FONT//:$(THEMENAME)/fonts/$(FONTNAME).png:g' $(DESTDIR)/theme.conf
	cp LICENSE $(DESTDIR)
	@echo $(THEMENAME) successfully made.

envsetup:
	mkdir -p $(DESTDIR)/icons
	mkdir $(DESTDIR)/backgrounds
	mkdir $(DESTDIR)/fonts
	mkdir $(DESTDIR)/selection

#Make DESTICONS
$(filter $(DESTDIR)/icons/os_%.png $(DESTDIR)/icons/boot_%.png,$(DESTICONS)): $$(filter %$$(basename $$(notdir $$@)).svg,$$(SOURCEICONS))
	scripts/mkpng "$@" "$^" $(BIGICONSIZE)
	
$(filter $(DESTDIR)/icons/tool_%.png $(DESTDIR)/icons/arrow_%.png $(DESTDIR)/icons/func_%.png,$(DESTICONS)): $$(filter %$$(basename $$(notdir $$@)).svg,$$(SOURCEICONS))
	scripts/mkpng "$@" "$^" $(SMALLICONSIZE)

$(filter $(DESTDIR)/icons/vol_%.png,$(DESTICONS)): $$(filter %$$(basename $$(notdir $$@)).svg,$$(SOURCEICONS))
	scripts/mkpng "$@" "$^" $(shell echo $(BIGICONSIZE)/4 | bc)

#Make DESTFONTS
$(DESTFONTS): $$(filter %$$(basename $$(notdir $$@)).otf %$$(basename $$(notdir $$@)).ttf,$$(SOURCEFONTS))
	scripts/mkfont "$<" 14 -3 "$@"

#Make DESTBACKGROUND
$(DESTBACKGROUND): $(SOURCEBACKGROUND)
	scripts/mkpng "$@" "$^" 100

#MAKE DESTSELECTIONBG
$(DESTDIR)/selection/selection_big%.png: theme/selection_imgs/selection_big%.svg
	scripts/mkpng "$@" "$^" $(shell echo 9*$(BIGICONSIZE)/8 | bc)

$(DESTDIR)/selection/selection_small%.png: theme/selection_imgs/selection_small%.svg
	scripts/mkpng "$@" "$^" $(shell echo 3*$(SMALLICONSIZE)/4 | bc)

clean:
	rm -rf $(DESTDIR)
