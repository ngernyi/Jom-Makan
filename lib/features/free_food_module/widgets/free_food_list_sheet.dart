import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:good_food/features/free_food_module/model/freeFoodModel.dart';
import 'package:good_food/features/free_food_module/screen/free_food_detail_page.dart';
import 'package:provider/provider.dart';
import 'free_food_card.dart';
import '../provider/addFreeFoodProvider.dart';

class free_food_list extends StatefulWidget {
  // List<String> selectedLocation;
  // String selectedDistance;
  List<FreeFoodModel> freeFoodPosts;

  free_food_list({super.key, required this.freeFoodPosts});
  

  @override
  State<free_food_list> createState() => _free_food_listState();
}

class _free_food_listState extends State<free_food_list> {

  
  
  @override
  Widget build(BuildContext context) {
    // final freeFoodProvider = Provider.of<addFreeFoodProvider>(context, listen: false);
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    // return StreamBuilder<List<FreeFoodModel>>(
    //   stream: freeFoodProvider.getAvailableDonationsStream(),
    //   builder: (context, snapshot) {
    //     // if the snapshot has no data, return a loading indicator
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //     // if the snapshot has an error, return an error message 
    //     else if (snapshot.hasError) {
    //       return Center(child: Text('Error: ${snapshot.error}'));
    //     } 
    //     // if the snapshot has no data, return a message
    //     else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       log(snapshot.data.toString());
    //       return Center(child: Text('No free food available'));
    //     }        
    //     // no error, show something
    //     else {

    //       // if the user havent selected any filter
    //       List<FreeFoodModel> freeFoodPosts = snapshot.data!;
          
    //       // if the user has selected a filter
    //       if(widget.selectedLocation.isNotEmpty || widget.selectedDistance.isNotEmpty){
    //         // show only the posts that match the filter
    //         freeFoodPosts = freeFoodProvider.filterByLocation(widget.selectedLocation,snapshot.data??[]);
    //       }

          return 
                 Container(
                  margin: EdgeInsets.only(
                    bottom: screenVertical * 0.02,
                    left: screenHorizontal * 0.05,
                    right: screenHorizontal * 0.05,
                  ),
                  padding: EdgeInsets.only(
                    bottom: screenVertical * 0.02,
                  ),
                  
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(blurRadius: 5, color: Colors.black26)
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 16,
                        ),
                        
                        child: Center(
                          child: Text(
                            "Free Food List",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.freeFoodPosts.length,
                          itemBuilder: (context, index) {
                            final post = widget.freeFoodPosts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => free_food_details_page(freeFood: post),
                                  ),
                                );
                              },
                              child: FreeFoodCard(
                                FreeFoodName: post.foodName.toString(),
                                FreeFoodLocation: post.location[0].toString(),
                                date: post.time.toDate().toString(),
                                time: "",
                                FreeFoodAmount: post.amountLeft.toInt(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
            
        // }
      // }
    // );
  }
}