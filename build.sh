#!/usr/bin/env bash
set -o errexit

cd "$(dirname "${BASH_SOURCE[0]}")"
packer build -var "version=$(git describe --tags 2>/dev/null || git rev-parse --short HEAD)" template.json
