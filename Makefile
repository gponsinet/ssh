all: config reveal

.PHONY: config
config:
	chmod 400 $@

.git/config:
	git config --local core.hooksPath .githooks

.PHONY: hide
hide: .git/config
	git secret hide
	git add $$(git secret list | sed 's/\(.*\)/\1.secret/g')

.PHONY: reveal
reveal: .git/config
	rm -f $$(git secret list)
	git secret reveal
	chmod 400 $$(git secret list)
