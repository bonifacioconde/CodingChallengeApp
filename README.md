
CodingChallengeApp Project
================

## Description
This application displays a list of items obtained from a iTunes Search API and will show a detailed view for each item. Fetching is controlled by the Time set to fetch new data. If last fetched is within time set, fetched only locally if not fetch from API.


## Persistence
This time i used Realm library to persist data. Not so complicated and easy to manage. It also supports data migration whenever we will have some changes on our model classes.


## Architecture
I used MVVM as this as to separate responsibilites of Displaying UI and making API request. Its also flexible when we will add new features we can add or reuse existing funtionalites. The MVVM currently writted is not the pure approach is it relies on Closured to have updates on UI sides. 

## Unit Tests
Used Quick and Nimble libraries to help me do Unit test cases of my classes 
