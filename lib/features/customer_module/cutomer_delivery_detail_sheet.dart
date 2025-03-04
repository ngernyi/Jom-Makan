import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/Image_container.dart';

class customer_delivery_details_sheet extends StatefulWidget {
  const customer_delivery_details_sheet({super.key});

  @override
  State<customer_delivery_details_sheet> createState() => _customer_delivery_details_sheetState();
}

class _customer_delivery_details_sheetState extends State<customer_delivery_details_sheet> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      height: screenVertical*0.7,
      padding: EdgeInsets.symmetric(horizontal: screenHorizontal*0.07, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Food details card
          Text(
            "Food Information",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          
          info_card(),
          // 2. Driver info card
          Text(
            "Driver Information",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          info_card(),

        ],
      ),
    );
  }
}

class info_card extends StatefulWidget {
  const info_card({super.key});

  @override
  State<info_card> createState() => _info_cardState();
}

class _info_cardState extends State<info_card> {
  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Food picture
          Container(
            height: screenVertical * 0.2,
            width: screenHorizontal * 0.3,
            child: ImageContainer(),
          ),
          SizedBox(width: 10),
          // 2. Food details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Food Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Destination',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'ETA',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Quantity',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
