# project-template

<!-- FILL IN: what this repo builds, for whom -->

## Start a project

1. Use this template → new private repo.
2. `claude plugin marketplace add ludvignion/harness-plugin && claude plugin install harness-plugin@ludvignion`
   If the pinned tag is missing: `git -C ~/.claude/plugins/marketplaces/ludvignion fetch --tags origin`.
3. Fill `docs/domain-pack/` — the charter items are what every verdict cites, so write them
   before the first build. Rename `src/app`. Edit the first paragraph of `AGENTS.md`.
   List every secret name in `.env.example` (no values); the verdict uses it to prove no test
   makes a live call.
4. `make install && make ci`

## Work

1. Write `kanban/briefs/<n>-<slug>.md`.
2. `/grill <n>` → read the plan → add `approved:` line. The plan carries `scrutiny` and
   `backend`, computed from the brief; override in the plan's Log if you disagree — it is
   recorded as a router miss.
3. `make loop T=<n>.<m>` — headless build, CI, verdict by a fresh agent, Gate 2 page in
   `traces/verdict/`. Read it, merge or reject.
   (Manual path: `/build`, then `/verdict` in a fresh session.)
4. Close-out: home or waive each open warn in the ticket Log; append to
   `traces/grill-misses.jsonl` if there was rework.

The board renders itself after every agent turn. Weekly: `make digest`. After changing the
plugin: `make plugin`, then `make replay`.

## Tracing

Copy `.env.example` to `.env` and set `OPIK_URL_OVERRIDE` (local server or an explicit cloud
URL) and `OPIK_PROJECT_NAME`. `make loop` loads `.env`; every verdict call becomes one Opik
trace. Unset means untraced, never an error. Compare seats with `verdict_eval` from the plugin.

## How the agent talks to you

`/briefing` switches the agent to briefing style for the session: what changed, then lettered
options you pick by letter, then one recommendation. Facts first, decisions last.

It is opt-in per session. To make it the default everywhere, put the same rules in
`~/.claude/CLAUDE.md` — that is personal config and does not belong in this repo, since anyone
starting a project from this template inherits whatever is here.