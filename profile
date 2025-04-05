import requests
import base64
import os

# GitHub credentials
GITHUB_TOKEN = "ghp_abc123456789xyz"
GITHUB_USERNAME = "mithun-kumar-l"
REPO_NAME = "my-image-repo"

# Local file path
LOCAL_FILE_PATH = r"C:\Users\User\Desktop\New folder\rai\mithun\New folder\Photo.jpg"  # Change the filename if needed
FILE_NAME = os.path.basename(LOCAL_FILE_PATH)  # Extract filename

# GitHub repository file path
GITHUB_FILE_PATH = f"uploads/{FILE_NAME}"  # Change 'uploads/' if you want another folder

# GitHub API URL
URL = f"https://api.github.com/repos/{GITHUB_USERNAME}/{REPO_NAME}/contents/{GITHUB_FILE_PATH}"

# Read the file and encode it in base64
with open(LOCAL_FILE_PATH, "rb") as file:
    content = base64.b64encode(file.read()).decode()

# Prepare the data for the API request
data = {
    "message": f"Uploading {FILE_NAME}",
    "content": content
}

# Make the request to upload the file
response = requests.put(
    URL,
    json=data,
    headers={"Authorization": f"token {GITHUB_TOKEN}", "Accept": "application/vnd.github.v3+json"}
)

# Print response
if response.status_code == 201:
    print("File uploaded successfully!")
    print("File URL:", response.json()["content"]["html_url"])
else:
    print("Error:", response.json())
