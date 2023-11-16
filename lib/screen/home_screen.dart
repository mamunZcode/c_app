import 'dart:io';
import 'package:archive/archive.dart';
import 'package:c_app/screen/setting-screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../service/firebase_auth_methods.dart';
import 'cart_list.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ViewType viewType = ViewType.grid;

  Future<void> downloadAndExtractZip() async {
    // Don't run this function if you're on the web
    if (kIsWeb) {
      return;
    }

    final directoryPath = await getApplicationDocumentsDirectory();
    final filePath = '${directoryPath.path}/101CProblemSolution';
    final directory = Directory(filePath);

    if (directory.existsSync()) {
      debugPrint("The directory exists");
      return;
    }
    //if directory does not exists download and extract zip
    Map<String, String> header = {
      "Authorization":
      "token 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",
    };
    const url =
        'https://api.github.com/repos/mostasim/101CProblemSolution/zipball/';
    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      final Uint8List bytes = response.bodyBytes;

      // Create a temporary directory to extract the contents
      final directory = await getApplicationDocumentsDirectory();
      final tempZipFile = File('${directory.path}/temp.zip');
      await tempZipFile.writeAsBytes(bytes);

      // Extract the zip file
      final zipFile = ZipDecoder().decodeBytes(tempZipFile.readAsBytesSync());
      for (final file in zipFile) {
        var fileName = '${directory.path}/${file.name}';
        debugPrint("file Name: $fileName");
        if (file.isFile) {
          final data = file.content as List<int>;
          final extractedFile = File(fileName);
          await extractedFile.writeAsBytes(data);
        } else {
          await Directory(fileName).create(recursive: true);
        }
      }
      // Rename the directory and delete the temp zip file
      directory.listSync().forEach((element) {
        if (element is Directory) {
          if (element.path.contains("mostasim-101CProblemSolution-")) {
            element.renameSync('${directory.path}/101CProblemSolution');
          }
        } else if (element is File) {
          if (element.path.contains("temp.zip")) {
            element.deleteSync();
            debugPrint("temp.zip deleted");
          }
        }
      });

      print('Zip file downloaded and extracted successfully.');
    } else {
      print('Failed to download the zip file.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          '101 C Problems',
          style: TextStyle(fontFamily: 'mono',),
        ),
        // Add a menu button to the AppBar
        actions: [
          IconButton(
            icon: (viewType == ViewType.grid)
                ? const Icon(Icons.grid_view)
                : const Icon(Icons.view_list),
            onPressed: () {
              setState(() {
                viewType =
                    (viewType == ViewType.grid) ? ViewType.list : ViewType.grid;
              });
            },
          ),
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(Icons.menu_rounded))
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white60,
              ),
              curve: Curves.easeInQuad,
              child: Row(
                children: [
                  Icon(
                    Icons.menu_rounded,
                    color: Colors.grey,
                    size: 48,
                  ),
                  Text(
                    '101 C Problems',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, SettingScreen.id);
              },
            ),
            ListTile(
              title: Text('Devloper Info'),
              onTap: (){

              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: downloadAndExtractZip(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else {
            return CartList(viewType: viewType);
          }
        },
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    var currentUser = context
        .read<FirebaseAuthMethods>()
        .user; // Add a random string to the list
    var userId = currentUser.uid;

    // context.read<MyItemList>().listenToDocuments(userId);
  }
}

class ViewType {
  static const list = ViewType._('list');
  static const grid = ViewType._('grid');

  const ViewType._(this.value);

  final String value;
}
