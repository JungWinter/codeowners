GOPATH:=$(shell go env GOPATH)
APP?=codeowners

.PHONY: build
## build: build the application
build:
	go build -o build/${APP} .

.PHONY: install
## install: install the application
install:
	go install  .

.PHONY: run
## run: run the application
run:
	go run -v -race main.go

.PHONY: format
## format: format files
format:
	@go install github.com/incu6us/goimports-reviser/v2@latest
	goimports-reviser -file-path ./*.go -rm-unused
	gofmt -s -w .
	go mod tidy

.PHONY: test
## test: run tests
test:
	@go get github.com/rakyll/gotest
	gotest -race -cover -v ./...

.PHONY: coverage
## coverage: run tests with coverage
coverage:
	@go get github.com/rakyll/gotest
	gotest -race -coverprofile=coverage.txt -covermode=atomic -v ./...

.PHONY: lint
## lint: check everything's okay
lint:
	golangci-lint run ./...
	go mod verify

.PHONY: generate
## generate: generate source code for mocking
generate:
	@go get golang.org/x/tools/cmd/stringer
	@go get github.com/golang/mock/gomock
	@go install github.com/golang/mock/mockgen
	go generate ./...
	${MAKE} format

.PHONY: help
## help: prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':'
