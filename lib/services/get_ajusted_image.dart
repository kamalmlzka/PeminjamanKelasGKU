import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GetAdjustedImage extends StatelessWidget {
  final String imagePath;

  const GetAdjustedImage(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<String>(
      future: getDownloadUrl(imagePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Image.network(
            snapshot.data!,
            height: size.height,
            width: size.width,
            fit: BoxFit.cover,
          );
        } else {
          return const Text('No Image URL found.');
        }
      },
    );
  }

  Future<String> getDownloadUrl(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw Exception('Error getting download URL: $e');
    }
  }
}
