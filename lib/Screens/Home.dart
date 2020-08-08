import 'package:flutter/material.dart';
import 'package:wasteagram/Models/DetailsModels.dart';
import 'package:wasteagram/Screens/DetailsCard.dart';
import 'package:wasteagram/Services/Database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  Future<List<DetailsModel>> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.photo_camera, color: Colors.grey[200],),
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            Navigator.of(context).pushNamed('Details');
          },
        ),
        appBar: AppBar(elevation: 0,
        title: Text('Wasteagram'),
        centerTitle: true,),
      body: buildNotesList(tasks),
    );
          
  }

Widget buildNotesList(apiData) => FutureBuilder<dynamic> (
  future: apiData,
  builder: (context, snapshot) {

    if (!snapshot.hasData) return Container(

      height: 300,
      width: 400,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Center(
          child: Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.all(5),
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.grey
              ),
            ),
          ),
        )],
      )
    );

    if (snapshot.data.length == 0) {
      return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * .4,
                      child: CircularProgressIndicator()),
                    Text('Nothing to show now', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),)
                  ],
                ),
              ),
      );
    }

    return Row(
      children: <Widget>[
        Expanded(

          child: ListView.builder(
            scrollDirection: Axis.vertical,

            itemBuilder: (context, index){

              return DetailsCard(t: snapshot.data[index]);

            },

            itemCount: snapshot.data.length),
        ),
      ],
    );
  }
);
void initState() {

  super.initState();

  setState( () {
    tasks = Collections().getPhone();
      }
    );
  }
} 