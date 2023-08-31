Original App Design Project - CodePath Final Project
===

# PathPioneer

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Allows users to map trails they walk on, and refer to previous maps. Also allows users to share maps with other users and view maps submitted to the app by other users. 

### Final Preview
<img src="https://github.com/trail-social-media/tsm/blob/main/FinalPreview.gif">

### App Evaluation
- **Category:** Social Network / Navigation
- **Mobile:** This app would only really make sense on mobile, because you can't bring your computer around with gps to map out a trail. However, there could be a website where you could view trails
- **Story:** Allows users to map out trails that aren't shown on popular map apps and share them with other users
- **Market:** Hikers that are out in nature a lot would find this app useful, people of any age that enjoy spending time outdoors
- **Habit:** This app can be used whenever the user wants to hike on a trail that's unmapped or use their previous maps to rehike a trail
- **Scope:** This app can start out as a way for people to store their hiking trails to refer back to later or share with others. Once enough people start using the app, we can expand the social networking abilites of the app so that hikers can interact with people all around the world.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create a new account
* User can login
* User can create a new trail
* User can save a trail
* User can see their trails on a map
* User can see other people's trails on a map
* User can see a list of trails and select which ones to show

**Optional Nice-to-have Stories**

* User can comment on trails
* User can see someone's profile and what trails they mapped
* User can upload a thumbnail for the trail
* User can click on the thumbnail to see detailed information

### 2. Screen Archetypes

* Login
   * User can login
* Registration
   * User can create a new account
* Main Screen
    * User can see their trails on a map
    * User can see other people's trails on a map
    * User can click on the thumbnail to see detailed information
* Trail Detail Screen
    * User can comment on trails
* List Screen
    * User can see a list of trails and select which ones to show
* Creation Screen
    * User can create a new trail
    * User can save a trail
    * User can upload a thumbnail for the trail

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Screen
* Account/Settings

Optional:
* Feed Screen

**Flow Navigation** (Screen to Screen)

* Login/Registration screen->Main Screen
* Main Screen->Creation Screen
* Main Screen->Task Detail Screen
* Main Screen->List Screen
* Account/Settings->Profile/Logout

Optional:
* Feed Screen->Post Screen

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://i.imgur.com/5C6OuOg.png" width=600>

## Sprint #1 
- [x] Create the required/necessary screens
- [x] Add the appropriate navigation functionality to the screns
- [x] Begin implementing the coding required to use the Map for creating trails

First Sprint Progress:
We created the main screens that are necessary for the app (The maps and table views are not visible in this GIF since we don't have data for them yet)
<img src="https://github.com/trail-social-media/tsm/blob/main/Sprint%231.gif">


## Plan for Sprint #2
- [ ] Finish implementing the ability for users to create map trails
- [ ] Create the table views required for the app
- [ ] Finish implementing most required features, ideally all of them
- [ ] Start working on the setting up the backend server connection for the app
- [ ] Start working on the optional features if possible

Second Sprint Progress:
- [x] Added Login and Signup network requests
- [x] Create the table views required for the app
- [x] Map now simulates live location data
- [x] Started working on the setting up the backend server connection for the app
- [x] Started working on the optional features if possible
<img src="https://github.com/trail-social-media/tsm/blob/main/Sprint%232.gif">

## Final Plan
- [ ] Create routes using the live location data
- [ ] Finish working on saving user trails to the server
- [ ] Finish working on fetching user trails from the server
- [ ] Add the social media feature of the app if possible


## Schema 
[This section will be completed in Unit 9]
### Models
| User | Trail |
| --- | --- |
| Username | Trail name|
| Email | Trail Description |
| Password | Trail locations |
| Profile Picture | Trail Picture |

### Networking
- Login Screen
  * Username and password sent to server for login verification
  * Done using User.login
- Sign Up Screen
  * New Username, email, and password are sent to the server for creating new account
  * Done using newUser.signup
- Trail Creation Screen (NOT DONE YET)
  * Save trail to server 
  * Will be done using trail.save
- Trail Table View Screen
  * User's saved trails' information is requested
  * Done using query.find
- Account/Settings screen
  * User's information and profile picture are fetched
  * Done using query.find
- [OPTIONAL: List endpoints if using existing API such as Yelp]
