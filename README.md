<img src="https://github.com/samblum17/Project-BON/blob/main/Project%20BON/Assets.xcassets/Vandy%20COVID%20Tracker%20Marketing%20Banner.jpeg?raw=true">

###### Access Vanderbilt University's most recent COVID-19 data in a simple, up-to-date interface.
Currently available to beta test via invite on [TestFlight](https://developer.apple.com/testflight/).

## App Highlights:
Vandy COVID Tracker is the easiest way to retrieve the most recent weekly case data pulled directly from the university's dashboard. 
- View the most important campus data at a glance: positive case count, positivity rate, and week-over-week positivity rate trend
- Receive instant push notifications when new data is available
- Quick in-app access to the university's dashboard, daily case record, and Return to Campus protocols

## Prerequisites
Vandy COVID Tracker is designed for iPhone, iPad, and Mac. Version 1.0 requires an iOS device running iOS 14+ or a Mac with Apple silicon.

## Development Process
Codenamed "Project BON", Vandy COVID Tracker was designed and developed from scratch to completion over the weekend of January 29 - February 1 2021. I built the application with the goal of sharpening SwiftUI skills and creating a simple, intuitive mobile dashboard for campus COVID data. The app also supports instant push notifications for updates to the weekly testing data, and this was my first time implementing push notifications through APNs. The notifications are delivered based on a deployed Google Cloud Function that monitors the official university COVID chart for updates. These updates pass through Cloud Firestore with unique tokens for each change to the Google Sheet before triggering a Cloud Message that delivers the iOS push notification. The Cloud Function was written in JavaScript and trigger is deployed through Zapier. The iOS application was written entirely in Swift with SwiftUI and Xcode 12. Using a Notion workspace, I managed a kanban board for the project from start to finish over the 4 day period following strict deadlines and priorities to practice Agile project management. Project BON utilized Git and GitHub for source control, and the app was fully tested and reviewed before completion.

This was an exciting project that I had been looking forward to developing since the beginning of the school year. SwiftUI enabled a pretty much seamless development process for the app and created a simple, sleek interface for displaying data. This was my first time writing in JavaScript (and backend code in general), and Google Cloud Documentation provided ample support in the process. Learning how to use Node.js and the Google Cloud Console was challenging at first but ultimately worked in delivering instant push notifications based on data updates from the university. My goal was to develop this application for my personal devices to more easily monitor COVID data on campus, but after completing development, the app has proven to be robust and accurate enough in displaying up-to-date data to deploy on the App Store or TestFlight for public download. If you are interested in downloading, please check back for updates on the current public availability or contact me.

## Authors
This application was designed, developed, and tested by Sam Blum. At the time of this publication, Sam is a 21 year old junior studying Computer Science and Engineering Management at Vanderbilt University. He is a lifelong Apple enthusiast and began teaching himself the Swift Programming Language for designing native iOS apps during his senior year of high school. He continued learning how to code when he took his first Java programming course at Vanderbilt in the spring of his freshman year. At Vanderbilt, he has learned fundamental software engineering principles in C++ and aims to continue spending personal development time working in SwiftUI over the course of the 2020-2021 school year. Sam is currently an [Apple Developer](https://apps.apple.com/us/developer/sam-blum/id1448067874), spent the summer of 2020 as an iOS Engineer Intern at Apple, and looks forward to returning to Apple for Summer 2021.

## Acknowledgments
I would like to thank Apple and Google for the abundance of documentation and resources on SwiftUI and Google Cloud products. And, as always, I'd like to thank my family and close friends for pushing me to continue learning and working hard, even when it gets tough.
Grit, humility, and a constant drive to never be satisfied push me to seek new opportunities every day. I'm extremely proud of the special place this project will hold in my heart, and I look forward to creating many more fun projects in the coming months. Thank you for checking out Vandy COVID Tracker, and stay well!

Questions about any of the code or project development? I'd love to chat! Feel free to reach out on [LinkedIn](https://www.linkedin.com/in/samblum17/) or email samblum17@icloud.com.


*App is not endorsed by or affiliated with Vanderbilt University*
//Last updated for Version 1.0 on February 2, 2021
