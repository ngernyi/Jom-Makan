
import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/Image_container.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'package:good_food/features/customer_module/current_order_sheet.dart';


class customer_food_choice_detail_page extends StatefulWidget {
  const customer_food_choice_detail_page({super.key});

  @override
  State<customer_food_choice_detail_page> createState() => _customer_food_choice_detail_pageState();
}

class _customer_food_choice_detail_pageState extends State<customer_food_choice_detail_page> {
  void _openCurrentOrder(){
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context,
      builder: (context) {
        return current_order_sheet();  // This is the filter page as a bottom sheet
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Choice"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              
              // 1. Image
              Container(
                width: screenHorizontal,
                height: screenVertical*0.3,
                child: ImageContainer(),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: screenHorizontal*0.1),
                child: Column(
                  children: [
                    // 2. Details card
                    Details_card(),
                    GestureDetector(
                      onTap: () {
                        _openCurrentOrder();
                      },
                      child: long_button(
                          button_name: "View Current Order", 
                          backgroundColor: Colors.blue, 
                          textColor: Colors.white, 
                          height: screenVertical*0.05
                        ),
                    ),
                    // 3. Choose Session
                    title_text(title: "Choose Session"),
                    choices_button(),

                    // 4. Choose Destination
                    title_text(title: "Choose Destination"),
                    choices_button(),

                    // 5. Payment method
                    title_text(title: "Payment Method"),
                    
                    // 6. Quantity and Add to cart
                    Row(
                      children: [
                        Container(
                          height: screenVertical*0.08,
                          width: screenHorizontal*0.4,
                          child: Row(
                            children: [
                              addMinusButton(
                                addminusicon: Icons.remove, 
                                normalColor: Colors.blue, 
                                closedColor: Colors.grey, 
                                normal: true
                              ),

                              Expanded(
                                child: Center(
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                    ),
                                  ),
                                )
                              ),

                              addMinusButton(
                                addminusicon: Icons.add, 
                                normalColor: Colors.blue, 
                                closedColor: Colors.grey, 
                                normal: true
                              ),
                              
                              
                            ],
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: long_button(
                          button_name: "Add to Cart", 
                          backgroundColor: Colors.blue, 
                          textColor: Colors.white, 
                          height: screenVertical*0.07,
                          )
                        )
                      ],
                    )
                  ],
                ),
              )
            ]  
          ) 
        ),
      ),
    );
  }
}

class addMinusButton extends StatefulWidget {
  IconData addminusicon;
  Color normalColor;
  Color closedColor;
  bool normal;

  addMinusButton({
    required this.addminusicon,
    required this.normalColor,
    required this.closedColor,
    required this.normal
  });

  @override
  State<addMinusButton> createState() => _addMinusButtonState();
}

class _addMinusButtonState extends State<addMinusButton> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      height: screenVertical*0.07,
      width: screenVertical*0.07,
      child: Icon(widget.addminusicon, color: Colors.black,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.normal ? widget.normalColor : widget.closedColor,
      ),
    );
  }
}

class Details_card extends StatefulWidget {
  const Details_card({super.key});

  @override
  State<Details_card> createState() => _Details_cardState();
}

class _Details_cardState extends State<Details_card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameAndRating(),
          SizedBox(height: 10),
          _buildLocation(),
          SizedBox(height: 10),
          _buildPrice(),
        ],
      ),
    );
  }

  Widget _buildNameAndRating() {
    return Row(
      children: [
        Text(
          "Nasi Kukus",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Spacer(),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Text(
          "4.5",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "KK7",
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        "RM 5",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}


class choices_button extends StatefulWidget {

  List<bool> choice_list = List.filled(5, false);

  @override
  State<choices_button> createState() => _choices_buttonState();
}

class _choices_buttonState extends State<choices_button> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                for (int i = 0; i < widget.choice_list.length; i++) {
                  if(i == index){
                    continue;
                  }
                  widget.choice_list[i] = false;
                }
                widget.choice_list[index] = !widget.choice_list[index];
              });
            },
            child: squareButton(choice_title: "6PM", selected: widget.choice_list[index],),
          );
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}

class squareButton extends StatefulWidget {
  String choice_title;
  bool selected;

  squareButton({
    required this.choice_title,
    required this.selected,
  });

  @override
  State<squareButton> createState() => _squareButtonState();
}

class _squareButtonState extends State<squareButton> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: widget.selected ? Colors.blue : Colors.white,
        boxShadow:[BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),] 
      ),
      
      height: screenVertical*0.1,
      width: screenHorizontal*0.2,
      child: Center(
        child: Text(
          widget.choice_title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: widget.selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class title_text extends StatelessWidget {
  String title;

  title_text({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}