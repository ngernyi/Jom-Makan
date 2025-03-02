import 'package:flutter/material.dart';

class FreeFoodCard extends StatefulWidget {
  String FreeFoodName;
  String FreeFoodLocation;
  int FreeFoodAmount;
  String date;
  String time;

  FreeFoodCard({
    Key? key,
    required this.FreeFoodName,
    required this.FreeFoodLocation,
    required this.FreeFoodAmount,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  State<FreeFoodCard> createState() => _FreeFoodCardState();
}

class _FreeFoodCardState extends State<FreeFoodCard> {
  @override
  Widget build(BuildContext context) {
    double screenfactor = MediaQuery.of(context).devicePixelRatio;

    // size related variables
    double borderRadius = 10 * screenfactor;
    double paddingValue = 10 * screenfactor;
    double titlesize = 9 * screenfactor;
    double textSize = 7 * screenfactor;
    double datetimesize = 4 * screenfactor;
    double sizedBoxHeight = 5 * screenfactor;

    return Card(
      elevation: 5, // Shadow of the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 5 * screenfactor,
        horizontal: 5 * screenfactor,
      ),
      child: Container(
        padding: EdgeInsets.all(paddingValue),
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [Colors.blue.shade100, Colors.blue.shade300],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          color: const Color.fromARGB(255, 138, 189, 231),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.FreeFoodName,
                    style: TextStyle(
                      fontSize: titlesize,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: sizedBoxHeight),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: textSize, color: Colors.blue.shade700),
                      SizedBox(width: 5),
                      Text(
                        widget.FreeFoodLocation,
                        style: TextStyle(
                          fontSize: textSize,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sizedBoxHeight / 2),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: datetimesize, color: Colors.blue.shade700),
                      SizedBox(width: 5),
                      Text(
                        widget.date,
                        style: TextStyle(
                          fontSize: datetimesize,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.access_time, size: datetimesize, color: Colors.blue.shade700),
                      SizedBox(width: 5),
                      Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: datetimesize,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: sizedBoxHeight),
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  Text(
                    "Amount\nLeft",
                    style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: sizedBoxHeight),
                  Text(
                    widget.FreeFoodAmount.toString(),
                    style: TextStyle(
                      fontSize: titlesize,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}