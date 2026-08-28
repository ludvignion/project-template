# <project>

<One paragraph: what this repo builds, for whom. Replace.>

Workflow comes from **harness-plugin** (pinned in `.claude/settings.json`). Do not copy skills into this repo.

# Where things live

| Path | Role |
|---|---|
| `kanban/briefs/` | human-written briefs |
| `kanban/plans/<n>.plan.md` | grill write-back; gate 1 lives in its `approved:` line, not `status:` |
| `kanban/tickets/<n>.<m>.<slug>.md` | tickets; role-tagged append-only `## Log` |
| `docs/glossary.md` | one canonical name per concept; update in the same PR that introduces it |
| `docs/adr/` | numbered, append-only decisions (template in the plugin) |
| `docs/domain-pack/` | everything domain-specific: charter, conventions, references |
| `traces/` | grill records, verdicts, plan pages, board, blind-spots. Machine-written. |
| `src/app/` | product code. `MODULE.md` only on deep modules. |
| `tests/` | mirrors `src/`. `tests/evals/` only when `src/` calls a model; never in `make ci`. |

# Commands

`make help`. Core: `install · ci · plan N= · board · verdict T= · digest · replay · loop T=`.

# Invariants agents can't infer

- **Tests before code, in their own commit.**
  Good: `test(1.2): ACs as tests` then `feat(1.2): ...`. Bad: one commit with both.
- **CI is the only authority on green.**
  Good: "make ci: 41 passed". Bad: "tests should pass now".
- **The slice does what the slice does.**
  Good: `### [build] — finding: off-by-one in src/app/other.py, not touched`. Bad: fixing it "while here".
- **No helper before three call sites.**
  Good: two similar 8-line blocks. Bad: `utils.py` with one caller.
- **Every non-trivial addition traces to an AC at close-out.**
  Good: `src/app/x/reconcile.py → AC-2`. Bad: "added for future flexibility".
- **Domain rules live in `docs/domain-pack/`, never in skills or AGENTS.md.**
  Good: charter item cited by path in a verdict. Bad: a client name in a SKILL.md.

# Principles

Remove instructions over adding. Boring beats elegant unless an AC says otherwise.
A new rule here needs a why plus a good and a bad example, like the ones above.
