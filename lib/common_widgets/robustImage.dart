import 'package:flutter/material.dart'
    show
        Alignment,
        BoxFit,
        BuildContext,
        Container,
        EdgeInsets,
        FadeInImage,
        Image,
        Key,
        StatelessWidget,
        Widget;

class RobustFadeInImage extends StatelessWidget {
  final String imageUrl;
  final String placeholder;
  final BoxFit fit;
  final bool addMarginOnError;

  const RobustFadeInImage({
    this.placeholder,
    Key key,
    this.imageUrl,
    this.fit,
    this.addMarginOnError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imageUrl == null || imageUrl == "")
        ? _buildPlaceholder()
        : FadeInImage.assetNetwork(
            placeholder: 'images/loading.png',
            image: imageUrl,
            fit: fit ?? BoxFit.cover,
            imageErrorBuilder: (_, error, stack) {
              return _buildPlaceholder();
            },
          );
  }

  Widget _buildPlaceholder() {
    return Container(
      padding: addMarginOnError ? const EdgeInsets.all(10.0) : null,
      alignment: Alignment.center,
      child: Image.asset(placeholder ?? 'images/loading.png',
          fit: fit ?? BoxFit.cover),
    );
  }
}
