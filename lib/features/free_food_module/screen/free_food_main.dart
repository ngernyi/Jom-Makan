import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'package:good_food/features/free_food_module/model/freeFoodModel.dart';
import 'package:good_food/features/free_food_module/widgets/free_food_list_sheet.dart';
import 'package:good_food/features/common_widget/map_full_screen.dart';
import 'package:provider/provider.dart';
import '../provider/addFreeFoodProvider.dart';
import 'free_food_filter_page.dart';
import 'add_free_food_page.dart';
import 'package:good_food/features/common_widget/search_bar.dart';
import 'package:good_food/features/common_widget/filter_button.dart';

class FreeFoodHome extends StatefulWidget {
  @override
  _FreeFoodHomeState createState() => _FreeFoodHomeState();
}

class _FreeFoodHomeState extends State<FreeFoodHome> {
  // Variables
  List<String> locationList = [];
  String distance = "";

  // Child size of the draggable sheet
  double _childSize = 0.3;
  
  double _expandedSize = 0.8;
  double _collapsedSize = 0.2;

  // function to open filter
  void _openFilter() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context,
      builder: (context) {
        return filter_page(passedlocation: locationList, passedDistance: distance);
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          locationList = value["selectedLocationList"];
          distance = value["selectedDistance"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder<List<FreeFoodModel>>(
        stream: Provider.of<addFreeFoodProvider>(context, listen: false).getAvailableDonationsStream(),
        builder: (context, snapshot) {
          // if the connection is waiting, show a loading indicator
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }
          // if there is an error, show the error message 
           if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // if there is no data, show a message 
          // else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //   return Center(child: Text('No free food available'));
          // }
          // if there is data, show the list 
          else {
            List<FreeFoodModel> freeFoodData = snapshot.data!;

            // if the user set the filter
            if (locationList.isNotEmpty || distance.isNotEmpty) {
              freeFoodData = Provider.of<addFreeFoodProvider>(context, listen: false).filterByLocation(locationList, freeFoodData);
            }
            if(Provider.of<addFreeFoodProvider>(context, listen: false).searchTerm != "") {
              freeFoodData = Provider.of<addFreeFoodProvider>(context, listen: false).searchFreeFood(freeFoodData);
            }

            return Stack(
              children: [
                // 1. MAP
                Positioned.fill(
                  child: map_full_screen(freeFoodList: freeFoodData,),
                ),

                // 3. Draggable Free Food List
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onVerticalDragUpdate: (details) {
                      setState(() {
                        _childSize = (_childSize - details.primaryDelta! / screenVertical).clamp(0.1, 0.750);
                      });
                    },
                    child: Container(
                      height: _childSize * screenVertical,
                      child: free_food_list(
                        freeFoodPosts: freeFoodData
                      ),
                    ),
                  ),
                ),

                // 2. SEARCH BAR
                Positioned(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: screenHorizontal * 0.05),
                    child: Column(
                      children: [
                        SizedBox(height: screenVertical * 0.07),
                        Column(
                          children: [
                            Row(
                              children: [
                                searchBar(
                                  width: 0.6, 
                                  searchHints: "Search Free Food",
                                  controller: Provider.of<addFreeFoodProvider>(context, listen: false).searchController,
                                  onChanged: (value) {
                                    // freeFoodData = Provider.of<addFreeFoodProvider>(context, listen: false).searchFreeFood(freeFoodData);
                                    setState(() {
                                    });
                                  },
                                ),
                                SizedBox(width: screenHorizontal * 0.02),
                                GestureDetector(
                                  child: filter_button(),
                                  onTap: () {
                                    _openFilter();
                                  },
                                ),
                                SizedBox(width: screenHorizontal * 0.02),
                                GestureDetector(
                                  child: Container(       
                                    height: screenVertical*0.06,
                                    width: screenVertical*0.06,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.blue,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const add_free_food_page(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                           
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
      // floatingActionButton: Positioned(
      //   bottom: 50.0,
      //   right: 20.0,
      //   child: FloatingActionButton(
      //     key: UniqueKey(),
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const add_free_food_page(),
      //         ),
      //       );
      //     },
      //     child: Icon(Icons.add),
      //     tooltip: "Add Free Food",
      //   ),
      // ),
    );
  }
}
