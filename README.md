
CodingChallengeApp Project
================

## Description
This application displays a list of items obtained from a iTunes Search API and will show a detailed view for each item.


## Persistence
APICacheRequest class
- Using a string key inorder to locate the JSON response file cached
- Decides on when to use cache or fetch new data

JSONFileCache class 
- Read/Write locally on the device as .json file

## Architecture
- MVVM-Coordinator pattern
- So far this pattern is clean and separates the responsibilities
