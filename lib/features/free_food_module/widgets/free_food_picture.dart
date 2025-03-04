import 'package:flutter/material.dart';

class free_food_picture extends StatefulWidget {

  String imageUrl;
  free_food_picture({super.key, required this.imageUrl});

  @override
  State<free_food_picture> createState() => free_food_pictureState();
}

class free_food_pictureState extends State<free_food_picture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        widget.imageUrl.isEmpty ? 'https://picsum.photos/200/300' : widget.imageUrl ,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
      ),
    );
  }
}