# project-template

<!-- FILL IN: what this repo builds, for whom -->

## Start a project

1. Use this template → new private repo.
2. `claude plugin marketplace add ludvignion/harness-plugin && claude plugin install harness-plugin@ludvignion`
   If the pinned tag is missing: `git -C ~/.claude/plugins/marketplaces/ludvignion fetch --tags origin`.
3. Fill `docs/domain-pack/`, charter included, before the first build — every verdict cites the
   charter. Rename `src/app`. Edit the first paragraph of `AGENTS.md`.
4. `make install && make ci`

## Work

1. Write `kanban/briefs/<n>-<slug>.md`.
2. `/grill <n>`; approve the plan (`python3 $SCRIPTS/kanban_ops.py` has no approve yet: edit
   `approved:` and `status:` in the plan, commit).
3. `/harness-plugin:runner <n>.<m>` or `/harness-plugin:runner plan <n>` in a Claude session:
   it starts the runner, relays the phases, prints the result block, and takes Gate 2 in words
   (`ship`, `reject: <reason>`, `child from F#`, `home F# to <id>`, `waive F#: <reason>`).
   Watch `traces/board.html` meanwhile; it refreshes itself while a run is on.
4. Terminal equivalents: `make run T=<n>.<m>` or `make run P=<n>`, then `make gate A="ship <id>"`.

## Tracing

Copy `.env.example` to `.env` and set `OPIK_URL_OVERRIDE` (local server or an explicit cloud
URL). The runner loads `.env` itself (a session start too); `make run` refuses to start while
it is empty. Untraced runs are opt-in only: `OPIK_DISABLE=1 make run T=<id>`. The runner's
first line says `opik: tracing to <url>` or `opik: untraced (<reason>)`.
