import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/Models/DetailsModels.dart'; 

class Collections
{ 
  final databaseReference = Firestore.instance;


  Future<List<DetailsModel>> getPhone() async{

    List<DetailsModel> phone = [];
     await databaseReference
        .collection("users")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((d) => 
            phone.add(
            DetailsModel(
              imageUrl: d['imageUrl'],
              number: d['number'],
              date: d['date'],
              location: d['location'])
              
            )     
          ); 
      });
      return phone; 
  }

  addToPhone(DetailsModel t) async
  { 
    await databaseReference.collection("users")
        .add({
          'imageUrl' : t.imageUrl,
          'number' : t.number,
          'date' : t.date,
          'location' : t.location,
      }
    )
    ;
  }


}