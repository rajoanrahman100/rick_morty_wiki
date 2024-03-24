import 'package:flutter/material.dart';


class MyINDEXXX extends StatelessWidget {
  // Sample data list
  final List<String> dataList = List.generate(19, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 100.0; // Adjust this based on your item width
    final crossAxisCount = (screenWidth / itemWidth).floor();

    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: (dataList.length / 2).ceil(), // Dividing by 2 to show two items in a row
        itemBuilder: (context, index) {
          // Calculate indices for the two items in the current row
          int firstIndex = index * 2;
          int secondIndex = index * 2 + 1;

          // Check if the second index exceeds the length of the data list
          // If it does, only display the first item in the row
          bool hasSecondItem = secondIndex < dataList.length;

          return Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(dataList[firstIndex]),
                ),
              ),
              if (hasSecondItem)
                Expanded(
                  child: ListTile(
                    title: Text(dataList[secondIndex]),
                  ),
                ),
            ],
          );
        },
      ),

    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final String subTitle;

  GridItem({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            subTitle,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
