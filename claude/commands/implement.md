# Implement GitHub Issue

You are tasked with implementing a complete solution for a GitHub issue. Follow this structured workflow:

## Phase 1: Issue Analysis and Planning

1. **Fetch Issue Details**: Use `gh issue view {issue_number}` to get the complete issue description, labels, and comments
2. **Analyze Requirements**: Understand what needs to be implemented, including:
   - Core functionality required
   - UI/UX changes needed
   - Database schema changes
   - API/controller changes
   - Testing requirements
3. **Create Implementation Plan**:
   - If the issue requires architectural analysis or is complex, use the Task tool with `subagent_type='rails-architect'` to analyze the codebase and create a detailed plan
   - Use TodoWrite to create a phased plan with these categories:
     - Setup (branch creation)
     - Database changes (if needed)
     - Model changes
     - Controller/API changes
     - View/UI changes
     - Automated testing (write and run tests)
     - Validation (run full test suite)
     - Documentation review (check for CLAUDE.md additions)

## Phase 2: Branch Setup

1. Create a new feature branch: `git checkout -b feature/issue-{issue_number}-{brief-description}`
2. Ensure the branch is based on the latest main branch

## Phase 3: Implementation

Execute the phased plan you created by delegating to specialized agents:

1. **Database Changes**:
   - Use the Task tool with `subagent_type='rails-models'` to:
     - Create migrations if schema changes are needed
     - Run migrations to verify they work
   - Provide the agent with complete context about required schema changes and relationships

2. **Model Layer**:
   - Use the Task tool with `subagent_type='rails-models'` to:
     - Add/update models, validations, associations
     - Add scopes or class methods as needed
   - Provide context about business logic and data relationships

3. **Controller/Service Layer**:
   - Use the Task tool with `subagent_type='rails-controllers'` to:
     - Implement controller actions
     - Create service objects if complex logic is involved
     - Ensure proper error handling and authorization
   - Provide context about routes, request/response formats, and authorization requirements

4. **View Layer**:
   - Use the Task tool with `subagent_type='rails-frontend'` to:
     - Update views following the mobile-first Bootstrap approach
     - Use Turbo Streams for dynamic updates where appropriate
     - Ensure responsive design (576px breakpoint for mobile)
     - Follow the standard page structure (.container-fluid.mt-4)
   - Provide context about UI/UX requirements and user workflows

## Phase 4: Automated Testing

1. **Write Tests**:
   - Use the Task tool with `subagent_type='rails-qa'` to create comprehensive tests for:
     - Model validations and methods
     - Controller actions and edge cases
     - Integration tests for user workflows
     - Service objects if created
   - Provide context about expected behavior and edge cases

2. **Run Test Suite**: Execute `rails test` and fix any failures

3. **Verify No Regressions**: Ensure existing tests still pass

## Phase 5: Documentation Review

1. **Review CLAUDE.md**: Check if any of these should be documented:
   - New architectural patterns introduced
   - New rake tasks or commands
   - New background jobs
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
- Next steps (PR creation, manual testing checklist)

## Important Reminders

- **Delegate to Agents**: ALWAYS use the Task tool with appropriate subagent_type values rather than doing the work yourself
- **Provide Context**: When delegating to agents, give them complete context about requirements, relationships, and constraints
- **Browser Testing**: Manual browser testing is NOT part of this workflow. Note what should be manually tested in your summary.
- **Automated Tests Only**: Focus on writing and running automated tests (minitest)
- **Follow Project Patterns**: Adhere to patterns in CLAUDE.md (Bootstrap-first, Turbo Streams, etc.)
- **Reference Issue**: Include issue number in commit messages for proper GitHub association
- **Break Into Deliverables**: If the issue is very large, recommend creating sub-issues

## Available Specialized Agents

Use these exact `subagent_type` values with the Task tool:
- `rails-architect` - For architectural analysis and planning
- `rails-models` - For database migrations and model changes
- `rails-controllers` - For controller and service layer implementation
- `rails-frontend` - For view and frontend changes
- `rails-qa` - For writing comprehensive tests
- `rails-security-performance` - For security and performance reviews

---

**Issue Number**: {issue_number}

Begin the implementation workflow now.
