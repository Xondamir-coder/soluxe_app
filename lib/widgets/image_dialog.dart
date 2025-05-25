import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/user.dart';
import 'package:soluxe/providers/account_provider.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:http/http.dart' as http;

class ImageDialog extends ConsumerStatefulWidget {
  const ImageDialog({super.key});

  @override
  ConsumerState<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends ConsumerState<ImageDialog> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Step 1 & 2: Pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      // Check file extension
      String fileExtension = pickedFile.path.split('.').last.toLowerCase();
      if (fileExtension == 'jpg' ||
          fileExtension == 'jpeg' ||
          fileExtension == 'png') {
        setState(() {
          _image = File(pickedFile.path);
        });

        _sendImageToBackend();
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Only jpg, jpeg, and png files are allowed.')),
        );
      }
    }
  }

  // Step 3: Send image to backend
  Future<void> _sendImageToBackend() async {
    if (_image == null) return;

    // Replace with your backend URL
    final uri = Uri.parse('${Constants.apiUrl}/user-edit');

    final request = http.MultipartRequest('POST', uri);
    final token = (await LocalStorageHelper.getAccountData()).token;

    // Add headers
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    // Get account
    final acc = await LocalStorageHelper.getAccountData();

    // Add text fields
    request.fields['full_name'] = acc.user!.fullName!;
    if (acc.user!.email != null) request.fields['email'] = acc.user!.email!;
    if (acc.user!.phone != null) request.fields['phone'] = acc.user!.phone!;

    // Add image
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    final response = await request.send();

    if (!mounted) return;
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully')),
      );

      final body = json.decode((await response.stream.bytesToString()));
      ref.read(accountProvider.notifier).updateAccount(
            user: User.fromMap(body['user'] as Map<String, dynamic>),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image upload failed')),
      );
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: const MyText.warmPrimary(
              'Select image source',
              fontSize: 18,
            ),
            actions: [
              CupertinoDialogAction(
                child: const MyText.deepBlue('Camera'),
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
              ),
              CupertinoDialogAction(
                child: const MyText.deepBlue('Gallery'),
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          )
        : AlertDialog(
            title: const MyText.warmPrimary(
              'Select image source',
              fontSize: 18,
            ),
            actions: [
              TextButton(
                child: const MyText.deepBlue('Camera'),
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
              ),
              TextButton(
                child: const MyText.deepBlue('Gallery'),
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          );
  }
}
