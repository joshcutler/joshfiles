---
description: Complete branch cleanup - creates/merges PR, deletes branches, returns to clean main
---

# Branch Cleanup Command

You are helping the user perform a complete branch cleanup workflow. This command handles everything from PR creation to branch deletion, leaving the repository in a clean state on main.

## Process Overview

Execute the following steps in order:

### Step 1: Check Current State

1. Check the current branch name with `git branch --show-current`
2. Check if a PR already exists for this branch with `gh pr list --head <branch-name>`
3. Check git status to ensure there are no uncommitted changes

If there are uncommitted changes, inform the user and ask if they want to:
- Commit the changes first
- Stash the changes
- Abort the cleanup

### Step 2: Create PR (if needed)

If no PR exists:
1. Follow the standard PR creation process from the commit creation instructions:
   - Analyze the git diff and commit history
   - Draft a comprehensive PR description with Summary and Test plan sections
   - Create the PR with `gh pr create`
   - Include the standard Claude Code footer

If PR already exists:
- Display the existing PR URL
- Proceed to merge step

### Step 3: Merge the PR

1. Use GitHub CLI to squash merge the PR: `gh pr merge <pr-number> --squash --delete-branch`
   - This will squash all commits into one
   - Automatically delete the remote branch
   - Close the PR

2. If the merge command requires confirmation or has options, handle them appropriately

### Step 4: Local Branch Cleanup

1. Switch to main branch: `git checkout main`
2. Pull the latest changes: `git pull origin main`
3. Delete the local feature branch: `git branch -D <branch-name>`
4. Prune any stale remote tracking branches: `git remote prune origin`

### Step 5: Verify Clean State

1. Confirm current branch is main: `git branch --show-current`
2. Show the latest commit to verify the merge: `git log -1 --oneline`
3. Show branch list to confirm cleanup: `git branch -a`

### Step 6: Summary

Provide a clear summary:
- PR that was merged (number and title)
- Branch that was cleaned up
- Current state: "You are now on a clean main branch"

## Important Guidelines

✅ **DO:**
- Check for uncommitted changes before starting
- Verify PR exists or create one
- Use squash merge to keep history clean
- Delete both remote and local branches
- Confirm final state on main

❌ **DON'T:**
- Force any operations without user confirmation if there are uncommitted changes
- Skip verification steps
- Leave orphaned branches
- Forget to pull latest main after merge

## Error Handling

If any step fails:
1. Report the specific error to the user
2. Explain what succeeded and what failed
3. Provide guidance on how to resolve the issue
4. Do NOT continue with subsequent steps if a critical step fails

Common issues:
- **PR merge conflicts**: Inform user they need to resolve conflicts first
- **Protected branch rules**: User may need to merge via GitHub UI
- **Permission issues**: User may need appropriate repository permissions
- **Branch already deleted**: Skip deletion step and inform user

## Example Output

After successful completion, output should look like:

```
✓ PR #123 "Add feature X" merged successfully
✓ Remote branch 'feature/feature-x' deleted
✓ Local branch 'feature/feature-x' deleted
✓ Switched to main and pulled latest changes

You are now on a clean main branch with the latest changes.
Latest commit: abc1234 Add feature X (#123)
```
