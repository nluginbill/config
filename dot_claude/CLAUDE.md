# User-level standing rules (all repos)

## Review workflows — mandatory for every implementation pass

This rule applies in **every repo** (pave-2.0, thread, platform-common, prototype, …), not just where it was first written. It is Nate's explicit standing opt-in to the `Workflow` tool for reviews.

**Every implementation pass gets reviewed via a multi-agent review `Workflow` (or equivalently a dispatched reviewer-agent panel) as it lands — always, not on request.** When an agent finishes an impl pass for a bead, immediately run a per-bead review (tailored reviewer panel for that bead's surface → adversarially verify each finding → act only on confirmed, in-scope findings), then have the comments addressed BEFORE opening the PR.

**Why:** the review step is a non-optional part of the work loop (reaffirmed 2026-07-13; re-confirmed for thread 2026-10-03 after a session there skipped it), not something to skip for "small"/Tier-A changes. A worker passing its own Definition-of-Done gates (format/lint/typecheck/tests/build) does NOT satisfy this — the review is an independent pass dispatched by the orchestrator.

**How to apply:**
- As each implementation comes in → launch a review Workflow (batch multiple ready branches into one workflow when they land together).
- **The panel must be COMPREHENSIVE across EVERY domain the PR touches — cumulative, not a single lens** (reaffirmed 2026-07-20: a security-only review of a D2 encryption PR wrongly skipped the model-migration, TypeScript, architecture, and simplicity dimensions). Start from the base panel for any code change — correctness, kieran-typescript, code-simplicity, architecture-strategist — and ADD the surface specialists: crypto/authz/VAWA → security-sentinel; model/schema at-rest → data-integrity-guardian; flipping/backfilling persisted data → data-migration-expert; frontend effects/races → julik-frontend-races. When N near-identical branches land together, add a cross-branch consistency/dedup pass (code-simplicity + architecture) — 5 copy-pasted stores is itself a finding. Always adversarially verify each finding before acting.
- Address confirmed comments (fix directly or send back to the impl agent) → THEN push/open PR → Copilot rounds (where that repo uses them).
- **Codex cross-check (standing, Nate 2026-10-07): every review panel includes ONE reviewer run through Codex in addition to the native Claude panel.** Dispatch it via the codex plugin (the `codex:codex-rescue` agent / codex rescue runtime), giving it the same brief as the panel's highest-risk lens; its findings merge into the same consolidated fix round and get the same verify treatment as native findings. If the Codex CLI is unavailable, proceed native-only and say so in the status — Codex never blocks the review. (This refines the cross-dispatch experiment's "reviews stay native" rule: the native panel remains the required core; Codex is an additional lens, not a substitute.)
- Then merge directly: code-complete + CI-green + Copilot round addressed → merge. **No teammate-approval gate** (retired as a hard gate 2026-10-05, reaffirmed by Nate 2026-10-09 on thread PR #715: "does not need teammate approval, just merge it"; no branch protection requires approvals). Serial, CI-gated merges still apply when several branches queue.
- **Clean up worktrees when work finishes (Nate 2026-11-09).** When any piece of work is finished (PR merged or closed, renders captured, a throwaway check done), remove every worktree it created: implementer `.claude/worktrees/agent-*`, render or QA worktrees under `~/src/thread-wt/`, and their compose stacks (containers, networks, images). First confirm the worktree is clean and its HEAD is on the remote. Unlock it if needed (`git worktree unlock`), run `git worktree remove --force`, delete the local branch, then `git worktree prune`. Keep a worktree only while its PR is still open.

**Economical sizing (Nate 2026-08-24: "19 agents is a little extravagant — choose reviewers more economically").** The review stays mandatory; the SIZE calibrates to the diff. The Codex cross-check rides on top at every size (a small diff = 1 native reviewer + the Codex leg):
- Small diff (≤~3 files, copy/comments/styles): **1 reviewer**, verify only critical/major findings.
- Typical UI/parity branch: **2 reviewers** (parity+correctness combined lens; contract/hygiene second), adversarial verify **only critical/major** findings — minors go straight to the fixer, whose standing instruction to re-derive every cite/value already catches reviewer errors.
- Large/behavioral (state machines, write paths, wire adjacency): **full review battery** — comprehensive multi-dimension panel, adversarial verify as warranted, no economy cap (Nate 2026-08-25: "on big stuff, you can do full review battery"). The economy applies to small/typical diffs only.
- Cite nits: reviewers batch ALL wrong-cite findings into ONE finding, never one-per-cite (per-cite findings each spawned a verifier — the main source of 15–20-agent runs).

**Why the sizing:** verify-everything spent most of its agents confirming comment-typo findings; the fixer's re-derivation step is the cheaper and equally reliable check for minors. Majors/criticals keep adversarial verification — that's where refutations have real value.

The full loop doc lives at `/Users/nathanielluginbill/notes/projects/pave/bead-work-loop-workflow.md`.
