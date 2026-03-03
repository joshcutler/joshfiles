---
description: Create comprehensive GitHub issues for new features (auto-detects Rails or iOS)
---

# Create Feature Issue - Smart Dispatcher

This command automatically detects your project type and delegates to the appropriate platform-specific workflow.

## Step 1: Detect Project Type

Check for project indicators in the current directory:

**Rails indicators:**
- `Gemfile` with Rails gem
- `config/routes.rb`
- `app/controllers/` directory

**iOS indicators:**
- `*.xcodeproj` or `*.xcworkspace`
- `Package.swift`

## Step 2: Delegate to Platform-Specific Workflow

Based on detection:

### If Rails project detected:
Tell the user: "Detected **Rails** project. Running `/feature-rails` workflow."

Then follow the `/feature-rails` workflow:
- Examine codebase (delegate to `rails-architect` agent)
- Iterative questioning (2-4 questions per round, as many rounds as needed until fully specified)
- Delegate deeper analysis to specialized `rails-*` agents
- Summarize and preview
- Create comprehensive GitHub issue with feature label

### If iOS project detected:
Tell the user: "Detected **iOS** project. Running `/feature-ios` workflow."

Then follow the `/feature-ios` workflow:
- Examine codebase (use Glob/Grep)
- Iterative questioning (2-4 questions per round, as many rounds as needed until fully specified)
- Summarize and preview
- Create comprehensive GitHub issue with feature label

### If ambiguous or neither detected:
Use **AskUserQuestion** to ask:
- "I couldn't auto-detect the project type. Which platform is this project?"
- Options: "Rails", "iOS", "Other"

---

Detect the project type now and begin the appropriate workflow.
