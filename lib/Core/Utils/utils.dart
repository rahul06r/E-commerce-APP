import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform
      .pickFiles(type: FileType.image, allowMultiple: true);
  return image;
}

Future<FilePickerResult?> pickSingleImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}
