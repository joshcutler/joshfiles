---
description: Iteratively flesh out and create comprehensive GitHub issues for new features
---

# Create Feature Issue - Iterative Process

You are helping the user create a well-thought-out GitHub issue for a new feature. The user will provide an initial feature idea, and you should engage in an **iterative conversation** to flesh out the details before creating the issue.

## Step-by-Step Process

### Step 1: Understand the Initial Idea
1. Acknowledge the user's feature description
2. **Examine the codebase FIRST** by delegating to the Rails architect agent:
   - Use the Task tool with `subagent_type='rails-architect'` to:
     - Find similar existing features
     - Understand current architecture patterns
     - Identify relevant models, tables, controllers
     - Review UI/UX conventions
   - Provide the agent with context about the feature idea
3. Summarize what the agent found and what you understand

### Step 2: Ask Clarifying Questions (Iteratively)
Use **AskUserQuestion** tool to gather details. Ask **2-4 questions at a time** - don't overwhelm.

**Round 1 - High-Level Scope:**
- What core problem does this solve?
- Who are the users that need this?
- What are the must-haves vs nice-to-haves?
- Are there similar features in the app we should reference?

**Round 2 - Technical Approach:**
- What models/tables need to be created or modified?
- How should this integrate with existing architecture?
- Are external APIs or background jobs needed?
- What's the data flow?

**Round 3 - User Experience:**
- Where in the app does this feature live?
- What's the user workflow? (step by step)
- What UI components are needed? (pages, modals, forms, tables)
- What user feedback is shown? (flash messages, validations, errors)

**Round 4 - Data & Logic:**
- What specific data needs to be stored? (column names, types)
- What validations and business rules apply?
- Are there authorization/permission requirements?
- How do we handle edge cases?

**Round 5 - Testing & Polish:**
- What are the critical paths to test?
- What error scenarios should we cover?
- Are there performance considerations?
- Any other concerns?

### Step 3: Iterate Based on Answers
- Ask follow-up questions about unclear points
- Explore implications and trade-offs
- **Delegate deeper codebase analysis** to specialized agents as needed:
  - Use `rails-models` to examine database schema and model patterns
  - Use `rails-controllers` to review controller/routing patterns
  - Use `rails-frontend` to analyze UI/UX conventions and view patterns
- Reference specific code examples from the codebase
- Get technical specifics (exact table names, column names, route patterns)

### Step 4: Summarize and Preview
Before creating the issue, show the user a summary:
- Restate the feature and key requirements
- Outline the technical approach
- List open questions (if any)
- Ask if they want to proceed or refine further

### Step 5: Create the GitHub Issue

Use this **exact structure** when creating the issue:

```markdown
## Problem Statement

[Clear description of what problem this solves and why it's needed]

## User Story

As a [user type], I want to [action], so that [benefit].

## Requirements

### Must Have
- [ ] Requirement 1
- [ ] Requirement 2
- [ ] Requirement 3

### Nice to Have
- [ ] Optional enhancement 1
- [ ] Optional enhancement 2

## Technical Implementation

### Database Changes

**Migrations needed:**
- Add/modify table `table_name`
  - Column `column_name` (type, constraints)
  - Index on `column_name`
  - Foreign key to `other_table`

### Models & Business Logic

**New/Modified Models:**
- `ModelName`
  - Associations: `belongs_to :other`, `has_many :things`
  - Validations: `validates :field, presence: true`
  - Scopes: `scope :active, -> { where(active: true) }`
  - Methods: `def custom_method; end`

### Controllers & Routes

**Controllers:**
- `ControllerName#action` - Description of what it does

**Routes:**
```ruby
resources :things do
  member do
    patch :custom_action
  end
end
```

**Authorization:**
- Require authentication: `before_action :authenticate_user!`
- Admin only: `before_action :require_admin!` (if applicable)

### Views & UI

**New/Modified Views:**
- `app/views/controller/action.html.haml` - Description
- UI components: Forms, tables, modals, etc.
- User feedback: Flash messages, inline validations

### Background Jobs (if applicable)

**Jobs:**
- `JobName` - What it does, when it runs
- Scheduling: Cron schedule or trigger event

## User Flow

1. User navigates to [page/location]
2. User clicks [button/link] or enters [form data]
3. System validates [data/permissions]
4. System processes [action] by [doing X, Y, Z]
5. User sees [confirmation/result/feedback]
6. (Additional steps as needed)

## Edge Cases & Validations

- **Edge Case 1:** What happens if [scenario]? → [expected behavior]
- **Edge Case 2:** How to handle [unusual situation]? → [approach]
- **Validation 1:** [Field] must be [constraint]
- **Validation 2:** [Business rule] must be enforced

## Testing Plan

- [ ] **Unit Tests:** Model validations, associations, methods
- [ ] **Controller Tests:** Actions return correct responses, authorization works
- [ ] **Integration Tests:** Complete user flows work end-to-end
- [ ] **Edge Case Tests:** Error handling, validation failures, boundary conditions

## Acceptance Criteria

- [ ] User can [specific action 1]
- [ ] System correctly [behavior 2]
- [ ] Validation prevents [invalid scenario]
- [ ] UI displays [expected feedback]
- [ ] Tests pass for all scenarios
- [ ] No N+1 queries or performance issues
- [ ] (Add more specific criteria)

## Open Questions

- [ ] Question that needs answering before implementation?
- [ ] Design decision that needs team input?

## Related Issues/PRs

#[issue number] - [brief description if relevant]
```

### Step 6: Create and Confirm

1. Use `gh issue create` with heredoc for proper formatting:
```bash
gh issue create --title "Feature: [Clear Title]" --label "feature" --body "$(cat <<'EOF'
[Full markdown content from above]
EOF
)"
```

2. Provide the user with:
   - Issue number
   - Issue URL
   - Brief summary of what was created

## Available Specialized Agents

Use these exact `subagent_type` values with the Task tool when examining the codebase:
- `rails-architect` - For architectural analysis and understanding overall patterns
- `rails-models` - For database schema and model examination
- `rails-controllers` - For controller and routing pattern analysis
- `rails-frontend` - For view and frontend convention review
- `rails-qa` - For understanding testing patterns
- `rails-security-performance` - For security and performance pattern analysis

## Important Guidelines

✅ **DO:**
- **Delegate codebase examination** to specialized agents (don't use Grep/Glob directly)
- Examine codebase BEFORE asking questions
- Ask 2-4 questions at a time (iterative, not overwhelming)
- Reference concrete examples from existing code (found by agents)
- Get specific technical details (table names, columns, routes)
- Explore edge cases and error scenarios
- Think through the full implementation stack (DB → Model → Controller → View)
- Create issues that are immediately actionable by developers

❌ **DON'T:**
- Make assumptions without checking the codebase
- Use Grep/Glob directly - delegate to agents instead
- Ask all questions at once
- Create vague or incomplete issues
- Skip the iterative conversation
- Forget about testing and edge cases
- Create issues without user confirmation

## Example Workflow

**User:** `/feature I want to add export functionality for collections`

**Assistant:**
1. Delegates to rails-architect agent to examine codebase:
   - Task tool with subagent_type='rails-architect'
   - Agent finds `ImportMoxfieldCollectionJob`
   - Agent checks `user_cards` and `cards` schema
   - Agent reviews existing export patterns (if any)

2. Asks Round 1 questions:
   - Should this export match Moxfield CSV format for round-trip compatibility?
   - What should be exported: entire collection, filtered by binder, or custom selection?
   - Instant download or background job for large collections?

3. User answers

4. Asks Round 2 questions based on answers:
   - What specific columns should be in the CSV?
   - Should this be available to all users or just their own data?
   - How should we handle foil/etched/condition data?

5. User answers

6. Summarizes full spec and asks for confirmation

7. Creates comprehensive GitHub issue with all details

8. Returns issue URL: `Created issue #30: Add CSV export for user collections`

---

**Remember:** This is a **conversation**, not a form. Adapt your questions based on the feature and the user's responses. Make them feel heard and help them think through the implementation thoroughly.
