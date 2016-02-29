INSTALL_DIR = /etc/fedora-prime

.PHONY: all install uninstall

all: install

install:
	mkdir -p $(INSTALL_DIR)
	cp ./xorg.conf.template $(INSTALL_DIR)/xorg.nvidia.conf
	cp ./xinitrc.nvidia $(INSTALL_DIR)/xinitrc.nvidia
	cp ./fedora-prime-select /usr/sbin/fedora-prime-select
	cp fedora-prime.service /usr/lib/systemd/system/fedora-prime.service
	systemctl enable fedora-prime.service

uninstall:
	systemctl disable fedora-prime.service
	rm -rf $(INSTALL_DIR)
	rm -f /usr/sbin/fedora-prime
	rm -f /usr/lib/systemd/system/fedora-prime.service
	rm -f /etc/X11/xinit/xinitrc.d/nvidia
