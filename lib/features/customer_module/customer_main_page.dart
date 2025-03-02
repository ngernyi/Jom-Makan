import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/filter_button.dart';
import 'package:good_food/features/common_widget/search_bar.dart';
import 'package:good_food/features/customer_module/customer_delivery_status_page.dart';
import 'package:good_food/features/customer_module/customer_food_choice_detail_page.dart';
import 'view_cart_page.dart';

class customer_main_page extends StatefulWidget {

  List<Map<String,dynamic>> restaurant = [
    {
      "name": "Nasi Kukus",
      "location": "KK7",
      "price": 5,
      "rating": 4.8,
    },
    {
      "name": "Nasi Kukus",
      "location": "KK7",
      "price": 5,
      "rating": 4.8,
    },
    {
      "name": "Nasi Kukus",
      "location": "KK7",
      "price": 5,
      "rating": 4.8,
    },
    {
      "name": "Nasi Kukus",
      "location": "KK7",
      "price": 5,
      "rating": 4.8,
    },
    {
      "name": "Nasi Kukus",
      "location": "KK7",
      "price": 5,
      "rating": 4.8,
    },
    {
      "name": "Nasi Kukus",
      "location": "KK7",
      "price": 5,
      "rating": 4.8,
    },
  ];
  
    

  @override
  State<customer_main_page> createState() => _customer_main_pageState();
}

class _customer_main_pageState extends State<customer_main_page> {
  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Food"),
      ),

      body: Stack(
        children: [

          // 1. Container for the whole page
          Container(
            margin: EdgeInsets.symmetric(vertical: screenVertical*0.05),
            padding: EdgeInsets.symmetric(horizontal: screenHorizontal*0.1),
            child: Column(
              children: [
                // 1. Search bar and Filter
                Row(
                  children: [
                    searchBar(
                      controller: TextEditingController(), 
                      width: 0.65, 
                      searchHints: "Search Food",
                      onChanged: (value) => {},

                    ),
                    Expanded(child: SizedBox(width: 1,)),
                    filter_button(),
                  ],
                ),
                SizedBox(height: 16),

                // 2. Listview builder for the choices of the food
                Expanded(child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final post = widget.restaurant[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const customer_food_choice_detail_page(),
                          ),
                        );
                      },
                      child: customer_food_choice_card(
                        
                      ),
                    );
                  },)
                ),

              ],
              
            ),
          ),

          // 2. Floating button for cart
          Positioned(
            bottom: screenVertical*0.03,
            right: screenHorizontal*0.05,
            
            child: FloatingActionButton(
              heroTag: "cart",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const view_cart_page(),
                  ),
                );    
              },

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Icon(
                  Icons.shopping_cart,
                ),
              ),
            ),
            
          ),
          

          // 3. Floating button for delivery status
          Positioned(
            bottom: screenVertical*0.13,
            right: screenHorizontal*0.05,
            
            child: FloatingActionButton(
              heroTag: "delivery",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  customer_delivery_status_page(),
                  ),
                );              
              },

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Icon(
                  Icons.delivery_dining_outlined,
                ),
              ),
            ),
            
          ),
          
        ],
        
      ),

      
    );
  }
}

class customer_food_choice_card extends StatefulWidget {
  const customer_food_choice_card({super.key});

  @override
  State<customer_food_choice_card> createState() => _customer_food_choice_cardState();
}

class _customer_food_choice_cardState extends State<customer_food_choice_card> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      
      child: Row(
        children: [

          // 1. Picture
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              
            ),
            height: screenVertical*0.18,
            width: screenHorizontal*0.35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
              
              'https://picsum.photos/200/300',
              
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
            ),
          ),

          Container(
            height: screenVertical*0.18,
            width: screenHorizontal*0.45,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nasi Kukus",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),  // Fixed spacing between the elements
                Text(
                  "KK7",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),  // Fixed spacing between the elements
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "RM5",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(child: SizedBox(width: 1,)),
                    Text("4.8"),
                    Icon(Icons.star, color: Colors.yellow),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}

class floating_action_button extends StatefulWidget {
  IconData icon;
  Color color;

  floating_action_button({
    required this.icon,
    required this.color,
  });

  @override
  State<floating_action_button> createState() => _floating_action_buttonState();
}

class _floating_action_buttonState extends State<floating_action_button> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){

      },

      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
        ),
        child: Icon(
          widget.icon,
        ),
      ),
    );
  }
}