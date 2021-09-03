library circular_profile_avatar;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///CircularProfileAvatar allows developers to implement circular profile avatar with border,
/// overlay, initialsText and many other features which simplifies developer's job.
/// It is an alternative to Flutter's CircleAvatar Widget.
class CircularProfileAvatar extends StatefulWidget {
  CircularProfileAvatar(this.imageUrl,
      {this.initialsText = const Text(''),
      this.cacheImage = true,
      this.radius = 50.0,
      this.borderWidth = 0.0,
      this.borderColor = Colors.white,
      this.backgroundColor = Colors.white,
      this.elevation = 0.0,
      this.showInitialTextAbovePicture = false,
      this.onTap,
      this.foregroundColor = Colors.transparent,
      this.placeHolder,
      this.errorWidget,
      this.imageBuilder,
      this.animateFromOldImageOnUrlChange,
      this.progressIndicatorBuilder,
      this.child,
      this.imageFit = BoxFit.cover});

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

  /// Cache the image against [imageUrl] in app memory if set true. it is true by default.
  final bool cacheImage;

  /// sets onTap gesture.
  final GestureTapCallback? onTap;

  /// Widget displayed while the target [imageUrl] is loading, works only if [cacheImage] is true.
  final PlaceholderWidgetBuilder? placeHolder;

  /// Widget displayed while the target [imageUrl] failed loading, works only if [cacheImage] is true.
  final LoadingErrorWidgetBuilder? errorWidget;

  /// Widget displayed while the target [imageUrl] is loading, works only if [cacheImage] is true.
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  /// Optional builder to further customize the display of the image.
  final ImageWidgetBuilder? imageBuilder;

  /// When set to true it will animate from the old image to the new image
  /// if the url changes.
  final bool? animateFromOldImageOnUrlChange;

  /// Setting child will hide every other widget [initialsText] and profile picture against [imageUrl].
  /// Best use case is passing [AssetImage] as profile picture. You can pass [imageUrl] as empty string if you want to set child value.
  final Widget? child;

  /// How to inscribe the image into the space allocated during layout.
  /// Set the [BoxFit] value as you want.
  final BoxFit imageFit;

  @override
  _CircularProfileAvatarState createState() => _CircularProfileAvatarState();
}

class _CircularProfileAvatarState extends State<CircularProfileAvatar> {
  Widget? _initialsText;

  @override
  Widget build(BuildContext context) {
    _initialsText = Center(child: widget.initialsText);
    return GestureDetector(
      onTap: widget.onTap,
      child: Material(
        type: MaterialType.circle,
        elevation: widget.elevation,
        color: widget.borderColor,
        child: Container(
            height: widget.radius * 2,
            width: widget.radius * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              border: Border.all(
                  width: widget.borderWidth, color: widget.borderColor),
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: BorderRadius.circular(widget.radius)),
                child: widget.child == null
                    ? Stack(
                        fit: StackFit.expand,
                        children: widget.imageUrl.isEmpty
                            ? <Widget>[_initialsText!]
                            : widget.showInitialTextAbovePicture
                                ? <Widget>[
                                    profileImage(),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: widget.foregroundColor,
                                        borderRadius: BorderRadius.circular(
                                            widget.radius),
                                      ),
                                    ),
                                    _initialsText!,
                                  ]
                                : <Widget>[
                                    _initialsText!,
                                    profileImage(),
                                  ],
                      )
                    : child(),
              ),
            )),
      ),
    );
  }

  Widget child() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: Container(
        height: widget.radius * 2,
        width: widget.radius * 2,
        child: widget.child,
      ),
    );
  }

  Widget profileImage() {
    return widget.cacheImage
        ? ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: CachedNetworkImage(
              fit: widget.imageFit,
              imageUrl: widget.imageUrl,
              errorWidget: widget.errorWidget,
              placeholder: widget.placeHolder,
              imageBuilder: widget.imageBuilder,
              progressIndicatorBuilder: widget.progressIndicatorBuilder,
              useOldImageOnUrlChange:
                  widget.animateFromOldImageOnUrlChange ?? false,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: Image.network(
              widget.imageUrl,
              fit: widget.imageFit,
            ));
  }
}
