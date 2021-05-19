define GetFromPkg
$(shell node -p "require('./package.json').$(1)")
endef

LAST_VERSION := $(call GetFromPkg,version)
PROJECT_URL  := $(call GetFromPkg,repository.url)

current-version:
	@echo "Current version is ${LAST_VERSION}"

release-patch :
# 	git fetch
# 	$(eval isBranchExists = $(shell git ls-remote --exit-code --heads origin release/$(LAST_VERSION)))
	$(eval newVersion = $(shell npm version patch))
	@echo $(newVersion)
# 	@if [ "$(isBranchExists)" >= $(LAST_VERSION) ]; then\
# 	    echo "Branch release/$(LAST_VERSION) must be large than current version." \
#         && echo "Stopping script." \
#         && exit 1 ; \
# 	fi
#
# 	@if [ "$(isBranchExists)" = "" ]; then\
# 	    echo "Creating new branch..." \
#         && git branch "release/$(version)" \
#         && git checkout "release/$(version)" \
#         $(eval newTag=$(shell echo $(version))) \
#         && npm version $(newTag) ; \
#     else\
#         echo "Branch release/$(version) already exist." \
#         && echo "Stopping script." \
#         && exit 1 ; \
# 	fi
#
#     git push -u origin --follow-tags release/$(version)
# 	@echo empty := \
# 	@echo substring :=".git"
# 	@echo Success! Release for version $(version) created. To make a pull request, access the following link: $(subst .git,${empty},${PROJECT_URL})/compare/release/$(version)?expand=1
