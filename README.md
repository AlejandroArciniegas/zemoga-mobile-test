
[![Swift Version][swift-image]][swift-url]


# Zemoga iOS Mobile Test

  This app was designed and built around Uncle Bob's Clean Code and Clean Architecture Paradigm, here the VIPER(View Interactor Presenter Entity Router) Pattern. Isolate responsabilties allowing us to have different data sources and entities, modify them or extend them  without  modifiying the logic or UI layer of the app. There's place for refactoring but for the purpuse of this test and the time frame I decided to keep it simple and understandable
    
   The main Modules are PostsListModule and PostDetailModule which contain the logic, ui and data communication layers for each module. Then we have entities which are the models such as Post, User and Comment. The DataModel is a class that contain the methods to retrieve the data from the different sources or entities and provide to the presenter and interactor. This easily could be the data layer gateway. If we needed to separate the data logic for each module we could easily do so with this project architecture. There's always place for improvement and having the responsability of each component of the VIPER architecture makes the project sustainable and easy to debug.
    
   For caching the posts I decided to go with file storage in JSON format, as the data is publicly available there are no security corncerns, nontheless the file is stored under the .userDomainMask, it has the same structure of the response from the API so the entities could code and decode the data easily.
    
  The only third-party library is Refreshable, is a SwiftUI Component Extension that was introduced natively in iOS 15.0 but ist not available in iOS 14.0. It's used for the pull down to refresh feature.
  
  Unit Testing should follow the best practices starting for the acronym FIRST, fast, independent, repeatable, self-validating, timely.
  In this project we are using Combine which is a "Customize handling of asynchronous events by combining event-processing operators."
which further helps with the Clean Architecture Proposed by the VIPER Pattern. 

To unit test Combine it was necessary to creat an extension, in order to wait for the data to be asynchronously retrieved. For the time I had and nature of the project I've only added a test for loading the default post. 

## Features
- [x] Local Posts are loaded first, to load post from the API drag the screen down 
- [x] Load post, post details, user and comments from JSONPlaceHolder 
- [x] Cache List of Posts
- [x] Delete Individual Post
- [x] Delete All Post (including favorites)
- [x] Favorite Post are sorted to the top or display on individual "favorites tab"

## Requirements

- iOS 14.0+
- Xcode 13.3.1

## Installation

#### Basic Installation
1. Clone
2. Run on Physical Device or Simulator iOS 14.0+

## Meta

Alejandro Arciniegas – [@alejandroarciniegas.dev](https://www.instagram.com/alejandroarciniegas.dev/) – alejandroarciniegasf@gmail.com



[swift-image]:https://img.shields.io/badge/swift-5.0-green.svg
[swift-url]: https://swift.org/
