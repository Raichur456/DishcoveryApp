Addressing A Human Need
According to FARE, the Food Allergy Research and Education Institution, 33 million Americans suffer from food allergies. As of 2025, the current US population is about 342 million, which makes just under 10% of the population susceptible to having negative reactions to specific foods. FARE also mentioned that roughly 51% of adults with food allergies and 42% of children with food allergies have experienced a severe reaction. With the use of technology and food databases at our disposal, there is no reason for millions of Americans to be afraid of eating food on a daily basis. This need must be addressed to prevent many others from having allergic reactions. 


The app we decided to review that could conceptually fit these needs was Spokin by Spokin, Inc. (only available on iOS). The fact that this app is only available on iOS already means that it is not as widely available as it should be. Access to potentially life-saving information should have no kinds of restrictions, such as the kind of cellular device that you are running. Upon entering the app, there were many fantastic features, such as being able to give restaurants a review, follow users, and like certain posts. There was also a feature to only display posts close to your current area. However, some aspects of this app left a lot to be desired. A simple barcode scanner to scan whether or not some food item is good for you would be very helpful for people with allergens that do not wish to eat out that often, but still want that sense of community that Spokin gives. 

Sources: 

Facts and Statistics - FoodAllergy.org
Accidental Reactions to Foods: Frequency, Causes, and Severity - PMC
SPOKIN
README

About This App

We built Dishcovery with the purpose of making it easier for people with certain dietary restrictions to find food that meets their needs. In order to do this, we have users fill out what kind of dietary restrictions they have, and run comparisons to various other foods or dishes with this information. This can be via comparing dish allergens with our own allergens when looking at restaurants, or scanning a barcode, which returns whether or not a certain food is safe for you to consume. 

Build Instructions

Clone the repository with Git: 
https://gitlab.cs.washington.edu/cse-340-2025-fall-students/final-dgpagdar-juvens-akashtn-gururaj.git
cd dishcovery
Install the relevant Flutter Dependencies : 
Camera permissions are needed as well. In Info.plist, type in: 
<key>NSCameraUsageDescription</key>
   <string>This app uses the camera to scan barcodes on food packages.</string>

flutter pub get

Make sure to configure Firebase: 
flutterfire configure

Run the app:
iOS:
flutter run -d ios
Android:
flutter run -d android

Requirements


Project Layout

lib/config folder
Contains mock data used for the app’s HomeView. Our original implementation of the app had it using restaurants found from Yelp, but the help did not adequately provide the dishes and their ingredients. As a result, we had to shift to creating and using our own mock data. This is found in the file “irl_mock_data.dart” and it shows popular restaurants around Seattle’s UDistrict. There is also a backup “mock_data.dart” which was supposed to run if fetching from the Yelp API ended up failing. 

lib/db folder
Contains data about the database to save allergens and favorite restaurant data. Functionality had to be added to save a List of Strings in Drift. allergen_database.dart.dart stores them both. allergen_database.g.dart is the resulting database from running “flutter pub run build_runner build --delete-conflicting-outputs”. 

lib/models folder
Contains two classes used throughout the entire project: dish. dart and restaurant. dart. A Dish object consists of an ID, a restaurant ID tying it back to the restaurant it belongs to, a name, a price, an image URL to be displayed via the app, a list of allergens it contains, and a list of allergens it does not contain. 

A Restaurant object consists of an ID, a name, a description, an image URL, a rating, and a list of dishes that it has. 

lib/providers folder
Contains the food_api.dart file. This file works in conjunction with the OpenFoodFacts API to retrieve food data based on the barcode that was scanned. The http. dart package is imported to make HTTP requests and parse data returned from the API. 

lib/screens/auth folder
Contains the files login_view.dart and signup_view.dart. Both work with the Firebase authentication services to make logging in and signing up possible.

lib/screens/barcode folder
Contains the files barcode_scanner_page.dart and ingredient_result_page.dart. barcode_scanner_page.dart imports from the allergen database and the mobile scanner to be able to scan a barcode, and then retrieve the item that the barcode is associated with from the FoodAPI, which sends an HTTP fetch request to the OpenFoodFacts API. ingredient_result_page.dart displays all of the collected data associated with this request; it displays the ingredients if found, and whether or not the scanned item is safe for the user’s consumption, and displays whether or not the ingredients shown are safe for the user to eat as well. 

lib/screens/favorites folder
This folder contains the files draggable_favorite_restaurant_card.dart and favorites_view.dart. draggable_favorite_restaurant_card.dart adds the functionality of being able to swipe a restaurant card in the Home view right to favorite it, or swipe left to unfavorite it. It also has onTap functionality to open the Restaurant view. favorites_view.dart contains the functionality to view a user’s favorite restaurants, delete them, or undo/redo their deleting actions. 

lib/screens/home folder
Contains the files dish_view.dart, home_view.dart, and restaurant_view.dart. dish_view.dart displays the restaurant’s dishes as a ListView after the restaurant is tapped into. home_view.dart represents the home view the user sees after logging in. From the navigation bar at the bottom, they can access most parts of the app from this screen. restaurant_view.dart constructs a ListView of all of the restaurants available to the app, and displays information about each restaurant, such as its name, rating, description, etc. 

lib/screens/landing folder
Contains two files: about_view.dart and landing_view.dart. landing_view.dart displays different options for the user to choose from; logging in, signing up, or reading about the Dishcovery app. about_view.dart gives information about why Dishcovery was built in the first place and how it is relevant in today’s society. 


lib/screens/settings folder
Contains the files edit_allergens_page.dart, password_view.dart, profile_view.dart, and settings_view.dart. At the highest level of this tree is settings_view.dart, which displays tappable buttons that reroute the user to change their password, edit their allergens, view their profile, or sign out. password_view.dart prompts the user to edit their password if need be. edit_allergens_page.dart prompts the user to select allergens relevant to their dietary restrictions from tappable checkmark widgets. When clicking profile_view.dart, user details such as the user’s name and their email address are displayed.


lib/services folder

Contains the files firebase_auth_services.dart, auth_gate.dart, and yelp_service.dart. The firebase_auth_services.dart file handles Firebase authentication logic, providing methods to allow for user registration and login. The auth_gate.dart file manages the authentication state and directs users to the appropriate screen based on their login status. Finally, the yelp_service.dart file, while not implemented in our application, would handle API calls to Yelp for restaurant data. The reason behind this is that the cost of accessing restaurant data was extremely expensive, nearly 300 dollars per month, and did not provide any dish data, which would contradict the purpose of our application. 


lib/utils folder

Contains the favorite_manager.dart file, which stores, adds, removes, and replaces restaurants that are favorited by the user in memory. It is used extensively throughout the application to manage the favorites state and data persistence. 

lib/app.dart

This file serves as the main widget for dishcovery. It defines the overall app structure, provides the root MaterialApp widget,  and contains navigation routes to all major screens (landing, login, signup, etc.).

lib/firebase_options.dart

This file configures Firebase for dishcovery. It contains the specific settings for the Firebase configuration, such as the API key or the project ID(s), generated by the FlutterFire CLI. It is used to initialize Firebase in main.dart and links the app to the correct Firebase project to ensure proper authentication and data storage.

lib/main.dart

This file serves as the entry point for dishcovery. It initializes Firebase using firebase_options.dart and sets up the root widget and navigation routes for dishcovery. Additionally, it handles initial app launch and directs users to the landing page.



Data Design and Data Flow
Data Design

	User Data

	
	Stored in:

Firebase Authentication
IT stores the users email and password securely
It handles:
- Account creation
-users logging in and out
-Persistent sessions(auto logging occurring)
 

Local Drift Database:
It saves the users allergens
It stores the users favorite restaurants offline
Make sure the data’s synced which will allow favorites 
 
Restaurant Data:
 Uses mock restaurant data 
The data was parsed into restaurant and dish models and compared against the user’s saved allergens

Data Flow

For the Dishcovery project, our group implemented the data flow in such a way that connects user input, local storage, authentication, and external data sources in a straightforward way. When the app launches, the AuthGate listens to the Firebase Authentication and decides whether to show either LoginView or HomeView. When a user logs in, their authentication state comes from the Firebase Authentication, while the allergen preferences are stored in the AllergenDatabase. This essentially allows us to save sensitive data in the cloud, where it's used to check if a user has a preexisting profile.

On the home screen, the mock restaurant data is transformed into Restaurant models. These models are then passed into the HomeView and DishView, where we compare each restaurant and dish against the user's saved allergens. The Favorites also follow a similar pattern where they tap the favorite button, and the in-memory FavoritesManager is updated. For barcode scanning, FoodFinderAPI was used for fetching all the ingredients in a food product, which was then checked against the user's allergens and returned a safe or unsafe result.
Reflection
Works Cited

Flutter classes/packages viewed: 

MaterialApp, Scaffold, AppBar, TextFormField, TextField, IconButton, ListView, GridViewCard, ListTile, Navigator, FutureBuilder, Padding, Column, Row, Expanded, ClipRRect, Image, Icon, ElevatedButton, TextButton, CircularProgressIndicator, StatefulWidget, StatelessWidget

Flutter Drift documentation:

https://github.com/d-wolf/flutter_drift_samples/blob/c3dce9fb3985c954896c521ba71c3192ed53621f/02_drift_self_ref_table/lib/data/datasources/app_database.dart

https://github.com/r1n1os/drift_local_database_example_using_drift_file/blob/756ffc0ac3722f9e369cd9c67054926252001d22/lib/data/local_database/app_database.dart

https://drift.simonbinder.eu/setup/

JSON parsing using Drift: 

https://stackoverflow.com/questions/77061025/saving-liststring-in-flutter-using-drift-database

Audit changes provided by Group 7 (Cinderella) members Ailsa Chen and Donara Galstyan

Mobile scanner use and documentation: 

https://pub.dev/packages/mobile_scanner

https://gist.github.com/shekohex/d96e9bf27e6adbd75281736d2ddd169e

Flutter HTTP package use: 

https://pub.dev/packages/http

https://blog.logrocket.com/networking-flutter-using-http-package/

https://github.com/hamidhosen42/Flutter-REST-API/tree/main/lib/Get_API

Use of the Transform widget:

https://api.flutter.dev/flutter/widgets/Transform-class.html

https://github.com/md-siam/widget_of_the_day/blob/master/lib/37_transform/transform.dart

Use of FlutterFire Firebase Packages
https://firebase.flutter.dev/
Yelp Developers. Yelp Fusion API Documentation.
https://business.yelp.com/
Yelp API Key: '6coyp3JN9haEf0uunBnuud8HDvEwMYZpGDQH5JT3YyotYm-KLeach-IvXUszyhgsd2XeLCnpJjHw-WL8jUXIR7yVoAnGVV0E11q2TVTAx_gOE0DS9Y6q6LWmt3oraXYx';
Firebase Authentication for Flutter documentation.
https://firebase.google.com/docs/auth
Google APIs Flutter Docs
https://docs.flutter.dev/data-and-backend/google-apis



Identify which of the course topics you applied (e.g., secure data persistence) and describe how you applied them. In addition to the list of topics enumerated above, you must also describe how your app design reflects what you learned about the design principles we discussed in our Inclusive Design lecture (Lecture 9: Designing for Accessibility)

The five main course topics that we applied to Dishcovery included accessing phone sensors, querying web services with APIs, Gesture Detection, Undo and Redo, and Data Persistence. The phone sensors were accessed with the barcode scanner, as it required the use of the phone’s rear-facing camera to detect and read barcode labels. Also, with the barcode scanner implementation, we used the scanned barcode to retrieve ingredients from the OpenFoodFacts API. Gesture Detection was primarily used in the draggable_favorite_restaurant_card.dart file, which used onPan update and onPan end to determine whether a restaurant should be added to favorites or removed from favorites. This was done by swiping right on the widget to add it, and swiping left to remove it. Undo and Redo were implemented within the favorites_view.dart file. If a user were to remove a restaurant by accident, they could easily undo that action. But then they could also redo the action of deleting that restaurant if need be. Data Persistence was implemented using Drift in the allergen_database.dart folder. The data that we saved from the user included the allergens they selected and the favorite restaurants (as the restaurant IDs). Some of the design tips we took into account from lecture 9 included making the contrast high enough and making UI changes visually visible. As an example, one of the responses to our peer audit included the text returned to us with the ingredient_result_page.dart blends in with the background too much, which could make this portion of the view difficult to read for some people. The changes we made in response to this were picking a more neutral text color, black, that contrasts enough with the background to be easily readable. We also implemented our app to be easily adjustable in both portrait and landscape settings. As a group, we discussed when certain buttons seemed too small and, by extension, hard to tap on, so changes were constantly being made during the building process of Dishcovery. 

Discuss how doing this project challenged and/or deepened each of your understandings of these topics.

Our understanding of accessing phone sensors was certainly deepened. I do not recall an assignment within the class that involved the use of the phone’s camera, so this definitely took hours and hours of reading documentation to understand. Querying web services was yet another topic that took very long to understand, especially since this API required Flutter libraries such as HTTP to fetch data from OpenFoodFacts, on top of the knowledge gained from using mobile_scanner to scan for barcodes. Gesture Detection was relatively straightforward compared to the other two previously mentioned topics, as there was a lot of practice done within class and in assignments such as Drawing relating to onPan. However, the use of the Transform object to slide the widget was new for me. Undo and redo were simple at first, but were made more challenging when we had the idea to make the favorites view data persistent. Overall, though, it was conceptually similar to what we had previously implemented with allergens, so it did not take too much time to understand. I expected Data Persistence to be easy at first, but it ended up being a bit difficult to implement. The reason was that we only stored data with a predetermined number of columns. For example, in Journal, we stored an id column, a content column, an updatedAt column, a createdAt column, and (in my implementation) a feeling column. But with Dishcovery, a user could store anywhere from 0 to 9 different allergens, and anywhere from 0 to 20 different restaurants. So the difficulty navigating this portion of the assignment came from trying to store this data as a List of things. After a while, I learned that some apps stored list data as long strings in Drift using JSON encoding, and then decoding to get this data back as a list. 

Describe what changed from your original concept to your final implementation and explain why your group made those changes from your original design vision.

	Our original concept for dishcovery was limited to promoting awareness around an individual’s allergens in a dining setting. However, we quickly realized that there were a number of problems with this idea. By restricting it to highlight allergens in dining, we were significantly restricting the scope of our app. Additionally, the app would prove useless to individuals with no allergies. As a result, we decided to implement a barcode scanner in our application to enable individuals to use our application virtually anywhere, whether that’s at a fancy diner or at their local grocery store. Additionally, this would greatly increase our customer base, as it is important for everyone, regardless of whether they have an allergy or not, to know what exactly is going into their body. 


Describe two areas of future work for your app, including how you could increase the accessibility and usability of this app.

	One area of future work for our app would definitely be integrating real-time data. We attempted to do so with the Yelp API, but due to the cost of its subscription combined with the fact that it would only give us restaurant data and not dish data, we decided to stick with mock data, as we believed it would better showcase the functionality of the application. However, if we made this change, this would greatly increase our customer base, as it would enable allergen detection for restaurants not specifically located in Seattle. Another area of future work for our application would be to allow users to enter their allergens instead of having to choose from a predetermined list. This would increase the accessibility of our application by tailoring to individuals with allergies that are not super common.  
What do you feel was the most valuable thing you learned in CSE 340 that will help you beyond this class, and why?
	I think the most valuable thing that I learned in CSE340 is the importance of accessibility in regard to mobile applications. Before taking this class, I never really stopped to consider the impact that my design decisions would have on the user’s ability to navigate the app. However, through the accessibility audit and the various projects we were tasked with, I’ve gained a much deeper understanding of the significance of design choices and catering to users across various demographics instead of treating accessibility as an afterthought. I think that this mindset will greatly help me beyond this class because it not only promotes inclusivity but also forces more intentional design, which in turn will boost the success of any product I decide to build in the future. 
If you could go back and give yourself 2-3 pieces of advice at the beginning of the class, what would you say and why? (Alternatively: what 2-3 pieces of advice would you give to future students who take CSE 340 and why?)
	If I could go back and give myself 2-3 pieces of advice, it’d be to start as early as possible on my assignments and not to shy away from asking for help from the professor,  TAs, classmates, etc. I vividly remember pushing off Dart101 at the beginning of the quarter, only to spend hours struggling to implement the spec on the day it was due. This was not only extremely stressful but also set me back for the next assignment and piled on more work to an already busy course load. In regard to asking for help, I realized later in the quarter how much time and effort I would have saved if I had asked questions. Many of the issues that I spent hours debugging and trying to solve were solved in minutes with another set of eyes. Additionally, I believe that the best way of learning something is teaching it to someone else, and by asking questions, you’re not only learning but opening yourself up to receive questions, further deepening your understanding of the subject at hand.
Audit_changes.md

Our app was audited by Group 7 (Cinderella) by Ailsa Chen and Donara Galsyton. One of the tests they ran involved the color contrast between the text returned from the ingredient_result_page.dart file using the Image Color Picker, along with the WebAIM Contrast Checker to check for contrast problems. They determined that the text and background blended in too much. In response to this feedback, we decided to make this returned text black instead of red or green as it was previously, which made this part of the app much easier to read.  Additionally, another test that they ran involved changing the orientation of the application from portrait to landscape. This resulted in a pixel overflow, which visually broke the UI. In response to this, we leveraged widgets like LayoutBuilder and Expanded to ensure that our application was able to adjust to any screen orientation. These changes not only prevented any future crashes in the UI but also greatly improved the overall accessibility of the application. 
