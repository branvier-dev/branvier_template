// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// import '../../../firebase_options.dart';

class FirebaseService {
  FirebaseService(this.app);
  final dynamic app;
  // final FirebaseApp app;
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<FirebaseService> async() async {
    final app = Object();
    // final app = await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    return FirebaseService(app);
  }
}
