sizes = 16 24 32 48 64 72 96 128 256 512 1024
icons = \
  $(foreach size,$(sizes),png/nixos-cn-$(size)x$(size).png) \
  svg/nixos-cn.svg

.PHONY: all install clean

all: $(icons)
clean:
	rm -f $(icons)
install: $(foreach icon,$(icons),$(DESTDIR)/$(icon))

png/nixos-cn-%.png: ../logo/nixos-cn.svg
	@mkdir -p $(@D)
	convert -background none -resize $* $< $@

svg/nixos-cn.svg: ../logo/nixos-cn.svg
	@mkdir -p $(@D)
	cp $< $@

$(DESTDIR)/%: %
	install -D -m 644 $< $@
