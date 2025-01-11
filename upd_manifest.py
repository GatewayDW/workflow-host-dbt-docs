"""
This script updates the 'manifest.json' file in a dbt project.
To test the result:
    1. Run 'dbt docs generate'
    2. Run 'python /home/src/mage/dbt/ab_gaming/upd_manifest.py'
    3. Run 'dbt docs serve'
    4. Verify that the 'Last Updated At UTC' field is updated in the dbt docs overview.
"""
import json
import re
import os

# Extract the release tag from the GITHUB_REF environment variable
github_ref = os.environ.get("GITHUB_REF", "")
github_event_name = os.environ.get("GITHUB_EVENT_NAME", "N/A")

# https://docs.github.com/en/actions/learn-github-actions/variables
# The ref given is fully-formed, meaning that for branches the format is refs/heads/<branch_name>,
# for pull requests it is refs/pull/<pr_number>/merge,
# and for tags it is refs/tags/<tag_name>.
branch_name = (
    github_ref.split("/")[-1] if github_ref.startswith("refs/heads/") else "N/A"
)
pr_number = github_ref.split("/")[-2] if github_ref.startswith("refs/pull/") else "N/A"
release_tag = (
    github_ref.split("/")[-1] if github_ref.startswith("refs/tags/") else "N/A"
)

# Specify the path to your manifest.json file
manifest_path = "target/manifest.json"

# Read the manifest.json file
try:
    with open(manifest_path, "r") as manifest_file:
        manifest_data = json.load(manifest_file)

except Exception as e:
    print(f"Error reading manifest file: {e}")
    exit()

# Define the regex pattern to match the desired block key
block_key_pattern = re.compile(r"^\s*doc\.[^\s]*\.__overview__\s*$")

# Extract generated_at from metadata
metadata_generated_at = manifest_data.get("metadata", {}).get("generated_at", "")

if "docs" in manifest_data:
    for key, block in manifest_data["docs"].items():
        if block_key_pattern.match(key):
            new_generated_at = metadata_generated_at

            block_contents = block.get("block_contents", "")
            print(f"Existing block_contents for key {key}:\n{block_contents}")

            # Remove existing "Generated_at" line
            block_contents = re.sub(
                r" Last Updated At UTC : .*$", "", block_contents, flags=re.MULTILINE
            )

            # Add the release tag to the block_contents
            updated_block_contents = (
                f" Last Updated At UTC : {new_generated_at} (Created by event: {github_event_name}) || "
                + f" Release Tag: {release_tag} || "
                + f" Branch Name: {branch_name} || "
                + f" PR Number: {pr_number}\n\n"
                + f"{block_contents}"
            )
            block["block_contents"] = updated_block_contents

            with open(manifest_path, "w") as manifest_file:
                json.dump(manifest_data, manifest_file, indent=2)

            break
    else:
        print("Block not found in the manifest.")