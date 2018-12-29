library circular_profile_avatar;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A Calculator.
class CircularProfileAvatar extends StatefulWidget {
  CircularProfileAvatar(
      {Key key,
      Text this.initialsText = const Text(''),
      String this.imageUrl = '',
      double this.radius = 50.0,
      double this.borderWidth = 0.0,
      Color this.borderColor = Colors.white,
      Color this.backgroundColor = Colors.white,
      double this.elevation = 0.0,
      bool this.showInitialTextAbovePicture = false,
        this.onTap,
      Color this.foregroundColor = Colors.transparent})
      : super(key: key);
  double radius;
  double elevation;
  double borderWidth;
  Color borderColor;
  Color backgroundColor;
  Color foregroundColor;
  String imageUrl;
  Text initialsText;
  bool showInitialTextAbovePicture;
  Widget _initialsText;
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
