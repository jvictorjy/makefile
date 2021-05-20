define GetFromPkg
$(shell node -p "require('./package.json').$(1)")
endef

LAST_VERSION := $(call GetFromPkg,version)
PROJECT_URL  := $(call GetFromPkg,repository.url)

current-version:
	@echo "Current version is ${LAST_VERSION}"

release-patch:
	git fetch
	$(eval branch = $(shell git branch --show-current))

	@if [ "$(branch)" != "develop" ]; then\
		echo "You can only create releases from develop" \
		&& echo "Stopping script." \
		&& exit 1 ; \
	fi

	$(eval newVersion = $(shell npm version patch))
	$(eval isBranchExists = $(shell git ls-remote --exit-code --heads origin release/$(newVersion)))

	if [ "$(isBranchExists)" = "" ]; then\
		echo "Creating new branch..." \
		&& git branch "release/$(newVersion)" \
		&& git checkout "release/$(newVersion)" \
		$(eval newTag=$(shell echo $(newVersion))); \
	else\
		echo "Branch release/$(newVersion) already exist." \
		&& echo "Stopping script." \
		&& exit 1 ; \
	fi
	git push -u origin --follow-tags release/$(newVersion)
	@echo empty := \
	@echo substring :=".git"
	@echo Success! Release for version $(newVersion) created. To make a pull request, access the following link: $(subst .git,${empty},${PROJECT_URL})/compare/release/$(newVersion)?expand=1