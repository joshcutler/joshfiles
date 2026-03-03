---
description: Create a GitHub issue for a bug report (auto-detects Rails or iOS)
---

# Create Bug Issue - Smart Dispatcher

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
Tell the user: "Detected **Rails** project. Running `/bug-rails` workflow."

Then follow the `/bug-rails` workflow:
- Understand the bug (optionally delegate to `rails-*` agents)
- Ask 1-2 quick questions
- Create GitHub issue with bug label

### If iOS project detected:
Tell the user: "Detected **iOS** project. Running `/bug-ios` workflow."

Then follow the `/bug-ios` workflow:
- Understand the bug (optionally use Glob/Grep to investigate)
- Ask 1-2 quick questions (include device/iOS version)
- Create GitHub issue with bug label

### If ambiguous or neither detected:
Use **AskUserQuestion** to ask:
- "I couldn't auto-detect the project type. Which platform is this project?"
- Options: "Rails", "iOS", "Other"

---

Detect the project type now and begin the appropriate workflow.
