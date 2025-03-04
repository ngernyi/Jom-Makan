import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/search_bar.dart';

class driver_customer_checklist extends StatefulWidget {
  const driver_customer_checklist({super.key});

  @override
  State<driver_customer_checklist> createState() => _driver_customer_checklistState();
}

class _driver_customer_checklistState extends State<driver_customer_checklist> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      height: screenVertical*0.7,
      child: Column(
        children: [
          SizedBox(height: screenVertical*0.01,),
          Text(
            "Customer Checklist",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: screenVertical*0.01,),

          Divider(),

          searchBar(
            width: 0.65, 
            searchHints: "Search Customer",
            controller: TextEditingController(),
            onChanged: (value) => {},
            ),

          Container(
            child: Expanded(
              child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return customer_row(name: "John Doe", phoneNumber: "012345678", collected: true);
              },
            ),
            ),
          ),
        ],
      ),
    );
  }
}

class customer_row extends StatefulWidget {
  String name;
  String phoneNumber;
  bool collected;

  customer_row({required this.name, required this.phoneNumber, required this.collected});

  @override
  State<customer_row> createState() => _customer_rowState();
}

class _customer_rowState extends State<customer_row> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )
              ),
              Text(
                widget.phoneNumber,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                )
              )
            ],
          ),
          Spacer(),
          Checkbox(
            value: widget.collected,
            onChanged: (value) {
              setState(() {
                widget.collected = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}