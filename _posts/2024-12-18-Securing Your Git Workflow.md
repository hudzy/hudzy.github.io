---
layout: post
title: "Securing Your Git Workflow: Using Pre-Commit Hooks to Prevent Wrong Repos and Sensitive Data"
date: 2024-12-18
tags: [笔记, 工作]
---

# Securing Your Git Workflow: Using Pre-Commit Hooks to Prevent Wrong Repos and Sensitive Data

When managing multiple Git repositories and handling sensitive information, it’s easy to make mistakes. Whether it’s committing code to the wrong repository or accidentally leaking sensitive credentials, these errors can lead to major security vulnerabilities. Fortunately, **Git pre-commit hooks** can automate checks that prevent such issues, improving both security and workflow consistency.

In this post, we'll explore two powerful Git pre-commit hook integrations:

1. **Preventing commits to the wrong repository** by verifying the remote repository URL.
2. **Preventing the accidental commit of sensitive credentials** using **Gitleaks**.

## Section 1: Prevent Committing to the Wrong Repository with Git Pre-Commit Hooks

When working with multiple repositories, it's easy to accidentally push code to the wrong one. Fortunately, Git allows you to set up **pre-commit hooks** to automatically check that the remote repository URL matches an expected pattern before you commit.

### 1. **Set Up the Global Hook Path**

First, create the global Git hook directory and set it to be used for all your repositories:

```bash
mkdir -p ~/.config/git/hooks
git config --global core.hooksPath ~/.config/git/hooks
```

### 2. **Create the Pre-Commit Hook Script**

Now, create the `pre-commit` hook script that will run every time you try to commit:

```bash
touch ~/.config/git/hooks/pre-commit
chmod +x ~/.config/git/hooks/pre-commit
```

### 3. **Add the Repository Validation Script**

Open the `pre-commit` file and add the following script to check the remote repository:

```bash
#!/bin/bash

# List of valid repositories in the form "owner/repo"
VALID_REPOS=("yourusername/valid-repo" "yourusername/another-repo")

# Get the remote URL and extract the "owner/repo" part, regardless of host
REMOTE_URL=$(git remote get-url origin)

# Extract the "owner/repo" part from SSH or HTTPS URLs
REMOTE_REPO=$(echo $REMOTE_URL | sed -E 's|^.*[/:](.*)/(.*)\.git|\1/\2|')

# Check if the remote repo is in the list of valid repos
if [[ ! " ${VALID_REPOS[@]} " =~ " ${REMOTE_REPO} " ]]; then
    echo "Error: Invalid remote repository: ${REMOTE_REPO}"
    echo "Allowed repositories are:"
    for repo in "${VALID_REPOS[@]}"; do
        echo "- $repo"
    done
    exit 1  # Prevent the commit
fi

echo "Valid repository. Proceeding with commit..."
```

### 4. **Test the Hook**

Now, whenever you commit, the script will ensure that the `owner/repo` in your remote URL matches one of the allowed repositories. If it doesn’t match, the commit will be blocked with an error message:

```bash
Error: Invalid remote repository: abc/invalid-repo
Allowed repositories are:
- yourusername/valid-repo
- yourusername/another-repo
```

## Section 2: Prevent Committing Sensitive Credentials with Gitleaks

Another major issue developers face is the accidental committing of sensitive information, like API keys or passwords. **Gitleaks** is an open-source tool that scans Git repositories for secrets, and you can integrate it with Git pre-commit hooks to prevent such leaks before they happen.

### 1. **Install Gitleaks**

**For macOS**:
```bash
brew install gitleaks
```

**For Windows**:
Follow the instructions on the [Gitleaks GitHub page](https://github.com/gitleaks/gitleaks?tab=readme-ov-file#getting-started).

### 2. **Set Up the Global Hook Path (if not already done)**

If you haven't set up the global Git hook path yet, do so with:

```bash
mkdir -p ~/.config/git/hooks
git config --global core.hooksPath ~/.config/git/hooks
```

### 3. **Create the Pre-Commit Hook Script for Gitleaks (if not already done)**

Create the `pre-commit` hook script and make it executable:

```bash
touch ~/.config/git/hooks/pre-commit
chmod +x ~/.config/git/hooks/pre-commit
```

Then, open the `pre-commit` file and add the following script to integrate **Gitleaks**:

```bash
.... # Script from section 1

# Run Gitleaks to scan for sensitive data
echo "Running Gitleaks to scan for credentials..."

gitleaks git --pre-commit --no-banner --staged

if [[ $? -ne 0 ]]; then
    echo "Error: Commit contains sensitive information. Please remove the credentials before committing."
    exit 1  # Prevent the commit
fi

echo "No sensitive data found. Proceeding with commit..."
```

This updated script ensures:
- **Repository validation** to make sure you’re committing to the correct repository.
- **Sensitive data detection** with **Gitleaks**, scanning staged changes for any secrets.

### 4. **Test the Hook**

Now, every time you try to commit, the pre-commit hook will:
- Check that the `owner/repo` in your remote URL is valid.
- Run **Gitleaks** to scan for sensitive credentials.
If either of these checks fail, the commit will be blocked with an error message.

## Conclusion

By integrating these two **Git pre-commit hooks**, you can enhance the security of your repositories and your development workflow:
- **Prevent committing to the wrong repository** by automatically validating the repository URL.
- **Prevent committing sensitive credentials** by scanning staged changes for secrets using **Gitleaks**.

With these tools in place, you can be confident that your Git workflow is more secure and that sensitive data won’t make it into your repository history.