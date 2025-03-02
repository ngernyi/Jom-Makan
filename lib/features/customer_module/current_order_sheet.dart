import 'package:flutter/material.dart';

class current_order_sheet extends StatefulWidget {
  const current_order_sheet({super.key});

  @override
  State<current_order_sheet> createState() => _current_order_sheetState();
}

class _current_order_sheetState extends State<current_order_sheet> {
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;
    return Container(
      height: screenVertical*0.7,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // 1. Title
          const Text(
            "Current Order",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          Divider(),

          // 2. List of order_amount_card
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return order_amount_card(
                  location: "Location $index",
                  amount: 10,
                );
              },
            ),
          ),
          
        ],
      ),
    );
  }
}

class order_amount_card extends StatefulWidget {
  String location;
  int amount;

  order_amount_card({
    required this.location,
    required this.amount,
  });

  @override
  State<order_amount_card> createState() => _order_amount_cardState();
}

class _order_amount_cardState extends State<order_amount_card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child:Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  widget.location,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ), 
          ),
          Expanded(
            child:Container(
              height: 50,
              child: Center(
                child: Text(
                  widget.amount.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ) 
            ),
        ],
      ),
    );
  }
}
