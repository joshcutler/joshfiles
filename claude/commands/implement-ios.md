# Implement GitHub Issue (iOS)

You are tasked with implementing a complete solution for a GitHub issue in an iOS project. Follow this structured workflow:

## Phase 1: Issue Analysis and Planning

1. **Fetch Issue Details**: Use `gh issue view {issue_number}` to get the complete issue description, labels, and comments
2. **Analyze Requirements**: Understand what needs to be implemented, including:
   - Core functionality required
   - UI/UX changes needed
   - Data model changes (Core Data, SwiftData, or plain models)
   - ViewModel/Coordinator changes
   - Testing requirements
3. **Create Implementation Plan**:
   - Use TodoWrite to create a phased plan with these categories:
     - Setup (branch creation)
     - Data layer changes (models, persistence)
     - Business logic (ViewModels, services, managers)
     - UI changes (SwiftUI views or UIKit)
     - Automated testing (write and run tests)
     - Validation (run full test suite)
     - Documentation review (check for CLAUDE.md additions)

## Phase 2: Branch Setup

1. **Ask About Branching**: Use AskUserQuestion to ask: "Do you want to work on a new branch for this issue?"
   - If yes: Create a new feature branch: `git checkout -b feature/issue-{issue_number}-{brief-description}` based on the latest main branch
   - If no: Continue working on the current branch

## Phase 3: Implementation

Execute the phased plan you created:

1. **Data Layer**:
   - Create or update model structs/classes
   - Add Codable conformance for API models
   - Update Core Data/SwiftData models if using persistence
   - Implement data validation logic
   - Follow existing patterns in the codebase for model organization

2. **Business Logic Layer**:
   - Implement or update ViewModels (MVVM) or Reducers (TCA)
   - Create service objects for complex operations
   - Implement network calls if needed
   - Ensure proper error handling with Result types or async/await
   - Use dependency injection patterns consistent with the project

3. **UI Layer**:
   - Implement SwiftUI views (preferred) or UIKit as appropriate
   - Follow the project's design system and component patterns
   - Ensure accessibility (VoiceOver, Dynamic Type)
   - Support both light and dark mode
   - Consider iPad/landscape layouts if applicable

4. **Navigation**:
   - Update navigation flow (NavigationStack, Coordinators, etc.)
   - Handle deep linking if relevant

## Phase 4: Automated Testing

1. **Write Tests**:
   - Unit tests for models and business logic
   - ViewModel tests with mock dependencies
   - UI tests for critical user flows (sparingly)
   - Snapshot tests if the project uses them

2. **Run Test Suite**: Execute tests and fix any failures:
   ```bash
   xcodebuild test -scheme {SchemeName} -destination 'platform=iOS Simulator,name=iPhone 16'
   ```
   Or if using Swift Package Manager:
   ```bash
   swift test
   ```

3. **Verify No Regressions**: Ensure existing tests still pass

## Phase 5: Documentation Review

1. **Review CLAUDE.md**: Check if any of these should be documented:
   - New architectural patterns introduced
   - New build scripts or commands
   - Important technical decisions made
   - New development patterns that should be standardized
   - Common pitfalls discovered during implementation

2. **Suggest Additions**: If relevant additions are found, propose specific updates to CLAUDE.md

## Phase 6: Summary

Provide a concise summary including:
- Branch name created
- Key changes implemented
- Tests written and their status
- Any CLAUDE.md additions recommended
- Next steps (PR creation, manual testing checklist, TestFlight considerations)

## Important Reminders

- **Current Repo Only**: Issues are ALWAYS from the GitHub repo of the current project folder. NEVER search external repos.
- **Scanning Algorithm Documentation**: For projects with `docs/SCANNING-ALGORITHM.md`, ANY changes to scanning-related code (detection, OCR, database search, match filtering) MUST include updates to this documentation. Read it first, update it when done.
- **Explore First**: Use Glob and Grep to understand existing patterns before implementing
- **Follow Project Patterns**: Match existing code style, architecture (MVVM, TCA, etc.), and conventions
- **SwiftUI Preferred**: Use SwiftUI unless the project is UIKit-based or UIKit is specifically needed
- **Async/Await**: Prefer modern concurrency over completion handlers unless matching existing patterns
- **Browser Testing**: Manual device/simulator testing is NOT part of this workflow. Note what should be manually tested in your summary.
- **Reference Issue**: Include issue number in commit messages for proper GitHub association
- **Break Into Deliverables**: If the issue is very large, recommend creating sub-issues

## iOS-Specific Considerations

- **Xcode Project Structure**: Understand the target/scheme organization before making changes
- **Info.plist / Entitlements**: Note if any capability changes are needed
- **Asset Catalogs**: Add images/colors to the appropriate asset catalog
- **Localization**: Use `String(localized:)` or NSLocalizedString for user-facing strings
- **Memory Management**: Watch for retain cycles in closures (use `[weak self]`)
- **Main Thread**: Ensure UI updates happen on the main thread

---

**Issue Number**: $ARGUMENTS

Begin the implementation workflow now.
