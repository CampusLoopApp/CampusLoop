# Campus Loop

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Campus Loop is an app that allows college students to buy/sell dorm/apartment furniture and school spirit-themed products. Additionally, the app allows students to advertise upcoming events.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social
- **Mobile:** A mobile format makes the app easy to use. Users can take pictures of their furniture or school spirit-themed products and post them easily. Additionally, events can be advertised by location and students can easily invite their friends to events through a mobile platform.
- **Story:** This app makes it easier to navigate campus and allows for easier communication and stronger connections amongst students
- **Market:** Any college campus could use this app. Students from that college would use the app to connect.
- **Habit:** Students can check the app daily for upcoming events and also make extra money by selling furniture/products/etc.
- **Scope:** The app will first focus on only MSU's campus. Students will be able to share events and sell products. Later, the scope could be expanded to the student body of any college and features such as messaging could be added.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can log in/log out
* User can create an account
* User can post a photo to their feed (access Camera Roll and Photo Library)
* User can comment on posts from other users 


**Optional Nice-to-have Stories**

* Trending page
* Messaging feature
* Users can share their location
* Profiles and user ratings/reviews

### 2. Screen Archetypes

* Login / Sign Up Page
   * User can log in
   * User can create an account
* Profile
   * User can check their posts and ratings received from other users
* Marketplace Feed
    * User can post a photo to their feed
    * User can comment on posts from other users 
* Events Feed
    * User can post a photo to their feed
    * User can comment on posts from other users 
* Creation
    * User can write a post
    * User can access camera roll to post a picture

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Profile (creation button from here)
* Marketplace Feed
* Events Feed

**Flow Navigation** (Screen to Screen)
* Login
   * Submit button
* Profile
   * Creation button
* Creation Screen

## Wireframes
* Login Screen
<img src='https://www.linkpicture.com/q/Login.jpg' width=300>
* Profile Screen
<img src='https://www.linkpicture.com/q/Profile.jpg' width=300>
* Feeds Screen
<img src='https://www.linkpicture.com/q/Feeds.jpg' width=300>
* Creation Screen
<img src='https://www.linkpicture.com/q/Creation.jpg' width=300>

### [BONUS] Interactive Prototype

## Schema 
### Models
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | image         | File     | image that user posts |
   | caption       | String   | image caption by author |
   | commentsCount | Number   | number of comments that has been posted to an image |
   | likesCount    | Number   | number of likes for the post |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
   | comments      | String   | comments |
   | price         | Double   | price of item sold |
   | location      | Coordinates   | coordinates showing location of product sold or event |
### Networking
#### List of network requests by screen
   - Home Feed Screen
      - (Read/GET) Query all posts where user is author
         ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
      - (Create/POST) Create a new like on a post
      - (Delete) Delete existing like
      - (Create/POST) Create a new comment on a post
      - (Delete) Delete existing comment
   - Create Post Screen
      - (Create/POST) Create a new post object
   - Profile Screen
      - (Read/GET) Query logged in user object
      - (Update/PUT) Update user profile image

## Progress GIF
## Milestone 10 GIF
![](https://i.imgur.com/RXE00MH.gif)

## Milestone 11 GIF
![](https://i.imgur.com/RXE00MH.gif)

## Milestone 12 GIF
![] (https://recordit.co/oXll3ehHA5.gif)

## Completed Milestone 10 User Stories
[x] User can see a stylized load screen

[x] User can switch between multiple feeds/screens using button bar items

[x] User can see a stylized app icon


## Completed Milestone 11 User Stories

[x] User can make a post

[x] User can see a feed of relevant campus events

[x] User stays logged in (note that the user is logged in when the app opens - unlike in last week's gif, where they were directed to a login screen

## Completed Milestone 12 User Stories

[x] User can add profile picture

[x] User can change bio

[x] User can see feed of their own posts under their profile

[x] User can see a feed of relevant campus items being sold

[x] User can log out
