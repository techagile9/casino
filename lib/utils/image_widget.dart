import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? url;
  final String? placeholder;
  final BoxFit? fit;
  final double? height;
  final double? width;
  const ImageWidget({
    Key? key,
    this.url,
    this.placeholder,
    this.fit,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((url ?? '').isEmpty) {
      return Image.asset(
        placeholder ?? 'assets/wheel1.gif',
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          return Text(error.toString());
        },
      );
    }

    if (!(url!.startsWith("http") || url!.startsWith("https"))) {
      return Image.asset(
        url!,
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          return const Text('');
        },
      );
    }

    /*if (url.toLowerCase().endsWith('svg')) {
      return SvgPicture.network(
        url,
        placeholderBuilder: (_) => Image.asset(placeholder ?? AppImage.loadingPlaceholder),
      );
    }*/

    return FadeInImage.assetNetwork(
      placeholder: placeholder ?? '',
      image: url!,
      fit: fit ?? BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) =>
          Image.asset(placeholder!, fit: fit ?? BoxFit.cover),
    );
  }
}
