import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> getCameraPermission() async {
  final permission = await Permission.camera.status;
  if (permission != PermissionStatus.granted) return await Permission.camera.request().isGranted;
  return true;
}

// Future<bool> getGalleryPermission() async {
//   final permission = await Permission.photos.status;
//   if (permission != PermissionStatus.granted) return await Permission.photos.request().isGranted;
//   return true;
// }

Future<XFile?> pickImage(ImageSource source) async {
  final permissionGranted = await getCameraPermission();
  if (permissionGranted) return await ImagePicker().pickImage(source: source);
  return null;
}
