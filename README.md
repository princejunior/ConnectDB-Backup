# Overview

A straightforward iOS mobile application that enables users to view content uploaded by themselves or other users. 
The software interacts with Firebase's authentication and Firestore. 
The functionalities also allow the user to sign up or log in, view uploaded content, and upload content themselves.
The navigation bar displays the profile, display, and upload page without needing to load the page again.
The app can now upload pictures with a title and description. Also, the content is displayed on the display page.
The goal of this app is to grasp the fundamentals of iOS, laying the groundwork for a future, more advanced application.

Newer (2/10/24):
[Software iOS Demo Video](https://youtu.be/mWm6fLMwaHY)


older:
[Software Cloud Demo Video](https://www.youtube.com/watch?v=NsftkmrsIvc)

# Cloud Database

Firestore is like a super-smart digital filing cabinet from Google Cloud that helps apps store and share information effortlessly. 
It's like having a magical notebook that keeps things organized and up-to-date, whether you're using it for a website, mobile app, or some other digital wizardry.
The database structure is designed to permit any signed-in users to upload content to a collection in Firestore named "content."


# Development Environment

I used Xcode and the libraries built into the framework.

In the world of building iPhone and iPad apps, think of `@ObservedObject`, `@Binding`, and `ObservableObject` 
as the special tools in Swift—the language used for iOS development—that make your app's interface come alive.

1. **@ObservedObject:**
   Imagine `@ObservedObject` as a magic link between what your app shows on the screen and the behind-the-scenes data.
   It's like a messenger that tells your app to update its display whenever the data it's watching changes.

3. **@Binding:**
   Now, think of `@Binding` as a cool way for different parts of your app to talk to each other.
   It's like a secret passage that lets one part of the app send information to another part and make sure they're always on the same page.

5. **ObservableObject:**
   Lastly, `ObservableObject` is like a wizard's spell for Swift classes. When a class follows this spell, it becomes watchable.
   So, whenever something important inside it changes, it sends a signal, and anything in your app that's paying attention gets updated automatically.

In simple terms, these Swift and SwiftUI tools work together to make sure your app not only looks good but also stays in sync with the latest information, 
creating a smooth and magical experience for the people using it.

# Programming Language
Swift functionality is very similar to other languages. I was able to build Structs, classes, and functions to create the application.

# Useful Websites
- [Apple Developer Documentation](https://developer.apple.com/documentation/xcode/)


- [Firebase Documentation](https://firebase.google.com/docs?hl=en&authuser=0&_gl=1*j5rwrm*_ga*MjA2OTg2MjI3Ni4xNzAzOTIwMjc1*_ga_CW55HF8NVT*MTcwNjQxNzYwMS4xOS4xLjE3MDY0MjA1NjQuNTguMC4w)


# Future Work

- Create the Profile page for user's to see their infomation and previous content they uploaded.
- Rectify the functionality of the back buttons
