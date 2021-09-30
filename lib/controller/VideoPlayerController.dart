import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goldfolks/model/VideoCategory.dart';

class VideoPlayerController {
  static final CollectionReference aerobicVideoCollection =
  FirebaseFirestore.instance.collection('Aerobic Videos');
  static final CollectionReference lowerBodyCollection =
  FirebaseFirestore.instance.collection('Lower Body Videos');
  static final CollectionReference upperBodyCollection =
  FirebaseFirestore.instance.collection('Upper Body Videos');

  static Future<List<String>> getAllVideos(VideoCategory type) async {
    List<String> videos = [];
    var querySnapshot;
    switch (type) {
      case VideoCategory.Aerobic:
        querySnapshot = await aerobicVideoCollection.get();
        break;
      case VideoCategory.LowerBody:
        querySnapshot = await lowerBodyCollection.get();
        break;
      case VideoCategory.UpperBody:
        querySnapshot = await upperBodyCollection.get();
        break;
    }
    for (var document in querySnapshot.docs) {
      try {
        videos.add(document['id']);
      } catch (e) {
        print(e);
      }
    }
    //videos.sort();
    return videos;
  }
}