INSTALL_DIR = /etc/fedora-prime

.PHONY: all install uninstall

all: install

install:
	mkdir -p $(INSTALL_DIR)
	cp ./xorg.conf $(INSTALL_DIR)/xorg.conf
	cp ./xinitrc.nvidia $(INSTALL_DIR)/xinitrc.nvidia
	cp ./fedora-prime /usr/sbin/fedora-prime
	cp fedora-prime.service /usr/lib/systemd/system/fedora-prime.service
	systemctl enable fedora-prime.service

uninstall:
	systemctl disable fedora-prime.service
	rm -rf $(INSTALL_DIR)
	rm -f /usr/sbin/fedora-prime
	rm -f /usr/lib/systemd/system/fedora-prime.service
