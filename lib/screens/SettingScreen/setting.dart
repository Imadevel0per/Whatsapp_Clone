import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/SettingScreen/qrcodeScreen.dart';

import 'profile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        //padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                leading: Container(
                  height: 60,
                  width: 60,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/settingPhoto/img.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: const Text('Imad'),
                subtitle: const Text('Hey there! I am using whatsA...'),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QrCodeScreen()));
                  },
                  icon: const Icon(
                    Icons.qr_code_2_outlined,
                    size: 30,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 2,
            ),
            Container(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.vpn_key,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
                title: const Text('Account'),
                subtitle: const Text('Privacy, security, change number'),
              ),
            ),
            Container(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.chat,
                      color: Colors.grey,
                      //size: 30,
                    ),
                  ],
                ),
                title: const Text('Chats'),
                subtitle: const Text('Theme, wallpapers, chat history'),
              ),
            ),
            Container(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.notifications,
                      color: Colors.grey,
                      //size: 30,
                    ),
                  ],
                ),
                title: const Text('Notifications'),
                subtitle: const Text('Message, group & call tones'),
              ),
            ),
            Container(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.data_saver_off_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
                title: const Text('Storage and data'),
                subtitle: const Text('Network usage, auto-download'),
              ),
            ),
            Container(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.help_outline_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
                title: const Text('Help'),
                subtitle: const Text('Help center, contact us, privacy policy'),
              ),
            ),
            Container(
              child: const ListTile(
                leading: Icon(
                  Icons.people_outlined,
                  color: Colors.grey,
                  size: 30,
                ),
                title: Text('Invite a friend'),
              ),
            ),
            const SizedBox(height: 24.0),
            Column(
              children: [
                const Text(
                  'from',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 20,
                        width: 20,
                        child:
                            Image.asset('assets/settingPhoto/meta_icon.png')),
                    const SizedBox(width: 4),
                    const Text(
                      'Meta',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
