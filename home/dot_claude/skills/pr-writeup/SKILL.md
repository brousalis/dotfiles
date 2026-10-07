---
name: pr-writeup
description: Write a pull request title and description for the current branch in Pete's style. Use when asked to open a PR, write a PR description, or summarize a branch for review.
---

# Writing a PR

1. Read the branch: `git log --oneline <base>..HEAD` and `git diff <base>...HEAD --stat`,
   then the diff itself. Use the repo's PR template if it has one.
2. Title: imperative, under 70 characters, says what changes for a user or developer.
3. Body, in this order:
   - **Why**: the problem or goal in one or two sentences. Link the issue if there is one.
   - **What changed**: the behaviour a reviewer would see, in plain language, not a file list.
   - **How**: only the parts a reviewer can't infer from the diff (approach, trade-offs, anything surprising).
   - **Testing**: what was run and what passed; what was not tested.
4. Keep it short. No headings for empty sections, no restating the diff line by line.
5. Call out anything risky (migrations, config changes, breaking changes) at the top.
