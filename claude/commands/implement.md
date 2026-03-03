---
description: Implement GitHub Issue (auto-detects Rails or iOS)
---

# Implement GitHub Issue - Smart Dispatcher

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
- `*.xcconfig` files

## Step 2: Delegate to Platform-Specific Workflow

Based on detection:

### If Rails project detected:
Tell the user: "Detected **Rails** project. Running `/implement-rails` workflow."

Then follow the complete `/implement-rails` workflow:
- Phase 1: Issue Analysis (delegate to `rails-architect` agent)
- Phase 2: Branch Setup
- Phase 3: Implementation (delegate to `rails-models`, `rails-controllers`, `rails-frontend` agents)
- Phase 4: Testing with `rails test`
- Phase 5: Documentation Review
- Phase 6: Summary

### If iOS project detected:
Tell the user: "Detected **iOS** project. Running `/implement-ios` workflow."

Then follow the complete `/implement-ios` workflow:
- Phase 1: Issue Analysis and Planning
- Phase 2: Branch Setup
- Phase 3: Implementation (Data layer, Business logic, UI, Navigation)
- Phase 4: Testing with `xcodebuild test`
- Phase 5: Documentation Review
- Phase 6: Summary

### If ambiguous or neither detected:
Use **AskUserQuestion** to ask:
- "I couldn't auto-detect the project type. Which platform is this project?"
- Options: "Rails", "iOS", "Other"

If "Other" is selected, explain that only Rails and iOS workflows are currently available and offer to create a generic issue instead.

---

**Issue Number**: $ARGUMENTS

Detect the project type now and begin the appropriate workflow.
