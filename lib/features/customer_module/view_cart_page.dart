import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/image_container.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'customer_food_choice_detail_page.dart';
class view_cart_page extends StatefulWidget {
  const view_cart_page({super.key});

  @override
  State<view_cart_page> createState() => _view_cart_pageState();
}

class _view_cart_pageState extends State<view_cart_page> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: screenVertical*0.55,
              child: ListView.builder(

                itemCount: 3,
                itemBuilder: (context, index){
                  return cart_datail_card();
                }
              ),
            ),
            Divider(),

            summary_card(),
          ],
        ),
      ),
    );
  }
}

class cart_datail_card extends StatefulWidget {
  const cart_datail_card({super.key});

  @override
  State<cart_datail_card> createState() => _cart_datail_cardState();
}

class _cart_datail_cardState extends State<cart_datail_card> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: screenHorizontal*0.05, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Picture
          Container(
            width: screenHorizontal * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 1,
                child: ImageContainer(),
              ),
            ),
          ),
          SizedBox(width: 10),
          // 2. Description
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Food Title",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "RM 10.00",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Destination",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "KK7",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    addMinusButton(
                      addminusicon: Icons.remove,
                      normalColor: Colors.blue,
                      closedColor: Colors.grey,
                      normal: true,
                    ),
                    SizedBox(
                      width: 30,
                      child: Center(
                        child: Text(
                        "1",
                        style: TextStyle(
                          fontSize: 15,
                          
                        ),
                      ),
                      )
                    ),
                    addMinusButton(
                      addminusicon: Icons.add,
                      normalColor: Colors.blue,
                      closedColor: Colors.grey,
                      normal: true,
                    ),
                    Expanded(child: SizedBox(width: 1,)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Icon(
                          Icons.highlight_remove,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class summary_card extends StatefulWidget {
  const summary_card({super.key});

  @override
  State<summary_card> createState() => _summary_cardState();
}

class _summary_cardState extends State<summary_card> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenHorizontal*0.05),
      child: Column(
        children: [
          // 1. Subtotal
          summary_text_row(title: "Subtotal", content: "RM 10.00"),

          // 2. Delivery Fee
          summary_text_row(title: "Delivery Fee", content: "RM 0.50"),

          // 3. Total
          summary_text_row(title: "Total", content: "RM 10.50"),

          Divider(),

          // 4. Payment Method
          summary_text_row(title: "Payment Method", content: "Cash on Delivery"),

          // 5. Checkout button
          long_button(
            button_name: "Checkout", 
            backgroundColor: Colors.blue, 
            textColor: Colors.white, 
            height: screenVertical*0.07
            ),
        ],
      ),
    );
  }
}

class summary_text_row extends StatefulWidget {
  String title;
  String content;

  summary_text_row({required this.title, required this.content});

  @override
  State<summary_text_row> createState() => summary_text_rowState();
}

class summary_text_rowState extends State<summary_text_row> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20) ,
      child: Row(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(child: SizedBox(width: 1,)),
          Text(
            widget.content,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16
            ),
          ),
        ],
      ),
    );
  }
}