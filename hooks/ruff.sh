#!/bin/sh
exec ruff check --config "$(dirname "$0")/../configs/ruff.toml" "$@"
