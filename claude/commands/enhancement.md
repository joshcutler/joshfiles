---
description: Create GitHub issues for small enhancements (auto-detects Rails or iOS)
---

# Create Enhancement Issue - Smart Dispatcher

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
Tell the user: "Detected **Rails** project. Running `/enhancement-rails` workflow."

Then follow the `/enhancement-rails` workflow:
- Examine codebase (delegate to `rails-*` agents)
- Ask 4-6 clarifying questions (1-2 rounds)
- Quick summary
- Create GitHub issue with enhancement label

### If iOS project detected:
Tell the user: "Detected **iOS** project. Running `/enhancement-ios` workflow."

Then follow the `/enhancement-ios` workflow:
- Examine codebase (use Glob/Grep)
- Ask 4-6 clarifying questions (1-2 rounds)
- Quick summary
- Create GitHub issue with enhancement label

### If ambiguous or neither detected:
Use **AskUserQuestion** to ask:
- "I couldn't auto-detect the project type. Which platform is this project?"
- Options: "Rails", "iOS", "Other"

---

Detect the project type now and begin the appropriate workflow.
