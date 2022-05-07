import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/screens/Call/callScreen.dart';
import 'package:whatsapp_clone/screens/SettingScreen/setting.dart';
import 'components/searchBar.dart';
import 'models/storyManager.dart';
import 'screens/Status/statusScreen.dart';
import 'screens/Chat/chats.dart';

enum MenuItem { item1, item2, item3, item4, item5 }

class WhatsApp extends StatefulWidget {
  const WhatsApp({Key? key}) : super(key: key);

  @override
  State<WhatsApp> createState() => _WhatsAppState();
}

class _WhatsAppState extends State<WhatsApp> {
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
    final manager = Provider.of<StoryManager>(context, listen: false);

    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton<MenuItem>(
              onSelected: (value) {
                if (value == MenuItem.item5) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()),
                  );
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: MenuItem.item1,
                  child: ListTile(
                    title: Text('New group'),
                  ),
                ),
                const PopupMenuItem(
                  value: MenuItem.item2,
                  child: ListTile(
                    title: Text('New broadcast'),
                  ),
                ),
                const PopupMenuItem(
                  value: MenuItem.item3,
                  child: ListTile(
                    title: Text('Whatsapp web'),
                  ),
                ),
                const PopupMenuItem(
                  value: MenuItem.item4,
                  child: ListTile(
                    title: Text('Starred messages'),
                  ),
                ),
                const PopupMenuItem(
                  value: MenuItem.item5,
                  child: ListTile(
                    title: Text('Settings'),
                  ),
                )
              ],
            ),
          ],
          bottom: TabBar(
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                child: IconButton(
                  onPressed: () => pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                ),
              ),
              const Tab(
                text: 'CHATS',
              ),
              const Tab(
                text: 'STATUS',
              ),
              const Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(
              child: Text('This is Camera screen.'),
            ),
            const ChatScreen(),
            Home(
                onCreate: (item) {
                  manager.addItem(item);
                  Navigator.pop(context);
                },
                onUpdate: (item) {}),
            const CallScreen(),
          ],
        ),
      ),
    );
  }
}
