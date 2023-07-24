# NewsHub 

## Overview
- This project is a demonstration of the MVVM (Model-View-ViewModel) architecture pattern using URLSession, SwiftUI, Cache. It showcases how to structure an iOS app using the MVVM pattern to achieve separation of concerns and maintainability.

## Features
- News List: The app displays a list of news stories sorted by their publication timestamps. Users can scroll through the list to discover various articles.
- News Details: Tapping on a news story opens the detailed view, showing the article's headline, byline, abstract, and the main body of the article. It also displays the relevant image associated with the news.
- Image Caching: To enhance performance, the app uses an ImageCache to cache news images. This reduces the need to repeatedly download the same images when navigating through the news list.
- Error Handling: The app handles various potential errors and displays appropriate error messages when something goes wrong during data fetching or decoding.
- Loading Indicator: While fetching news data from the server, a loading indicator is displayed to keep users informed about ongoing data retrieval.
- Network Connectivity: The app checks the device's network connectivity and handles offline scenarios, ensuring that users receive a clear indication when there is no internet connection.
- Unit Tests: The app includes a comprehensive suite of unit tests to ensure the correctness and stability of critical components, such as the API client, data models, view models, and cache.

## Architecture
- This project follows a structured architecture pattern to maintain a separation of concerns and ensure code maintainability. 
- It utilises the Model-View-ViewModel (MVVM) design pattern, where each view has a corresponding view model responsible for handling business logic and data binding. 
- The data models represent the structure of news stories and other entities in the application.

## Components Overview
- View: The View layer consists of SwiftUI views responsible for rendering the user interface. In this project, the NewsListView and NewsRow are two primary views responsible for displaying the list of news articles and individual news details, respectively.
- ViewModel: The ViewModel layer contains classes conforming to ObservableObject and serves as an intermediary between the View and Model layers. The NewsViewModel is the main ViewModel class that handles data retrieval from the service layer and prepares the data for display in the View.
- Model: The Model layer represents the data entities used in the application. It includes NewsStories, News, and NewsImage, which are Swift structs representing the data structure of news articles, individual news details, and associated images.
- Service: The Service layer is responsible for fetching data from an external API or data source. In this project, the NewsService class handles the API communication by utilising the NewsAPIClient, which conforms to the APIClient protocol.
- APIClient: The APIClient protocol defines a common interface for making API requests and fetching data. It includes a method called fetchData that accepts a generic type for decoding the response data.
- ImageCache: The ImageCache class is responsible for caching images fetched from the API to avoid redundant network requests and improve the app's performance. It uses NSCache to store and manage the cached images.

## Testing
- The News App places great emphasis on testing to ensure the reliability and stability of the application. 
- It includes unit tests for various components, such as view models, data models, service classes, and the image caching functionality. 
- The unit tests validate the correct behaviour of individual components and ensure seamless integration with the overall app architecture.
- No unit tests have been added for the user interface (UI) components as the UI is fully implemented using SwiftUI views. Testing SwiftUI views requires third-party automation testing tools, and setting up such testing can be a complex and time-consuming task.

## Compatibility
- The News App is designed to run on iOS devices running iOS 14 and later versions.
