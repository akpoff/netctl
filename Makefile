PREFIX ?= /usr/local

install:
	cp netctl	"$(PREFIX)/sbin/"
	cp netctl.8	"$(PREFIX)/man/man8/"
	mkdir -p /etc/hostname.d/nwids

remove:
	rm -f "$(PREFIX)/sbin/netctl"
	rm -f "$(PREFIX)/man/man8/netctl.8"

lint:
	mandoc -T lint netctl.8

man:
	mandoc netctl.8 | less
