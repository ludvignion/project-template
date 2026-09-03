.DEFAULT_GOAL := help
PLUGIN ?= $(shell ls -d ~/.claude/plugins/cache/ludvignion/harness-plugin/* 2>/dev/null | sort -V | tail -1)
SCRIPTS := $(PLUGIN)/scripts

# The venv lives outside the repo: on a Windows drvfs mount (/mnt/c) uv cannot
# create one in-tree — copying wheels fails with EPERM. Override to relocate.
UV_PROJECT_ENVIRONMENT ?= $(HOME)/.venvs/$(notdir $(CURDIR))
UV_LINK_MODE ?= copy
export UV_PROJECT_ENVIRONMENT
export UV_LINK_MODE

install:  ## Sync venv.
	uv sync

plugin:  ## Refresh the marketplace clone, then update the plugin.
	claude plugin marketplace update ludvignion
	claude plugin update harness-plugin@ludvignion

test:  ## Unit tests.
	uv run pytest tests --ignore=tests/evals -q

lint:  ## Lint + format check + types.
	uv run ruff check . && uv run ruff format --check . && uv run mypy src

complexity:  ## Simplicity gates (radon).
	uv run radon cc src -n C -s

mutation:  ## Mutation testing on critical modules (slow).
	uv run mutmut run

ci: lint test complexity  ## What CI runs.

eval:  ## Product evals (only if src/ calls a model). Costs money. Never in ci.
	uv run pytest tests/evals -q

verdict:  ## Render gate-2 page. Usage: make verdict T=1.2
	python3 $(SCRIPTS)/render_verdict.py $(T)

board:  ## Render status + dependency board.
	python3 $(SCRIPTS)/render_board.py .

digest:  ## Rebuild traces/blind-spots.md from grill-misses.
	python3 $(SCRIPTS)/grill_digest.py

replay:  ## Re-run grill on golden briefs; diff escalations.
	python3 $(SCRIPTS)/replay.py .

loop:  ## Headless build→ci→verdict for one ticket. Usage: make loop T=1.2
	python3 $(SCRIPTS)/runner.py $(T)

help:  ## Show this help.
	@grep -E '^[a-z-]+:.*##' $(MAKEFILE_LIST) | awk -F':.*##' '{printf "  %-12s %s\n", $$1, $$2}'

.PHONY: install plugin test lint complexity mutation ci eval verdict board digest replay loop help
