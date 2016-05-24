CMPE 277 Lab 3 

Introduction

In this lab, you build a native iOS app that supports searching for restaurants and pinning for favorites. Instead of building your own server and implementing the search API, you integrate with Yelp through its search API.  The app will have features matching what we required for the Android app in lab 2, but with a few extra features for bonus points. You must use either Objective-C or Swift. The lab is group based, and the group needs to be the same as the term project. For this particular project, you are discouraged to use StoryBoard or Interface Builder, as they are very likely to introduce compilation issues for grading purpose.
Requirements
Your app can use either side navigation (navigation drawer) or tab navigation (tab bar navigation controller) to support the two major screens: Search and Favorites. Your app must also support ancestral navigation for screens to navigate back to the root screens.
Search Screen
This is the default and landing screen for your app. In the top of the screen, you will have a search box, a location picker, and a search button. Feel free to use the Yelp ios app as a reference for your implementation.
1.	The user can type in whatever keywords in the search box.
2.	Pressing the location picker button starts a place picker dialog to let the user pick a location. You can continue to use the Google Place Picker for iOS, or anything similar. The picked location should always be shown in your location picker.
3.	Pressing the search button triggers a search for restaurant with the given keywords at the given location. You must use the category for all restaurants,  set the radius of 10 miles, and limit the results to 20 maximum.
4.	The user must be able to sort the results by relevance or distance. It is fine to trigger a new search when the user changes the sort order. 
5.	The search results view occupies most of the search screen. The view consists a list of search results. 
6.	Each search result entry should contain the image icon, business name, rating, and address
7.	The view must allow the user to scroll up and down when the results go beyond a single screen. You are welcome to use endless scroll to avoid paging, even though are are only up to 20 results.
8.	Press any result entry switches to the restaurant details screen.
Detail Screen
9.	A restaurant details screen shows the details of the given restaurant, including business name, rating, count of reviews, address with a static map, phone number, and snippet as returned in the search API. 
10.	It must also contain a heart icon (either empty or solid red) close to the top right of the screen. Pressing the heart icon switches its state between empty and solid red. A solid red heart marks the current restaurant as a favorite.
11.	Pressing the app icon goes back to the search results screen (or Favorite Screen, if it’s navigated from there). 
Favorite Screen

12.	This screen is almost identical as the search results screen, except that 
a.	It only shows the restaurants that are marked as a favorite.
b.	There are no sorting options.  
13.	The favorites should be stored locally (user defaults, CoreData, or SQLite). Stop the app and start again should see the favorites unchanged.
Bonus Features
You can get bonus points for the following additional features
14.	Swiping through the restaurant details pages: support swipe left and right on the restaurant detail page to navigate through the search results (or favorites). Make sure the back button works differently from the up button in this case.
15.	Tablet optimization: merge the search results and restaurant detail into a single screen in landscape mode on larger tablets.
16.	Google Street View integration. In the detail screen, you can have a button below the static map for Google Street View, clicking on which triggers the street view at this address.
