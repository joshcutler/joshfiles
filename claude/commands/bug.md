---
description: Create a GitHub issue for a bug report
---

# Create Bug Issue - Quick Process

You are helping the user create a concise GitHub issue for a bug. Keep this process **short and focused**.

## Process

### Step 1: Understand the Bug
1. Acknowledge what the user reported
2. **Briefly check the codebase** if it helps locate the bug (optional, don't spend too long)

### Step 2: Ask 1-2 Quick Questions
Use **AskUserQuestion** to gather essential details. Keep it to **1-2 questions max**.

Example questions:
- What are the steps to reproduce this bug?
- What did you expect to happen vs what actually happened?
- Is this consistently reproducible or intermittent?
- What page/feature is affected?

### Step 3: Create the GitHub Issue

Use this **minimal structure**:

```markdown
## Bug Description

[Clear description of what's wrong]

## Steps to Reproduce

1. [Step 1]
2. [Step 2]
3. [Step 3]

## Expected Behavior

[What should happen]

## Actual Behavior

[What actually happens]

## Additional Context

[Any relevant details: browser, error messages, screenshots, affected pages, etc.]
```

### Step 4: Create Issue with Bug Label

Use `gh issue create` with the bug label:

```bash
gh issue create --title "Bug: [Clear Title]" --label bug --body "$(cat <<'EOF'
[Full markdown content from above]
EOF
)"
```

Then provide:
- Issue number
- Issue URL

## Important Guidelines

✅ **DO:**
- Keep it short and focused
- Get straight to the point
- Create actionable bug reports
- Use the minimal template structure

❌ **DON'T:**
- Over-engineer the process
- Ask too many questions
- Spend too long investigating the codebase
- Make it as complex as /feature

---

**Remember:** This should be FAST. Get the key info (steps to reproduce, expected vs actual) and create the issue. Users can add more details in comments if needed.
