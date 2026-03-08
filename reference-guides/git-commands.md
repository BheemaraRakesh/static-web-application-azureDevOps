# Git Commands Reference

Essential Git commands for version control, collaboration, and production workflows.

## Repository Setup
```bash
# Initialize repository
git init

# Clone repository
git clone https://github.com/user/repo.git
git clone git@github.com:user/repo.git

# Add remote
git remote add origin https://github.com/user/repo.git

# Show remotes
git remote -v

# Remove remote
git remote remove origin
```

## Basic Workflow
```bash
# Check status
git status

# Add files
git add file.txt
git add .

# Commit changes
git commit -m "Commit message"

# Push changes
git push origin main

# Pull changes
git pull origin main

# Fetch changes
git fetch origin
```

## Branching
```bash
# List branches
git branch

# List all branches (local and remote)
git branch -a

# Create branch
git branch feature-branch

# Switch branch
git checkout feature-branch
git switch feature-branch

# Create and switch
git checkout -b feature-branch
git switch -c feature-branch

# Delete branch
git branch -d feature-branch
git branch -D feature-branch  # Force delete

# Rename branch
git branch -m new-branch-name
```

## Merging and Rebasing
```bash
# Merge branch
git merge feature-branch

# Rebase branch
git rebase main

# Interactive rebase
git rebase -i HEAD~3

# Abort rebase
git rebase --abort

# Continue rebase
git rebase --continue
```

## Stashing
```bash
# Stash changes
git stash

# Stash with message
git stash save "Work in progress"

# List stashes
git stash list

# Apply stash
git stash apply
git stash apply stash@{1}

# Pop stash
git stash pop

# Drop stash
git stash drop stash@{0}

# Clear all stashes
git stash clear
```

## History and Logs
```bash
# View commit history
git log

# Compact log
git log --oneline

# Log with graph
git log --graph --oneline --all

# Show specific commit
git show <commit-hash>

# Blame file
git blame file.txt

# Search commits
git log --grep="fix bug"
git log --author="John Doe"
```

## Undoing Changes
```bash
# Unstage file
git reset HEAD file.txt

# Unstage all
git reset HEAD

# Discard changes
git checkout -- file.txt

# Reset to commit
git reset --soft HEAD~1  # Keep changes staged
git reset --mixed HEAD~1 # Unstage changes
git reset --hard HEAD~1  # Discard changes

# Revert commit
git revert <commit-hash>
```

## Tagging
```bash
# List tags
git tag

# Create tag
git tag v1.0.0

# Create annotated tag
git tag -a v1.0.0 -m "Version 1.0.0"

# Push tags
git push origin --tags

# Delete tag
git tag -d v1.0.0
git push origin --delete v1.0.0
```

## Collaboration
```bash
# Create pull request branch
git checkout -b feature/new-feature

# Push branch
git push -u origin feature/new-feature

# Fetch and merge
git fetch origin
git merge origin/main

# Pull with rebase
git pull --rebase origin main

# Squash commits
git rebase -i HEAD~3
# Change 'pick' to 'squash' for commits to combine
```

## Advanced Operations
```bash
# Cherry pick commit
git cherry-pick <commit-hash>

# Bisect for bug finding
git bisect start
git bisect bad
git bisect good <good-commit>

# Create patch
git format-patch -1 <commit-hash>

# Apply patch
git apply patch-file.patch

# Submodules
git submodule add https://github.com/user/submodule.git
git submodule update --init --recursive
```

## Configuration
```bash
# Set user name
git config --global user.name "John Doe"

# Set email
git config --global user.email "john@example.com"

# Set default editor
git config --global core.editor vim

# Set default branch
git config --global init.defaultBranch main

# View config
git config --list
```

## GitHub/GitLab Integration
```bash
# Push to GitHub
git push origin main

# Create PR (via web interface or CLI tools)
gh pr create --title "My PR" --body "Description"

# Clone with SSH
git clone git@github.com:user/repo.git

# Set upstream
git branch --set-upstream-to=origin/main main
```

## Best Practices
- Commit often with clear messages
- Use feature branches for development
- Keep main branch stable
- Use pull requests for code review
- Write meaningful commit messages
- Use .gitignore for unwanted files
- Regularly pull and push changes
- Use tags for releases
- Implement pre-commit hooks
- Use git flow or similar branching strategies