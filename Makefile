GO ?= go
GO_ON ?= GO111MODULE=on go
GO_OFF ?= GO111MODULE=off go
GOFMT ?= gofmt "-s"
PACKAGES ?= $(shell GO111MODULE=on $(GO) list ./...)
VETPACKAGES ?= $(shell GO111MODULE=on $(GO) list ./...)
GOFILES := $(shell find . -name "*.go" -type f)

LDFLAGS += -X "github.com/go-dr/dr.ctl/version.BuildTime=$(shell date -u '+%Y-%m-%d %I:%M:%S %Z')"
LDFLAGS += -X "github.com/go-dr/dr.ctl/version.GitHash=$(shell git rev-parse HEAD)"

TAGS = release

.PHONY: default
default: build

.PHONY: build
build:
	$(GO_ON) build -ldflags '$(LDFLAGS)' -tags '$(TAGS)' -o dr-ctl github.com/go-dr/dr.ctl

.PHONY: test
test:
	$(GO_ON) test -race ./...

.PHONY: fmt
fmt:
	$(GOFMT) -w $(GOFILES)

.PHONY: fmt-check
fmt-check:
	@diff=$$($(GOFMT) -d $(GOFILES)); \
	if [ -n "$$diff" ]; then \
		echo "Please run 'make fmt' and commit the result:"; \
		echo "$${diff}"; \
		exit 1; \
	fi;

.PHONY: vet
vet:
	$(GO_ON) vet $(VETPACKAGES)

.PHONY: lint
lint:
	@hash golint > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		$(GO_OFF) get -u golang.org/x/lint/golint; \
	fi
	for PKG in $(PACKAGES); do golint -min_confidence 1.0 -set_exit_status $$PKG || exit 1; done;

.PHONY: misspell-check
misspell-check:
	@hash misspell > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		$(GO_OFF) get -u github.com/client9/misspell/cmd/misspell; \
	fi
	misspell -error $(GOFILES)

.PHONY: misspell
misspell:
	@hash misspell > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		$(GO_OFF) get -u github.com/client9/misspell/cmd/misspell; \
	fi
	misspell -w $(GOFILES)

.PHONY: clean
clean:
	$(GO_ON) clean -r ./...
	rm -f dr-ctl

.PHONY: tools
tools:
	$(GO_OFF) get golang.org/x/lint/golint
	$(GO_OFF) get github.com/client9/misspell/cmd/misspell
