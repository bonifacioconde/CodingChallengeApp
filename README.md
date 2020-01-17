
CodingChallengeApp Project
================

## Description
This application displays a list of items obtained from a iTunes Search API and will show a detailed view for each item. Fetching is controlled by the Time set to fetch new data. If last fetched is within time set, fetched only locally if not fetch from API.


## Persistence
This time i used Realm library to persist data. Not so complicated and easy to manage whenever we willl be having some need for updates.


## Architecture
I used this as this as to separate responsibilites of Displaying UI and making API request. Its also flexible when we will add new features we can add or reuse existing funtionalites. The MVVM currently writted is not the pure approach is it relies on Closured to have updates on UI sides. 
