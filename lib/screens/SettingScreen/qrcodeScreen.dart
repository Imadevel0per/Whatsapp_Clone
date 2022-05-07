import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/SettingScreen/myCodeScreen.dart';
import 'package:whatsapp_clone/screens/SettingScreen/scanCodeScreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  bool currentTab = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'QR Code',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await Share.share('This my QR Code');
              },
              icon: const Icon(Icons.share, color: Colors.black),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert, color: Colors.black),
            ),
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 3,
            indicatorColor: Colors.teal,
            labelColor: Colors.black,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              const Tab(
                text: 'MY CODE',
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScanCodeScreen()));
                },
                child: const Tab(
                  text: 'SCAN CODE',
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            //TODO: Build MyCodeScreen
            MyCodeScreen(),
            //TODO: Build ScanCodeScreen
            ScanCodeScreen(),
          ],
        ),
      ),
    );
  }
}
