import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wasteagram/Models/DetailsModels.dart';
import 'package:wasteagram/Screens/View.dart';

class DetailsCard extends StatefulWidget {
  @override
  DetailsModel t;
  DetailsCard({this.t});

  _DetailsCardState createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.t.status == null) widget.t.status = false;

    return ListTile(
        title: Text(widget.t.date.toString()),
        trailing: Text(widget.t.number.toString()),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => View(
              detailsModel: widget.t,
            ),
          ));
        });
  }
}
/**
 * Redo this page to allow for the display of the image of the phone
 */
