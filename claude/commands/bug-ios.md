---
description: Create a GitHub issue for a bug report (iOS)
---

# Create Bug Issue (iOS) - Quick Process

You are helping the user create a concise GitHub issue for a bug in an iOS project. Keep this process **short and focused**.

## Process

### Step 1: Understand the Bug
1. Acknowledge what the user reported
2. **Optionally investigate the bug** by examining the codebase:
   - Use Glob to find relevant files (ViewModels, Views, Services)
   - Use Grep to search for related code patterns
   - This is optional - only do this if it helps understand the bug better
   - Don't spend too long investigating simple bugs

### Step 2: Ask 1-2 Quick Questions
Use **AskUserQuestion** to gather essential details. Keep it to **1-2 questions max**.

Example questions:
- What are the steps to reproduce this bug?
- What did you expect to happen vs what actually happened?
- Is this consistently reproducible or intermittent?
- What screen/feature is affected?
- What device/iOS version are you testing on?

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

## Environment

- iOS Version: [e.g., 17.0]
- Device: [e.g., iPhone 15 Pro, Simulator]
- App Version: [if applicable]

## Additional Context

[Any relevant details: crash logs, screenshots, console output, etc.]
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
- Note device/iOS version when relevant

❌ **DON'T:**
- Over-engineer the process
- Ask too many questions
- Spend too long investigating
- Make it as complex as /feature-ios

---

**Remember:** This should be FAST. Get the key info (steps to reproduce, expected vs actual) and create the issue. Users can add more details in comments if needed.
