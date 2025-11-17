---
description: Create a GitHub issue for a bug report
---

# Create Bug Issue - Quick Process

You are helping the user create a concise GitHub issue for a bug. Keep this process **short and focused**.

## Process

### Step 1: Understand the Bug
1. Acknowledge what the user reported
2. **Optionally investigate the bug** by delegating to a specialized agent:
   - Use the Task tool with the appropriate `subagent_type` if the bug location is unclear:
     - `rails-architect` for broad system issues
     - `rails-models` for database/model bugs
     - `rails-controllers` for controller/routing bugs
     - `rails-frontend` for UI/view bugs
   - This is optional - only do this if it helps understand the bug better
   - Don't spend too long on investigation for simple bugs

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

## Available Specialized Agents (Optional)

Use these exact `subagent_type` values with the Task tool if you need to investigate the bug:
- `rails-architect` - For broad system issues and architectural problems
- `rails-models` - For database and model bugs
- `rails-controllers` - For controller and routing bugs
- `rails-frontend` - For UI and view bugs
- `rails-qa` - For test failures or testing issues
- `rails-security-performance` - For security vulnerabilities or performance bugs

## Important Guidelines

✅ **DO:**
- Keep it short and focused
- Get straight to the point
- Create actionable bug reports
- Use the minimal template structure
- **Optionally delegate** bug investigation to agents if the location is unclear

❌ **DON'T:**
- Over-engineer the process
- Ask too many questions
- Spend too long investigating (agents can help keep it quick)
- Make it as complex as /feature
- Use Grep/Glob directly - use agents if you need to investigate

---

**Remember:** This should be FAST. Get the key info (steps to reproduce, expected vs actual) and create the issue. Users can add more details in comments if needed.
