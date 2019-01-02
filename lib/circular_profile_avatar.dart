library circular_profile_avatar;

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
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
      this.cacheImage = false,
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

  /// Cache the image against [imageUrl] in app memory if set true. it is false by default.
  final bool cacheImage;

  /// sets onTap gesture.
  final GestureTapCallback onTap;

  @override
  _CircularProfileAvatarState createState() => _CircularProfileAvatarState();
}

class _CircularProfileAvatarState extends State<CircularProfileAvatar> {
  Widget _initialsText;
//  bool _imageLoading = true;
//  Image _image;

//  void _loadImage() async {
//    if (widget.imageUrl.isEmpty) {
//      return;
//    }
//    _image = new Image.network(
//      widget.imageUrl,
//    );
//    final ImageStream stream = _image.image.resolve(ImageConfiguration.empty);
//    final Completer<void> completer = Completer<void>();
//    stream.addListener((ImageInfo info, bool syncCall) => completer.complete());
//    await completer.future;
//    if (mounted) {
//      setState(() {
//        _imageLoading = false;
//      });
//    }
//  }

  @override
  Widget build(BuildContext context) {
    _initialsText = Center(child: widget.initialsText);
//    if (!widget.cacheImage) {
//      _loadImage();
//    } else {
//      _imageLoading = false;
//    }
    return GestureDetector(
      onTap: widget.onTap,
      child: Material(
        type: MaterialType.circle,
        elevation: widget.elevation,
        color: widget.borderColor,
        child: Container(
            height: widget.radius * 2,
            width: widget.radius * 2,
            padding: EdgeInsets.all(widget.borderWidth),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                color: widget.borderColor),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: BorderRadius.circular(widget.radius)),
                child: Stack(
                  fit: StackFit.expand,
                  children: widget.showInitialTextAbovePicture
                      ? <Widget>[
                          profileImage(),
                          Container(
                            decoration: BoxDecoration(
                                color: widget.foregroundColor,
                                borderRadius:
                                    BorderRadius.circular(widget.radius)),
                          ),
                          _initialsText,
                        ]
                      : <Widget>[_initialsText, profileImage()],
                ),
              ),
            )),
      ),
    );
  }

  Widget profileImage() {
    return widget.cacheImage
        ? ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
            ),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(widget.imageUrl),
          );
  }
}
