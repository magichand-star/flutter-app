import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';

Future<String?> uploadData(String path, Uint8List data) async {
  final storageRef = FirebaseStorage.instance.ref().child(path);
  final metadata = SettableMetadata(contentType: mime(path));
  final result = await storageRef.putData(data, metadata);
  return result.state == TaskState.success ? result.ref.getDownloadURL() : null;
}

Future<String?> uploadDataFromFile(String path, File file) async {
  final storageRef = FirebaseStorage.instance.ref().child(path);
  final metadata = SettableMetadata(contentType: mime(path));
  try {
    TaskSnapshot result = await storageRef.putFile(file, metadata);

    return result.state == TaskState.success
        ? result.ref.getDownloadURL()
        : null;
  } on FirebaseException catch (e) {
    print(e);
    return null;
  }
}

Future deleteData(String path) async {
  final storageRef = FirebaseStorage.instance.ref().child(path);
  await storageRef.delete();
}
