#!/bin/bash

# ASCII Art for RepoCloner using figlet (optional)
echo "RepoCloner"
echo "----------------------------"
figlet -f slant "RepoCloner"

# Function to extract username from a GitHub link
extract_username() {
    local repo_url=$1
    # Extract the part after 'github.com/' and before the next '/'
    echo "$repo_url" | sed 's|https://github.com/\([^/]*\).*|\1|'
}

# Prompt user to input the GitHub URL
read -p "Enter the GitHub user or organization URL (e.g., https://github.com/username): " repo_url

# Extract the username from the URL
username=$(extract_username "$repo_url")

# Check if username is extracted properly
if [[ -z "$username" ]]; then
    echo "Invalid URL. Please enter a valid GitHub user or organization URL."
    exit 1
fi

# Fetch all repositories and clone them
echo "Cloning repositories from $username..."
curl -s "https://api.github.com/users/$username/repos?per_page=100" | jq -r '.[].clone_url' | xargs -L1 git clone

echo "All repositories cloned successfully!"
