import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  void tooglePannel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
  Widget contact(String urlImage, String title, icon, welcome, String day,
      success, time, IconData iconDirection, Color color, context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => callInfo(urlImage, title, welcome, day,
                    success, time, iconDirection, color, context)),
          );
        },
        leading: Container(
          height: 60,
          width: 60,
          child: ClipOval(
            child: Image.asset(
              urlImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(title),
        subtitle: Row(
          children: [
            Icon(
              //Icons.south_west_outlined,
              iconDirection,
              size: 20,
              color: color,
            ),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              day,
            ),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              time,
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => callHappening(
                        urlImage,
                        title,
                      )),
            );
          },
          icon: icon,
        ),
      ),
    );
  }

  Widget callInfo(
      String urlImage,
      String title,
      String welcome,
      String day,
      String success,
      String time,
      IconData iconDirection,
      Color color,
      context) {
    // clickContact
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text('Call info'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.chat),
          ),
          Icon(Icons.more_vert),
        ],
      ),
      body: Container(
        height: 180,
        padding: const EdgeInsets.only(right: 16.0, left: 8.0, top: 16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: ClipOval(
                      child: Image.asset(
                        urlImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Icon(
                    iconDirection,
                    color: color,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            welcome,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.call,
                            color: Colors.teal,
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Icon(
                            Icons.videocam,
                            color: Colors.teal,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(color: Colors.grey),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    day,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    success,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(time),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomSheet(String urlImage, String title) {
    bool iconPane = false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                tooglePannel();
                setState(() {
                  iconPane = true;
                });
              },
              icon: iconPane == false
                  ? const Icon(
                      Icons.expand_less,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.volume_down_rounded,
                color: Colors.white,
              ),
              const Icon(
                Icons.videocam,
                color: Colors.grey,
              ),
              const Icon(
                Icons.mic_off,
                color: Colors.white,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.call_end,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              const Divider(
                height: 4,
              ),
              const SizedBox(
                height: 8,
              ),
              const ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.teal,
                  child: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                ),
                title: Text('Add participant'),
                trailing: Icon(Icons.more_vert),
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                leading: Container(
                  height: 42,
                  width: 42,
                  child: ClipOval(
                    child: Image.asset(
                      urlImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: Text(title),
                trailing: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final PanelController panelController = PanelController();

  Widget callHappening(String urlImage, String title) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/callBackground.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: ClipOval(
                        child: Image.asset(
                          urlImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      'Calling',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SlidingUpPanel(
                    maxHeight: 300.0,
                    controller: panelController,
                    color: const Color.fromRGBO(69, 90, 100, 1),
                    panel: buildBottomSheet(urlImage, title),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8.0)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          contact(
              'assets/10.jpg',
              'Bro Ayoub',
              const Icon(
                Icons.call,
                color: Colors.teal,
              ),
              'Hi, am using whatsapp',
              'Just now',
              'Missed',
              '04:25',
              Icons.south_west_outlined,
              Colors.red,
              context),
          contact(
              'assets/20.jpg',
              'Anas',
              const Icon(
                Icons.call,
                color: Colors.teal,
              ),
              'Can\'t talk whatsapp only',
              '50 minute ago',
              'Incoming',
              '17:25',
              Icons.south_west_outlined,
              Colors.green,
              context),
          contact(
              'assets/30.jpg',
              'Ayman',
              const Icon(
                Icons.videocam,
                color: Colors.teal,
              ),
              'Busy',
              'yesterday',
              'Incoming',
              '15:40',
              Icons.south_west_outlined,
              Colors.green,
              context),
          contact(
              'assets/40.jpg',
              'Adam',
              const Icon(
                Icons.call,
                color: Colors.teal,
              ),
              'In a meeting',
              'yesterday',
              'Missed',
              '09:25',
              Icons.south_west_outlined,
              Colors.red,
              context),
          contact(
              'assets/60.jpg',
              'Yassine',
              const Icon(
                Icons.call,
                color: Colors.teal,
              ),
              'Available',
              'yesterday',
              'Incoming',
              '22:03',
              Icons.south_west_outlined,
              Colors.green,
              context),
          contact(
              'assets/70.jpg',
              'Hamid',
              const Icon(
                Icons.videocam,
                color: Colors.teal,
              ),
              'Battery about to die',
              '15/3/22',
              'Incoming',
              '11:25',
              Icons.south_west_outlined,
              Colors.green,
              context),
          contact(
              'assets/80.jpg',
              'Achraf',
              const Icon(
                Icons.videocam,
                color: Colors.teal,
              ),
              'At the gym',
              'yesterday',
              'Missed',
              '19/4/22',
              Icons.south_west_outlined,
              Colors.red,
              context),
          contact(
              'assets/70.jpg',
              'Islam',
              const Icon(
                Icons.call,
                color: Colors.teal,
              ),
              'At school',
              '22/4/22',
              'Incoming',
              '11:25',
              Icons.south_west_outlined,
              Colors.green,
              context),
        ],
      ),
    );
  }
}
