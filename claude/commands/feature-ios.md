---
description: Iteratively flesh out and create comprehensive GitHub issues for new iOS features
---

# Create Feature Issue (iOS) - Iterative Process

You are helping the user create a well-thought-out GitHub issue for a new feature in an iOS app. The user will provide an initial feature idea, and you should engage in an **iterative conversation** to flesh out the details before creating the issue.

## Step-by-Step Process

### Step 1: Understand the Initial Idea
1. Acknowledge the user's feature description
2. **Examine the codebase FIRST**:
   - Use Glob to find similar existing features
   - Use Grep to understand current architecture patterns
   - Identify relevant models, ViewModels, Views
   - Review UI/UX conventions in the project
3. Summarize what you found and what you understand

### Step 2: Ask Clarifying Questions (Iteratively)
Use **AskUserQuestion** tool to gather details. Ask **2-4 questions at a time** - don't overwhelm.

**Round 1 - High-Level Scope:**
- What core problem does this solve?
- Who are the users that need this?
- What are the must-haves vs nice-to-haves?
- Are there similar features in the app we should reference?

**Round 2 - Technical Approach:**
- What models/data structures need to be created or modified?
- How should this integrate with existing architecture (MVVM, TCA, etc.)?
- Are external APIs or background processing needed?
- What's the data flow?

**Round 3 - User Experience:**
- Where in the app does this feature live?
- What's the user workflow? (step by step)
- What UI components are needed? (screens, sheets, forms, lists)
- What user feedback is shown? (alerts, toasts, validation errors)

**Round 4 - Data & Logic:**
- What specific data needs to be stored? (property names, types)
- What validations and business rules apply?
- Are there authorization/permission requirements?
- How do we handle edge cases?

**Round 5 - Testing & Polish:**
- What are the critical paths to test?
- What error scenarios should we cover?
- Are there performance considerations?
- Any accessibility requirements?

### Step 3: Iterate Based on Answers
- Ask follow-up questions about unclear points
- Explore implications and trade-offs
- Use Glob/Grep for deeper codebase analysis as needed
- Reference specific code examples from the codebase
- Get technical specifics (exact type names, property names, navigation patterns)

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

### Data Models

**New/Modified Models:**
- `ModelName`
  - Properties: `id: UUID`, `name: String`, `createdAt: Date`
  - Codable conformance for API/persistence
  - Validation logic

### Persistence (if applicable)

- Core Data / SwiftData entities
- UserDefaults keys
- Keychain items

### ViewModels / State Management

**New/Modified ViewModels:**
- `FeatureViewModel`
  - State: `@Published var items: [Item]`, `@Published var isLoading: Bool`
  - Actions: `func loadItems()`, `func saveItem(_ item: Item)`
  - Dependencies: `APIService`, `DataStore`

### Views & UI

**New/Modified Views:**
- `FeatureView.swift` - Main feature screen
- `FeatureRowView.swift` - List row component
- `FeatureDetailSheet.swift` - Detail modal

**Navigation:**
- Entry point: Tab bar / Navigation link / Deep link
- Flow: Screen A → Screen B → Sheet C

**Design Considerations:**
- Dark mode support
- Dynamic Type support
- iPad / landscape layouts (if applicable)

### Networking (if applicable)

**API Endpoints:**
- `GET /api/resource` - Fetch items
- `POST /api/resource` - Create item

**Request/Response Models:**
- `ResourceRequest`, `ResourceResponse`

### Background Processing (if applicable)

- Background tasks
- Push notification handling
- Background fetch

## User Flow

1. User navigates to [screen/location]
2. User taps [button] or enters [form data]
3. App validates [data/permissions]
4. App processes [action] by [doing X, Y, Z]
5. User sees [confirmation/result/feedback]
6. (Additional steps as needed)

## Edge Cases & Validations

- **Edge Case 1:** What happens if [scenario]? → [expected behavior]
- **Edge Case 2:** How to handle [unusual situation]? → [approach]
- **Validation 1:** [Field] must be [constraint]
- **Validation 2:** [Business rule] must be enforced

## Testing Plan

- [ ] **Unit Tests:** Model validation, ViewModel logic, service methods
- [ ] **UI Tests:** Critical user flows
- [ ] **Snapshot Tests:** Key UI states (if project uses them)
- [ ] **Edge Case Tests:** Error handling, validation failures, empty states

## Acceptance Criteria

- [ ] User can [specific action 1]
- [ ] App correctly [behavior 2]
- [ ] Validation prevents [invalid scenario]
- [ ] UI displays [expected feedback]
- [ ] Tests pass for all scenarios
- [ ] No memory leaks or retain cycles
- [ ] Accessibility: VoiceOver works, Dynamic Type scales
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

## Important Guidelines

✅ **DO:**
- Examine codebase with Glob/Grep BEFORE asking questions
- Ask 2-4 questions at a time (iterative, not overwhelming)
- Reference concrete examples from existing code
- Get specific technical details (type names, properties, navigation patterns)
- Explore edge cases and error scenarios
- Think through the full implementation stack (Data → ViewModel → View)
- Consider iOS-specific concerns (lifecycle, memory, main thread)
- Create issues that are immediately actionable by developers

❌ **DON'T:**
- Make assumptions without checking the codebase
- Ask all questions at once
- Create vague or incomplete issues
- Skip the iterative conversation
- Forget about testing and edge cases
- Create issues without user confirmation
- Ignore accessibility requirements

## Example Workflow

**User:** `/feature-ios I want to add a favorites feature for items`

**Assistant:**
1. Examines codebase:
   - Glob finds `ItemListView.swift`, `ItemViewModel.swift`, `Item.swift`
   - Grep finds existing data persistence patterns
   - Reviews how similar features are structured

2. Asks Round 1 questions:
   - Should favorites persist locally only or sync to a backend?
   - What items can be favorited? All items or specific types?
   - How should favorites be accessed? Separate tab, filter, or both?

3. User answers

4. Asks Round 2 questions based on answers:
   - Should we use SwiftData for persistence or UserDefaults?
   - What should the favorite button look like? Heart icon with animation?
   - Should there be a limit on favorites?

5. User answers

6. Summarizes full spec and asks for confirmation

7. Creates comprehensive GitHub issue with all details

8. Returns issue URL: `Created issue #30: Add favorites feature for items`

---

**Remember:** This is a **conversation**, not a form. Adapt your questions based on the feature and the user's responses. Make them feel heard and help them think through the implementation thoroughly.
