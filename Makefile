VERSION:=$(shell cat VERSION)
PLUGIN_NAME:=myplugin

HEEDY:=$(shell test -f ./heedy && echo "./")heedy

.PHONY: clean clear watch debug release run


release: node_modules clear dist/myplugin
	npm run build
	# Remove original files of pre-compressed content
	if test -d ./dist/myplugin/public/static; then find ./dist/myplugin/public/static -name "*.gz" -exec sh -c 'rm "$${0%.gz}"' {} ';';fi
	# Zip the plugin
	cd dist;zip -r heedy-myplugin-plugin-${VERSION}.zip ./myplugin

node_modules:
	if test -d frontend; then (cd frontend && npm i);fi
	npm i

dist/myplugin:
	mkdir -p dist/myplugin

testdb: | dist/myplugin/heedy.conf
	$(HEEDY) create testdb --noserver --username=test --password=test --plugin=ln-s:$(CURDIR)/dist/myplugin

debug: node_modules dist/myplugin
	npm run debug

watch: node_modules dist/myplugin
	npm run watch

dist/myplugin/heedy.conf:
	make debug

run: testdb
	$(HEEDY) run testdb --verbose --development

clear:
	rm -rf dist

clean: clear
	rm -rf testdb
	if test -d node_modules; then rm -rf node_modules; fi
	if test -d frontend/node_modules; then rm -rf frontend/node_modules; fi

rename: clean
	find ./ -type f -exec sed -i -e 's/myplugin/$(PLUGIN_NAME)/g' {} \;