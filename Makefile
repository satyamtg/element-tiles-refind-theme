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
SOURCESELECTIONBG=$(wildcard theme/selection_imgs/*darkbg.svg)
else ifeq ($(THEMEVARIANT),light)
SOURCEBACKGROUND=theme/backgrounds/light.svg
SOURCESELECTIONBG=$(wildcard theme/selection_imgs/*lightbg.svg)
endif

SOURCEFONTS=$(wildcard theme/fonts/*.otf) $(wildcard theme/fonts/*.ttf)

#Destination setup variables
DESTICONS=$(patsubst %.svg,$(DESTDIR)/icons/%.png,$(notdir $(SOURCEICONS)))
DESTBACKGROUND=$(patsubst %.svg,$(DESTDIR)/backgrounds/%.png,$(notdir $(SOURCEBACKGROUND)))
DESTFONTS=$(patsubst %.ttf,$(DESTDIR)/fonts/%.png,$(notdir $(SOURCEFONTS))) $(patsubst %.otf,$(DESTDIR)/fonts/%.png,$(notdir $(SOURCEFONTS)))
DESTSELECTIONBG=$(patsubst %.svg,$(DESTDIR)/selection/%.png,$(notdir $(SOURCESELECTIONBG)))

#Recipie
.SECONDEXPANSION:

all: envsetup $(DESTICONS) $(DESTSELECTIONBG) $(DESTBACKGROUND) $(DESTFONTS)

envsetup:
	mkdir -p $(DESTDIR)/icons
	mkdir $(DESTDIR)/backgrounds
	mkdir $(DESTDIR)/fonts
	mkdir $(DESTDIR)/selection

#Make DESTICONS
$(filter $(DESTDIR)/icons/os_%.png $(DESTDIR)/icons/boot_%.png,$(DESTICONS)): $$(filter %$$(basename $$(notdir $$@)).svg,$$(SOURCEICONS))
	scripts/mkpng "$@" "$^" 256
	
$(filter $(DESTDIR)/icons/tool_%.png $(DESTDIR)/icons/arrow_%.png $(DESTDIR)/icons/func_%.png,$(DESTICONS)): $$(filter %$$(basename $$(notdir $$@)).svg,$$(SOURCEICONS))
	scripts/mkpng "$@" "$^" 96

$(filter $(DESTDIR)/icons/vol_%.png,$(DESTICONS)): $$(filter %$$(basename $$(notdir $$@)).svg,$$(SOURCEICONS))
	scripts/mkpng "$@" "$^" 64

#Make DESTFONTS
$(DESTFONTS): $$(filter %$$(basename $$(notdir $$@)).otf %$$(basename $$(notdir $$@)).ttf,$$(SOURCEFONTS))
	@if [ "$(suffix $<)" = ".ttf" ]; then\
		scripts/mkotf $< $(patsubst %.ttf,%.otf,$<);\
		scripts/mkfont "$(patsubst %.ttf,%.otf,$<)" 14 -3 "$@";\
	else\
		scripts/mkfont "$<" 14 -3 "$@";\
	fi

#Make DESTBACKGROUND
$(DESTBACKGROUND): $(SOURCEBACKGROUND)
	scripts/mkpng "$@" "$^" 256

#MAKE DESTSELECTIONBG
$(DESTDIR)/selection/selection_big%.png: theme/selection_imgs/selection_big%.svg
	scripts/mkpng "$@" "$^" 256

$(DESTDIR)/selection/selection_small%.png: theme/selection_imgs/selection_small%.svg
	scripts/mkpng "$@" "$^" 256

clean:
	rm -rf $(DESTDIR)
