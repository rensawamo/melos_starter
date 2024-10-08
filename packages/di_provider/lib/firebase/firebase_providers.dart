import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
  
}

// if you want to use other firebase services, you can add them here
// @Riverpod(keepAlive: true)
// FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
//   return FirebaseFirestore.instance;
// }

// @Riverpod(keepAlive: true)
// FirebaseStorage firebaseStorage(FirebaseStorageRef ref) {
//   return FirebaseStorage.instance;
// }
