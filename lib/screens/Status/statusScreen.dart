import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_view/story_view.dart';
import 'package:whatsapp_clone/models/models.dart';
import 'package:dotted_border/dotted_border.dart';
import 'storyItemScreen.dart';
import 'storyListScreen.dart';


enum MenuItem { item1, item2, item3, item4 }

class Home extends StatefulWidget {
  final Function(StoryItemm) onCreate;

  final Function(StoryItemm) onUpdate;

  final StoryItemm? originalItem;

  final bool isUpdating;

  const Home(
      {Key? key,
      required this.onCreate,
      required this.onUpdate,
      this.originalItem,
      isUpdating})
      : isUpdating = (originalItem != null),
        super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textStatController = TextEditingController();
  String _textPhoto = '';
  File? _image;

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _textStatController.text = originalItem.textStat;
      _textPhoto = originalItem.textStat;
      _image = image;
      //_currentColor = originalItem.color;
    }
    _textStatController.addListener(() {
      setState(() {
        _textPhoto = _textStatController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textStatController.dispose();
    super.dispose();
  }

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

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 12,
            right: 12,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.black12,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black45,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.teal,
                  child: IconButton(
                    onPressed: () {
                      pickImage(ImageSource.camera); //

                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 1,
            margin: const EdgeInsets.all(
              16.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Consumer<StoryManager>(
                    builder: (context, manager, child) {
                      if (manager.storyItems.isEmpty) {
                        return ListTile(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StoryItemScreen(
                                            onCreate: (item) {
                                              manager.addItem(item);
                                              Navigator.pop(
                                                  context);
                                            },
                                            onUpdate: (item) {})));
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: Stack(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/50.jpg',
                                  height: 56,
                                  width: 56,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: 33.0,
                                top: 32.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 12,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.teal,
                                    radius: 10,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StoryItemScreen(
                                                        onCreate: (item) {
                                                          manager.addItem(item);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        onUpdate: (item) {})));
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: const Text(
                            'My Status',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          subtitle: const Text('Tap to add status update'),
                        );
                      } else {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StoryListScreen(manager: manager)));
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blueAccent,
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/50.jpg',
                                  height: 48,
                                  width: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          title: const Text(
                            'My Status',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          subtitle: const Text('Just now'),
                          trailing: PopupMenuButton<MenuItem>(
                            onSelected: (value){
                              if(value == MenuItem.item4) {
                                manager.deleteItem(0);
                              }
                            },
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                value: MenuItem.item1,
                                child: ListTile(
                                  title: Text('Forward'),
                                ),
                              ),
                              const PopupMenuItem(
                                value: MenuItem.item2,
                                child: ListTile(
                                  title: Text('Share...'),
                                ),
                              ),
                              const PopupMenuItem(
                                value: MenuItem.item3,
                                child: ListTile(
                                  title: Text('Share to Facebook'),
                                ),
                              ),
                              const PopupMenuItem(
                                value: MenuItem.item4,
                                child: ListTile(
                                  title: Text('Delete'),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MoreStories()));
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: DottedBorder(
                          color: Colors.blueAccent,
                          borderType: BorderType.Circle,
                          radius: const Radius.circular(28),
                          dashPattern: const [50, 4],
                          strokeWidth: 2,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blueAccent,
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/40.jpg',
                                  height: 48,
                                  width: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        title: const Text(
                          'Anas',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: const Text('54 minutes'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Viewed updates',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MoreStories2()));
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: DottedBorder(
                          color: Colors.grey,
                          borderType: BorderType.Circle,
                          radius: const Radius.circular(28),
                          dashPattern: const [50, 4],
                          strokeWidth: 2,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/80.jpg',
                                  height: 48,
                                  width: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        title: const Text(
                          'Ayoub',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: const Text('Yesterday, 18:25'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MoreStories3()));
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: DottedBorder(
                          color: Colors.grey,
                          borderType: BorderType.Circle,
                          radius: const Radius.circular(28),
                          dashPattern: const [50, 4],
                          strokeWidth: 2,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/90.jpg',
                                  height: 48,
                                  width: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        title: const Text(
                          'Achraf',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: const Text('Today, 16:10'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoreStories extends StatefulWidget {
  const MoreStories({Key? key}) : super(key: key);

  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.pageImage(
            url:
                "https://cdn.pixabay.com/photo/2016/01/27/04/32/books-1163695__340.jpg",
            caption: "I love reading books especially here",
            controller: storyController,
          ),
          StoryItem.pageImage(
              url:
                  "https://cdn.pixabay.com/photo/2018/02/04/21/13/monastery-3130879__340.jpg",
              caption: "how much this is beautiful",
              controller: storyController),
          StoryItem.pageImage(
            url:
                "https://cdn.pixabay.com/photo/2016/08/02/10/32/bluebell-1562995__340.jpg",
            caption: "Hello, from the other side",
            controller: storyController,
          ),
        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          Navigator.pop(context);
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}

class MoreStories2 extends StatefulWidget {
  const MoreStories2({Key? key}) : super(key: key);

  @override
  State<MoreStories2> createState() => _MoreStories2State();
}

class _MoreStories2State extends State<MoreStories2> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.pageImage(
            url:
                "https://cdn.pixabay.com/photo/2017/11/19/13/03/panorama-2962730__340.jpg",
            caption: "The history",
            controller: storyController,
          ),
          StoryItem.pageImage(
              url:
                  "https://cdn.pixabay.com/photo/2018/02/03/20/23/mammal-3128440__340.jpg",
              caption: "Without comment",
              controller: storyController),
          StoryItem.pageImage(
            url:
                "https://cdn.pixabay.com/photo/2018/10/18/04/56/book-3755514__340.jpg",
            caption: "Everything have a sound",
            controller: storyController,
          ),
        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          Navigator.pop(context);
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}

class MoreStories3 extends StatefulWidget {
  const MoreStories3({Key? key}) : super(key: key);

  @override
  State<MoreStories3> createState() => _MoreStories3State();
}

class _MoreStories3State extends State<MoreStories3> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.pageImage(
            url:
                "https://cdn.pixabay.com/photo/2021/01/19/14/45/alley-5931413__340.jpg",
            caption: "New place = new culture",
            controller: storyController,
          ),
          StoryItem.pageImage(
              url:
                  "https://cdn.pixabay.com/photo/2017/06/21/19/35/head-2428333__340.png",
              caption: "Don't think more than the need",
              controller: storyController),
          StoryItem.pageImage(
            url:
                "https://cdn.pixabay.com/photo/2016/02/02/18/33/sphinx-1175828__340.jpg",
            caption: "In a special place ",
            controller: storyController,
          ),
        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          Navigator.pop(context);
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}
