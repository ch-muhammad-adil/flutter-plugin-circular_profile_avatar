library circular_profile_avatar;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///CircularProfileAvatar allows developers to implement circular profile avatar with border,
/// overlay, initialsText and many other features which simplifies developer's job.
/// It is an alternative to Flutter's CircleAvatar Widget.
class CircularProfileAvatar extends StatefulWidget {
  CircularProfileAvatar(
      {Key key,
      this.initialsText = const Text(''),
        this.imageUrl = '',
      this.radius = 50.0,
      this.borderWidth = 0.0,
      this.borderColor = Colors.white,
      this.backgroundColor = Colors.white,
      this.elevation = 0.0,
      this.showInitialTextAbovePicture = false,
        this.onTap,
      this.foregroundColor = Colors.transparent})
      : super(key: key);
  /// sets radius of the avatar circle, [borderWidth] is also included in this radius.
  /// default value is 0.0
  final double radius;
  /// sets shadow of the circle,
  /// default value is 0.0
  final double elevation;

  /// sets the borderWidth of the circile,
  /// default value is 0.0
  final double borderWidth;
  /// The color with which to fill the border of the circle.
  /// default value [Colors.white]
  final Color borderColor;

  /// The color with which to fill the circle.
  /// default value [Colors.white]
  final Color backgroundColor;

  /// sets the [foregroundColor] of the circle, It only works if [showInitialTextAbovePicture] is set to true.
  /// [foregroundColor] doesn't include border of the circle.
  final Color foregroundColor;

  /// it takes a URL of the profile image.
  final String imageUrl;

  /// Sets the initials of user's name.
  final Text initialsText;

  /// Displays initials above profile picture if set to true, You can set [foregroundColor] value as well if [showInitialTextAbovePicture]
  /// is set to true.
  final bool showInitialTextAbovePicture;

  /// sets onTap gesture.
  final GestureTapCallback onTap;


  @override
  _CircularProfileAvatarState createState() => _CircularProfileAvatarState(
      initialsText: this.initialsText,
      imageUrl: imageUrl,
      radius: radius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      backgroundColor: backgroundColor,
      elevation: elevation,
      showInitialTextAbovePicture: showInitialTextAbovePicture,
      foregroundColor: foregroundColor,
      onTap: onTap);
}

class _CircularProfileAvatarState extends State<CircularProfileAvatar> {
  _CircularProfileAvatarState(
      {this.initialsText,
      this.imageUrl,
      this.radius,
      this.borderWidth,
      this.borderColor,
      this.backgroundColor,
      this.elevation,
      this.showInitialTextAbovePicture,
      this.foregroundColor,
      this.onTap});

  Color foregroundColor;
  double elevation;
  double radius;
  double borderWidth;
  Color borderColor;
  Color backgroundColor;
  String imageUrl;
  Text initialsText;
  bool showInitialTextAbovePicture;
  Widget _initialsText;
  final GestureTapCallback onTap;
  bool _imageLoading = true;

  Image _image;

  void _loadImage() async {
    if (imageUrl.isEmpty) {
      return;
    }
    _image = new Image.network(
      imageUrl,
    );
    final ImageStream stream = _image.image.resolve(ImageConfiguration.empty);
    final Completer<void> completer = Completer<void>();
    stream.addListener((ImageInfo info, bool syncCall) => completer.complete());
    await completer.future;
    if (mounted) {
      setState(() {
        _imageLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _initialsText = Center(child: initialsText);
    _loadImage();
    return GestureDetector(
      onTap: onTap,
      child: Material(
        type: MaterialType.circle,
        elevation: elevation,
        color: borderColor,
        child: Container(
            height: radius*2,
            width: radius*2,
            padding: EdgeInsets.all(borderWidth),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: borderColor),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(radius)),
                child: Stack(
                  fit: StackFit.expand,
                  children: showInitialTextAbovePicture
                      ? <Widget>[
                          CircleAvatar(
                            backgroundImage: _image.image,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: foregroundColor,
                                borderRadius:
                                    BorderRadius.circular(radius)),
                          ),
                          _initialsText,
                        ]
                      : <Widget>[
                          _imageLoading
                              ? _initialsText
                              : CircleAvatar(
                                  backgroundImage: _image.image,
                                )
                        ],
                ),
              ),
            )),
      ),
    );
  }
}
