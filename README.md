# dupmachine/linters

Shared linter configs and reusable workflows for all dupmachine repositories.

## Linters

| Linter | Files | Config |
|--------|-------|--------|
| [yamllint](https://github.com/adrienverge/yamllint) | `*.yml`, `*.yaml` | `configs/yamllint.yml` |
| [pymarkdown](https://github.com/jackdewinter/pymarkdown) | `*.md` | `configs/pymarkdown.json` |
| [ruff](https://github.com/astral-sh/ruff) | `*.py` | `configs/ruff.toml` |

## Overrides

| Linter | Rule | Default | Here | Reason |
|--------|------|---------|------|--------|
| yamllint | `line-length` | enabled (max 80) | disabled | Traefik labels in docker-compose files (e.g. `traefik.http.routers.${APP_NAME}.tls.certresolver=...`) routinely exceed 80 chars and cannot be meaningfully wrapped |
| pymarkdown | MD013 line-length | enabled | disabled | Tables and inline code references in README files break when wrapped |
| pymarkdown | MD026 trailing-punctuation | enabled | disabled | AGENTS.md files use `Setup:`, `Usage:`, `Configuration:` as section headings by convention |
| pymarkdown | MD034 no-bare-urls | enabled | disabled | AGENTS.md files reference internal URLs (e.g. Semaphore) inline without link syntax |
| pymarkdown | MD024 no-duplicate-heading | enabled (strict) | `allow_different_nesting: true` | Playbook docs repeat identical subheadings (e.g. `### Usage example`) under each playbook section |
| ruff | E501 line-length | enabled (max 88) | disabled | Long error messages and inline expressions in Python scripts exceed 88 chars and cannot be meaningfully wrapped |

## Usage

### Pre-commit

Copy `.pre-commit-config.yaml.example` to your repo as `.pre-commit-config.yaml`, or add the hooks to your existing config:

```yaml
repos:
  - repo: https://github.com/dupmachine/linters
    rev: main
    hooks:
      - id: yamllint
      - id: pymarkdown
      - id: ruff  # optional: only for repos with Python code
```

Required system dependencies: `pip install yamllint pymarkdownlnt ruff`.

### GitHub Actions

Add jobs to your `lint.yml` workflow:

```yaml
name: Lint
on:
  push:
    branches: ["main"]
  pull_request:
jobs:
  yamllint:
    uses: dupmachine/linters/.github/workflows/yamllint.yml@main
  pymarkdown:
    uses: dupmachine/linters/.github/workflows/pymarkdown.yml@main
  ruff:
    uses: dupmachine/linters/.github/workflows/ruff.yml@main
```

## Adding a new linter

See `AGENTS.md`.
