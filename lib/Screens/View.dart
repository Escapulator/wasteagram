import 'package:flutter/material.dart';
import 'package:wasteagram/Models/DetailsModels.dart';


class View extends StatefulWidget {
  final DetailsModel detailsModel;
  View({this.detailsModel});
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {

  String imageUrl;
  String date;
  String number;
  String location;

    void initState() {
    imageUrl = widget.detailsModel.imageUrl;
    number = widget.detailsModel.number;
    date = widget.detailsModel.date.toString();
    location = widget.detailsModel.location.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram'),
      elevation: 0,
      centerTitle: true,),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .7,
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * .05,),
                Center(child: Text(date.toString(),style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),),
                SizedBox(height: MediaQuery.of(context).size.height * .14,),
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  child: Center(
                    child: Image.network(
                      imageUrl,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                  flex: 10,
                    child: Text(
                      number.toString() + '  Items',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                  
                )
              ],),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .16,),
          Container(
          child: Text(location, style: TextStyle(fontSize: 20),),)
        ],
      ),
    );
  }
}