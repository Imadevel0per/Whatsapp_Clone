import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: image != null
                        ? Image.file(
                            image!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/settingPhoto/img.png',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    right: 0.0,
                    top: 110.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 20,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 8,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.fromLTRB(
                                    24.0, 24.0, 16.0, 16.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.26,
                                child: Column(
                                  //runAlignment: WrapAlignment.center,
                                  //direction: Axis.vertical,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Profile photo',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(Icons.delete),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: IconButton(
                                                onPressed: () => pickImage(
                                                    ImageSource.camera),
                                                icon: const Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.teal,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            const Text(
                                              'Camera',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 32),
                                        Column(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: IconButton(
                                                onPressed: () => pickImage(
                                                    ImageSource.gallery),
                                                icon: const Icon(
                                                  Icons.insert_photo_outlined,
                                                  color: Colors.teal,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            const Text(
                                              'Gallery',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ListTile(
              //isThreeLine: true,
              leading: const Icon(Icons.person),
              title: Container(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Name',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Imad',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'This is not your user name or pin. '
                  'This name will be visible to your whatsapp contacts',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              trailing: const Icon(
                Icons.edit,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8.0),
            ListTile(
              //isThreeLine: true,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.info_outlined),
                ],
              ),
              title: Container(
                width: 100,
                child: const Text(
                  'About',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              subtitle:
                const Text(
                  'Hey there! I am using Whatsapp. ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              trailing: const Icon(
                Icons.edit,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8.0),
            ListTile(
              //isThreeLine: true,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.call),
                ],
              ),
              title: Container(
                width: 100,
                child: const Text(
                  'Phone',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              subtitle:
              const Text(
                '+000 000000000',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
