import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:good_food/features/common_widget/image_container.dart';
import 'package:good_food/features/free_food_module/screen/free_food_detail_page.dart';
import 'package:latlong2/latlong.dart';

import '../free_food_module/model/freeFoodModel.dart';

class map_full_screen extends StatefulWidget {
  List<FreeFoodModel> freeFoodList;

  // map that maps location and longitude latitude value
  Map<String, LatLng> locationLatLongMap = {
    "KK7": LatLng(3.12632166097733, 101.6504444017649),
    "KK8": LatLng(3.1298765580853036, 101.64937022242043),
    "KK9": LatLng(3.1209664966195554, 101.64592701886588),
    "KK12": LatLng(3.125709987491405, 101.66088901305682),
  };

  map_full_screen({super.key, required this.freeFoodList});

  @override
  _map_full_screenState createState() => _map_full_screenState();
}

class _map_full_screenState extends State<map_full_screen> {
  
  // default center at UM
  LatLng _mapCenter = LatLng(3.121894, 101.656859);
  
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _mapCenter,
          initialZoom: 14.8,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          // Marker Layer (Pins on the Map)
          MarkerLayer(
            markers: widget.freeFoodList.map((freeFood) {
              return Marker(
                point: widget.locationLatLongMap[freeFood.location[0]]!,
                width: screenHorizontal * 0.2,
                height: screenHorizontal * 0.2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => free_food_details_page(freeFood: freeFood),
                      ),
                    );
                  },
                  child: marker(amountLeft: freeFood.amountLeft, imageUrl: freeFood.donatedFoodImageUrl),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class marker extends StatefulWidget {
  int amountLeft;
  final String imageUrl;
  marker({super.key, required this.amountLeft, required this.imageUrl});
  @override
  State<marker> createState() => _markerState();
}

class _markerState extends State<marker> {
  @override
  Widget build(BuildContext context) {
    double markerSize = MediaQuery.of(context).size.width * 0.2;
    return Container(
      width: markerSize,
      height: markerSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],  
      ),
      padding: EdgeInsets.all(7),
      child: Stack(
        children: [
          // 1. image of the free food
          Image.network(
            widget.imageUrl.isEmpty ? 'https://picsum.photos/200/300' : widget.imageUrl,
            fit: BoxFit.cover,
            width: markerSize,
            height: markerSize,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
          // 2. number of free food left
          Positioned(
            child: Text(
              widget.amountLeft.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            bottom: 1,
            right: 1,
          ),

        ],
      ),
    );
  }
}
