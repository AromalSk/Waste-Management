import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_management/domain/entities/collection_schedule.dart';

Future<List<CollectionSchedule>> getCollection ()async{

List<CollectionSchedule> collection = [];

 final querySnapshot = await FirebaseFirestore.instance
      .collection('weekly-collection-schedule')
      .get();

    collection =  querySnapshot.docs.map((e) {
        return CollectionSchedule(
          days: e['days'],
          type: e['type']
        );
      }).toList();

      return collection;
}