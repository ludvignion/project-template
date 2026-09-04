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
2. `make board` — the board on localhost is the interface from here.
3. `/grill <n>`, then on the board: approve the plan, run it, read each Gate 2 page, ship or
   reject. Child tickets, homing and waivers are board actions too.
4. Terminal fallback: `make run T=<n>.<m>` runs one ticket headless. Plans run from the board.

## Tracing

Copy `.env.example` to `.env` and set `OPIK_URL_OVERRIDE` (local server or an explicit cloud
URL). `make board` and `make run` load `.env` and refuse to start while it is empty. Untraced
runs are opt-in only: `OPIK_DISABLE=1 make run T=<id>`.
