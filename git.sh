#!/bin/bash

# Install Git
echo "Installing Git..."
sudo yum install -y git

# Initialize the Git repository
echo "Initializing the repository..."
git init

# Configure Git
echo "Configuring Git..."
git config --global user.name "pavan"
git config --global user.email "pavantummalapalli253@gmail.com"

# Create a project structure
echo "Setting up project directories..."
mkdir -p {feature,release,hotfix}/{main,master}

for dir in feature/main feature/master release/main release/master hotfix/main hotfix/master
do
    echo "Git is installed properly" > "$dir/note.txt"
done

# Create a clean commit history (orphan branch)
echo "Creating an orphan branch for a clean commit history..."
git checkout --orphan temp-branch

# Add all files to the orphan branch and commit them
echo "Adding files to the staging area..."
git add .
echo "Committing changes..."
git commit -m "Initial commit with project structure and notes"

# Rename orphan branch to 'main'
echo "Renaming branch to main..."
git branch -M main

# Prompt for the repository URL (Use HTTPS for the URL to include the token)
read -p "Enter the repository URL (e.g., github.com/username/repo.git): " url

# Prompt for GitHub username
read -p "Enter your GitHub username: " username

# Prompt for Personal Access Token (PAT)
read -sp "Enter your Personal Access Token (PAT): " token
echo                   

# If remote "origin" already exists, update it; otherwise, add it
if git remote get-url origin &> /dev/null; then
    echo "Updating existing remote origin..."
    git remote set-url origin "https://$username:$token@$url"
else
    echo "Adding remote origin..."
    git remote add origin "https://$username:$token@$url"
fi

# Verify the remote repository connection
echo "Verifying the remote repository connection..."
git remote -v

# Push the initial commit to the remote repository
echo "Pushing the clean commit history to the remote repository..."
git push -u origin main --force || echo "Push failed. Ensure the branch 'main' exists on the remote repository."

# Prompt for removing specific files
echo "Removing specific files from the repository..."

# Remove specific files or directories from the repository (adjust paths as needed)
git rm --cached path/to/unwanted_file.txt
git rm --cached -r path/to/unwanted_directory

# Commit changes after removing files
echo "Committing changes after removing files..."
git commit -m "Remove unwanted files from repository"

# Push the changes to the remote repository
echo "Pushing changes to remote repository..."
git push origin main

# Optional: Remove all untracked files
read -p "Do you want to delete all untracked files locally? (y/n): " choice
if [[ "$choice" == "y" ]]; then
    echo "Cleaning untracked files..."
    git clean -fd
fi

echo "Files removed and changes pushed successfully."

