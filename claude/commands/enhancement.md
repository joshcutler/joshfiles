---
description: Create GitHub issues for small enhancements and improvements
---

# Create Enhancement Issue - Streamlined Process

You are helping the user create a focused GitHub issue for a small enhancement or improvement. This should be **quicker and lighter** than the `/feature` process.

## Step-by-Step Process

### Step 1: Understand the Enhancement
1. Acknowledge the user's enhancement idea
2. **Quickly examine the codebase** to:
   - Find the affected code/files
   - Understand existing patterns
   - Identify what needs to change
3. Summarize what you found

### Step 2: Ask Clarifying Questions (1-2 Rounds Max)
Use **AskUserQuestion** tool to gather key details. Keep it to **4-6 questions total** across 1-2 rounds.

**Round 1 - Scope & Approach:**
- What specific behavior/UI/functionality should change?
- What's the desired outcome after this enhancement?
- Are there any constraints or preferences for implementation?
- Should this match existing patterns in the codebase?

**Round 2 (if needed) - Technical Details:**
- Any specific technical approach you prefer?
- Should this affect all users or specific scenarios?
- Are there edge cases to consider?

### Step 3: Quick Summary
Show a brief summary of the plan and ask if they want to proceed.

### Step 4: Create the GitHub Issue

Use this **concise structure**:

```markdown
## Enhancement Description

[Clear description of the improvement and why it's valuable]

## Current Behavior

[What happens now]

## Proposed Behavior

[What should happen after the enhancement]

## Implementation Approach

### Changes Needed
- [ ] Change 1 (file/component affected)
- [ ] Change 2 (file/component affected)
- [ ] Change 3 (file/component affected)

### Technical Details
- **Files to modify:** `path/to/file.rb`, `path/to/view.haml`
- **Key changes:** Brief description of what code changes are needed
- **Considerations:** Any important edge cases or validation needs

## Acceptance Criteria

- [ ] Specific outcome 1
- [ ] Specific outcome 2
- [ ] Specific outcome 3
- [ ] Tests updated to cover changes
- [ ] No breaking changes to existing functionality

## Testing Notes

- [ ] Manual test: [specific scenario to verify]
- [ ] Automated test: [what tests need updating/adding]
```

### Step 5: Create Issue with Enhancement Label

Use `gh issue create` with the enhancement label:

```bash
gh issue create --title "Enhancement: [Clear Title]" --label enhancement --body "$(cat <<'EOF'
[Full markdown content from above]
EOF
)"
```

Then provide:
- Issue number
- Issue URL
- Brief summary

## Important Guidelines

✅ **DO:**
- Keep it focused and actionable
- Quickly examine relevant code
- Ask only essential questions (4-6 total)
- Reference specific files and patterns
- Make implementation clear and straightforward
- Focus on incremental improvements

❌ **DON'T:**
- Turn this into a full `/feature` process
- Ask too many rounds of questions
- Over-complicate small changes
- Create massive enhancement specs
- Forget to check existing code patterns

## Enhancements vs Features vs Bugs

Use `/enhancement` for:
- UI/UX improvements to existing features
- Performance optimizations
- Code refactoring with user-visible benefits
- Adding small options/settings to existing features
- Improving error messages or user feedback
- Making existing functionality more intuitive

Use `/feature` for:
- Brand new functionality
- Complex multi-component additions
- Features requiring new database tables
- Major architectural changes

Use `/bug` for:
- Things that are broken
- Incorrect behavior
- Errors and exceptions

---

**Remember:** This is for **incremental improvements** to existing functionality. Keep it light, focused, and actionable. The goal is to create a clear, concise issue that can be implemented quickly.
