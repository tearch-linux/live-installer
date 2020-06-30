DESTDIR=/

all: clean build

build: buildmo
	mkdir -p build/usr/lib/ || true
	cp -prfv live-installer build/usr/lib/
	#set parmissions
	chmod 755 -R build
	chown root -R build

buildmo:
	mkdir -p build/usr/share/ || true
	@echo "Building the mo files"
	# WARNING: the second sed below will only works correctly with the languages that don't contain "-"
	for file in `ls po/*.po`; do \
		lang=`echo $$file | sed 's@po/@@' | sed 's/\.po//' | sed 's/live-installer-//'`; \
		install -d build/usr/share/live-installer/locale/$$lang/LC_MESSAGES/; \
		msgfmt -o build/usr/share/live-installer/locale/$$lang/LC_MESSAGES/live-installer.mo $$file; \
	done \

install:
	cp -prfv build/* $(DESTDIR)/
uninstall:
	rm -rf $(DESTDIR)/usr/lib/live-installer
clean:
	rm -rf build
