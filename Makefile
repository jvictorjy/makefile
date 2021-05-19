define GetFromPkg
$(shell node -p "require('./package.json').$(1)")
endef

LAST_VERSION := $(call GetFromPkg,version)
PROJECT_URL  := $(call GetFromPkg,repository.url)

current-version:
	@echo "Current version is ${LAST_VERSION}"

release-patch:
	git fetch
	$(eval isBranchExists = $(shell git ls-remote --exit-code --heads origin release/$(LAST_VERSION)))
	$(eval branch = $(shell git branch --show-current))

    @if [ "$(branch)" != : develop ]; then\
        echo "You can only create releases from develop" \
        && echo "Stopping script." \
        && exit 1 ; \
    fi

    $(eval newVersion = $(shell npm version patch))
	@if [ "$(isBranchExists)" >= $(newVersion) ]; then\
	    echo "Branch release/$(newVersion) must be large than current version." \
        && echo "Stopping script." \
        && exit 1 ; \
	fi

	@if [ "$(isBranchExists)" = "" ]; then\
	    echo "Creating new branch..." \
        && git branch "release/$(newVersion)" \
        && git checkout "release/$(newVersion)" \
        $(eval newTag=$(shell echo $(newVersion))) \
        && npm version $(newTag) ; \
    else\
        echo "Branch release/$(newVersion) already exist." \
        && echo "Stopping script." \
        && exit 1 ; \
	fi

    git push -u origin --follow-tags release/$(newVersion)
	@echo empty := \
	@echo substring :=".git"
	@echo Success! Release for version $(newVersion) created. To make a pull request, access the following link: $(subst .git,${empty},${PROJECT_URL})/compare/release/$(newVersion)?expand=1

release-minor:
# 	git fetch
# 	$(eval isBranchExists = $(shell git ls-remote --exit-code --heads origin release/$(LAST_VERSION)))


release-patch :
# 	git fetch
# 	$(eval isBranchExists = $(shell git ls-remote --exit-code --heads origin release/$(LAST_VERSION)))
# 	$(shell git checkout develop)
# 	@echo $(branch)
#
#   $(eval newVersion = $(shell npm version patch))
# 	@echo $(newVersion)
# 	@if [ "$(isBranchExists)" >= $(newVersion) ]; then\
# 	    echo "Branch release/$(newVersion) must be large than current version." \
#         && echo "Stopping script." \
#         && exit 1 ; \
# 	fi
#
# 	@if [ "$(isBranchExists)" = "" ]; then\
# 	    echo "Creating new branch..." \
#         && git branch "release/$(newVersion)" \
#         && git checkout "release/$(newVersion)" \
#         $(eval newTag=$(shell echo $(newVersion))) \
#         && npm version $(newTag) ; \
#     else\
#         echo "Branch release/$(newVersion) already exist." \
#         && echo "Stopping script." \
#         && exit 1 ; \
# 	fi
#
#     git push -u origin --follow-tags release/$(newVersion)
# 	@echo empty := \
# 	@echo substring :=".git"
# 	@echo Success! Release for version $(newVersion) created. To make a pull request, access the following link: $(subst .git,${empty},${PROJECT_URL})/compare/release/$(newVersion)?expand=1

#
#   $(eval newVersion = $(shell npm version patch))
# 	@echo $(newVersion)
# 	@if [ "$(isBranchExists)" >= $(newVersion) ]; then\
# 	    echo "Branch release/$(newVersion) must be large than current version." \
#         && echo "Stopping script." \
#         && exit 1 ; \
# 	fi
#
# 	@if [ "$(isBranchExists)" = "" ]; then\
# 	    echo "Creating new branch..." \
#         && git branch "release/$(newVersion)" \
#         && git checkout "release/$(newVersion)" \
#         $(eval newTag=$(shell echo $(newVersion))) \
#         && npm version $(newTag) ; \
#     else\
#         echo "Branch release/$(newVersion) already exist." \
#         && echo "Stopping script." \
#         && exit 1 ; \
# 	fi
#
#     git push -u origin --follow-tags release/$(newVersion)
# 	@echo empty := \
# 	@echo substring :=".git"
# 	@echo Success! Release for version $(newVersion) created. To make a pull request, access the following link: $(subst .git,${empty},${PROJECT_URL})/compare/release/$(newVersion)?expand=1
