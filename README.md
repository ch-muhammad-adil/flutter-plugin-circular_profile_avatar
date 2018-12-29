# circular_profile_avatar

CircularProfileAvatar is a Flutter package which allows developers to implement circular profile avatar with border, overlay, initialsText and many other awesome features, which simplifies developers job. It is an alternative to Flutter's [CircleAvatar](https://docs.flutter.io/flutter/material/CircleAvatar-class.html) Widget.

<p align="center">
  <img src="https://github.com/ch-muhammad-adil/flutter-circular_profile_avatar/blob/master/Screenshot%202018-12-29%20at%205.53.17%20PM.png">
  <br/>
</p>


# Installation
         
   Add this to your package's pubspec.yaml file:      
         
    dependencies:
       circular_profile_avatar: ^0.0.2

and run 

     flutter packages get

# Usage

       
 
        CircularProfileAvatar(
              height: 200, // set height , default 50.0
              width: 200,  // set width , default 50.0
              backgroundColor: Colors.green, // set background color, default Colors.white
              borderWidth: 10,  // set border of profile picture, default value is 0.0
              initialsText: Text(
                "AD",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),  // sets initials text of the user name , set your own style, default value is Text('')
              borderColor: Colors.brown, // sets border colour, default is Colors.white
              elevation: 5.0, // sets elevation (shadow of the profile picture), default value is 0.0
              foregroundColor: Colors.brown.withOpacity(0.5), sets foreground colour of the profile picture, it works if showInitialTextAbovePicture = true , default value is Colors.transparent
              onTap: () {
                print('adil');
              }, // sets on tap 
              showInitialTextAbovePicture: true, // setting it true will show initials text above profile picture, default value is false  
              imagePath:
                  'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'), //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
        )



## Getting Started

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
