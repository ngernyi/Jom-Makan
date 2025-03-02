import 'package:flutter/material.dart';
import 'package:good_food/features/free_food_module/model/freeFoodModel.dart';


class free_food_detail_card extends StatefulWidget {
  FreeFoodModel freeFood;
  free_food_detail_card({super.key, required this.freeFood});

  @override
  State<free_food_detail_card> createState() => _free_food_detail_cardState();
}

class _free_food_detail_cardState extends State<free_food_detail_card> {
  late List<Map<String, String>> details;
  @override
  void initState() {
    super.initState();
    String locations = "";
    locations += widget.freeFood.location[0];
    for (var i = 1; i < widget.freeFood.location.length-1; i++) {
      locations += ", " + widget.freeFood.location[i];
    }
    details = [
      {"title": "Location", "value": locations},
      {"title": "Time", "value": widget.freeFood.time.toDate().toString()},
      {"title": "Food Name", "value": widget.freeFood.foodName},
      {"title": "Description", "value": widget.freeFood.description},
      {"title": "Amount Left", "value": widget.freeFood.amountLeft.toString()},

    ];
  }
  
  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;
    return  Container(
        margin: EdgeInsets.symmetric(vertical: screenVertical*0.02),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 228, 228, 228),
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Column(
          children: [

            // Title with icon
            Padding(
              padding: EdgeInsets.only(left: 2, top: 5, bottom: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.food_bank
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Free Food Name",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  )
                ],
              ),
            ),

            // Details
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: details.length,
              itemBuilder: (context, index) {
                return detail_card(
                  title: details[index]["title"]!,
                  value: details[index]["value"]!,
                );
              },
            )

        

          ],
        ),
      
    );
  }
}

class detail_card extends StatefulWidget {
  final String title;
  final String value;

  const detail_card({required this.title, required this.value});
  @override
  State<detail_card> createState() => _detail_cardState();
}

class _detail_cardState extends State<detail_card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ) 
          ),
          Text(
            widget.value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
            )
            
          ),
        ],
      ),
    );
  }
}