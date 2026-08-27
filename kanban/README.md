# kanban

- `briefs/<n>-<slug>.md` — you write these (template in the plugin).
- `<n>.plan.md` — the grill writes; you approve by adding `approved: <name> <date>`.
- `<n>.<m>.<slug>.md` — tickets. `status:` in frontmatter, `## Log` append-only, role-tagged.
- `<n>.<m>.<p>.<slug>.md` — children spawned by a rejected verdict. No plan gate.
- `.active` — current ticket id; the write-guard hook reads it. Git-ignored.
