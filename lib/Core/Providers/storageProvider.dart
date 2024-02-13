import 'dart:io';

import 'package:app_ecommerce/Core/Common/failure.dart';
import 'package:app_ecommerce/Core/Common/typeDef.dart';
import 'package:app_ecommerce/Core/Providers/firebaseProviders.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final firebaseStorageProvider = Provider(
    (ref) => StorageRepository(firebaseStorage: ref.watch(storageProvider)));

class StorageRepository {
  final FirebaseStorage _firebaseStorage;
  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  //
  FutureEither<String> storeFile({
    required String path,
    required String id,
    required File? file,
    // required Uint8List? webFile,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask;
      // if (kIsWeb) {
      //   uploadTask = ref.putData(webFile!);
      // } else {
      //   uploadTask = ref.putFile(file!);
      // }
      uploadTask = ref.putFile(file!);

      final snapshot = await uploadTask;
      return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
