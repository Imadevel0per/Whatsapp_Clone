import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyCodeScreen extends StatelessWidget {
  const MyCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF7F8FA),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Container(
                    padding: const EdgeInsets.only(top: 50.0),
                    width: 300,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Imad',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Text(
                          'Whatsapp contact',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 30),
                        QrImage(
                          data: 'This is my whatsapp account qr code',
                          size: 200,
                          version: QrVersions.auto,
                          gapless: false,
                          embeddedImage:
                              const AssetImage('assets/settingPhoto/wtsappIcon.png'),
                          embeddedImageStyle: QrEmbeddedImageStyle(
                            size: const Size(40, 40),
                          ),
                        ),
                      ],
                    ),
                  ),

              const SizedBox(height: 16),
              const Text(
                'Your QR code is private. if you share it with \n '
                'someone, they can scan it with their whatsapp \n'
                'camera to add you as a contact',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Positioned(
            top: 70,
            child: Container(
              height: 60,
              width: 60,
              child: ClipOval(
                child: Image.asset(
                  'assets/settingPhoto/img.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
