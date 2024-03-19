#!/bin/bash

# Raycast Script Command Template
#
# Dependency:
#
# Duplicate this file and remove ".template" from the filename to get started.
# See full documentation here: https:#github.com/raycast/script-commands
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add New Notion Idea
# @raycast.mode fullOutput
# @raycast.packageName Custom Script Commands New Notion Idea
#
# Optional parameters:

# @raycast.argument1 { "type": "text", "placeholder": "New Notion Idea From Raycast", "optional": false}
# @raycast.argument2 { "type": "text", "placeholder": "Description", "optional": true}}
#
# Documentation:
# @raycast.description Internal Notion Integration
# @raycast.author Liam Ellis
# @raycast.authorURL https://github.com/Monichre


# Replace these variables with your actual integration token and database ID
# NOTION_SECRET=secret_foafg7aBxPOjegjeQTw1VgrvAzbDnTyKqpqxFG0di52

# secret_ndwjNgbob6sTFaclNNzaSn0FOqRLhtdQZSmXbkwzGS9
# Replace the properties below with your actual database properties
# The format depends on your database columns (title, text, etc.)
# This is a simple example adding a page with a title
source .env

date=$(date '+%Y-%m-%d')
json_payload=$(cat <<EOF
{
  "parent": { "database_id": "$DATABASE_ID" },
  "properties": {
    "Name": {
      "title": [
        {
          "text": {
            "content": "${1}"
          }
        }
      ]
    },
    "Date": {
      "date": {
        "start": "${date}"
      }
    }
  }
}
EOF
)

# POST request to Notion's API to create a new database item
curl -X POST 'https://api.notion.com/v1/pages' \
     -H "Authorization: Bearer $NOTION_TOKEN" \
     -H "Content-Type: application/json" \
     -H "Notion-Version: 2022-06-28" \
     --data "$json_payload"
