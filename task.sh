#!/bin/bash

# Installing Git
echo "Installing Git..."
sudo yum install -y git

# Initializing a Git repository
echo "Initializing the Git repository..."
git init

# Checking if Git service is running (Git doesn't have a service, so this line is optional)
echo "Checking Git installation status..."
git --version  # Verifies Git installation

# Configuring Git user details
echo "Configuring Git user..."
git config --global user.name "pavan"
git config --global user.email "pavantummalapalli253@gmail.com"

# Display Git logs (will be empty initially)
echo "Checking Git logs..."
git log || echo "No logs yet."

# Creating directories and adding notes in each
echo "Creating directories and adding files..."
mkdir -p {feature,release,hotfix}/{main,master}

for dir in feature/main feature/master release/main release/master hotfix/main hotfix/master; do
    echo "Git is installed properly" > "$dir/note.txt"
done

# Adding files to the staging area
echo "Adding files to the staging area..."
git add .

# Committing the staged changes
echo "Committing changes..."
git commit -m "Initial commit with project structure and notes"

# Checking the status and logs
echo "Checking the status..."
git status

echo "Checking the logs..."
git log

# Prompting for the repository URL (Use HTTPS for the URL to include the token)
read -p "Enter the repository URL (e.g., https://github.com/username/repo.git): " url

# Prompt for your GitHub username
read -p "Enter your GitHub username: " username

# Prompt for your Personal Access Token (PAT) - secret
read -sp "Enter your Personal Access Token (PAT): " token
echo
# Check if the URL is valid
if git ls-remote "$url" &> /dev/null; then
    echo "Repository URL is correct."

    # Replace the HTTPS URL with a URL that includes your personal access token
    token_url="https://$username:$token@${url#https://}"

    # Add the remote origin with the token included
    git remote add origin "$token_url"
    echo "Remote repository 'origin' has been added."
else
    echo "Repository URL is incorrect."
    exit 1
fi

# Verifying the remote repository
echo "Checking the remote repository..."
git remote -v

# Generating an SSH key (optional if you're using SSH for future operations)
echo "Generating an SSH key..."
ssh-keygen -t rsa -b 4096 -C "pavantummalapalli253@gmail.com" -f ~/.ssh/id_rsa -N "" -q

# Display SSH public key so it can be added to the remote server (if using SSH)
echo "SSH key generated. Add this public key to your repository's SSH keys:"
cat ~/.ssh/id_rsa.pub

# Prompt user to add the SSH key to the repository before pushing (if applicable)
read -p "Press Enter after you've added the SSH key to your repository's settings..." 

# Check if the 'main' branch exists
if ! git show-ref --quiet refs/heads/main; then
    echo "'main' branch does not exist. Creating it..."
    git checkout -b main  # Create the 'main' branch and switch to it
else
    echo "'main' branch already exists."
    git checkout main  # Switch to the 'main' branch
fi

# Make sure there is at least one commit before pushing
if [[ $(git rev-list --count HEAD) -eq 0 ]]; then
    echo "No commits found. Creating an initial commit..."
    git commit --allow-empty -m "Initial commit"
fi
# Pushing the local repository to the remote repository
echo "Pushing the local repository to the remote repository..."
git push -u origin main || echo "Push failed. Ensure the branch 'main' exists on the remote repository."

