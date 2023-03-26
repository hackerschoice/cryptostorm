VER := 1.2

FILES += "cryptostorm-$(VER)/Makefile"
FILES += "cryptostorm-$(VER)/setup.sh"
FILES += "cryptostorm-$(VER)/Dockerfile"
FILES += "cryptostorm-$(VER)/fs-root/getkey.sh"
FILES += "cryptostorm-$(VER)/fs-root/check_vpn.sh"
FILES += "cryptostorm-$(VER)/fs-root/etc/cont-init.d"
FILES += "cryptostorm-$(VER)/fs-root/etc/services.d/wireguard"

TARX = $(shell command -v gtar 2>/dev/null)
ifndef TARX
	TARX := tar
endif

all: Dockerfile
	docker build -t hackerschoice/cryptostorm .

dist:
	rm -f cryptostorm-$(VER) 2>/dev/null
	ln -sf . cryptostorm-$(VER)
	$(TARX) cfz cryptostorm-$(VER).tar.gz --owner=0 --group=0 $(FILES)
	rm -f cryptostorm-$(VER)
	ls -al cryptostorm-$(VER).tar.gz

push: Dockerfile
	docker buildx build \
	--push \
	--platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag hackerschoice/cryptostorm .

