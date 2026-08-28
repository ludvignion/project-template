# Charter

Non-negotiables for this domain. Verdict checks each; a waiver needs written rationale in the ticket.

## 1. Exact arithmetic on divisible quantities

A quantity that must not lose value under division is represented as an integer count of its
smallest indivisible unit, and every split of it is exact: the parts sum to the original.

Pattern: `allocate(total: int, weights: Sequence[int]) -> list[int]` — integer arithmetic
throughout, remainder distributed by a deterministic rule, `sum(parts) == total` unconditionally.

Anti-pattern: `total * (w / sum(weights))` — float division, then `round()` per part. The parts
drift from the total by a fraction of a unit, and the drift is invisible until it accumulates.

Demonstrated by: a property test asserting `sum(allocate(t, w)) == t` for all non-negative `t`
and all weight vectors with a positive sum, including vectors where the division is inexact
(e.g. `allocate(100, [1, 1, 1])`).
