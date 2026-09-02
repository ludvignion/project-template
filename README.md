# project-template

Shell for a project built with [harness-plugin](https://github.com/ludvignion/harness-plugin).

## Start a project

1. Use this template → new private repo.
2. `claude plugin marketplace add ludvignion/harness-plugin && claude plugin install harness-plugin@ludvignion`
3. Fill `docs/domain-pack/`. Rename `src/app`. Edit the first paragraph of `AGENTS.md`.
   List every secret name in `.env.example` (no values); the verdict uses it to prove no test
   makes a live call.
4. `make install && make ci`

## Work

1. Write `kanban/briefs/<n>-<slug>.md`.
2. `/grill <n>` → `make plan N=<n>` → read, add `approved:` line.
3. `/build <n>.<m>` (or `make loop T=<n>.<m>`).
4. `/verdict <n>.<m>` in a fresh session → `make verdict T=<n>.<m>` → merge or child ticket.
5. Close-out: append to `traces/grill-misses.jsonl` if there was rework.

The board renders itself after every agent turn. Weekly: `make digest`. After changing the
plugin: `make plugin`, then `make replay`.

## How the agent talks to you

`/briefing` switches the agent to briefing style for the session: what changed, then lettered
options you pick by letter, then one recommendation. Facts first, decisions last.

It is opt-in per session. To make it the default everywhere, put the same rules in
`~/.claude/CLAUDE.md` — that is personal config and does not belong in this repo, since anyone
starting a project from this template inherits whatever is here.
