import 'package:flutter/material.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({super.key});

  @override
  State<ImageContainer> createState() => ImageContainerState();
}

class ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        'https://picsum.photos/200/300',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
      ),
    );
  }
}