import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/theme_map.dart';
import 'package:path_provider/path_provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  static const id = 'setting_screen';

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _selected = '';
  String _cacheSize = '';
  bool _enableCodeCopy = true;
  List<String> _items = themeMap.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('UI Settings'),
            tiles: [
              SettingsTile.navigation(
                title: Text('Code Viewer Theme'),
                leading: Icon(Icons.code),
                description: Text('Select your code viewer theme'),
                trailing: Text(_selected),
                onPressed: (context) {
                  print('object');
                  showModal(context);
                },
              ),
              SettingsTile.switchTile(
                title: Text("Enable code copy"),
                description: Text("Enable copy code from code viewer"),
                leading: Icon(Icons.copy),
                initialValue: _enableCodeCopy,
                onToggle: (bool value) {
                  setState(() {
                    _enableCodeCopy = value;
                  });
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setBool('enable_code_copy', value);
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('General Settings'),
            tiles: [
              SettingsTile.navigation(
                enabled: _cacheSize != '0.00 MB',
                leading: Icon(Icons.clear_all),
                title: Text('Clear Cache'),
                description: Text('Clear all cache'),
                trailing: Text(_cacheSize),
                onPressed: (context) async {
                  await deleteCacheFiles();
                  await deleteDocumentFiles();
                  _calculateCacheSize().then((value) => {
                        setState(() {
                          _cacheSize = formatSize(value);
                        })
                      });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _loadSelectedTheme();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _enableCodeCopy = prefs.getBool('enable_code_copy') ?? true;
      });
    });
    _calculateCacheSize().then((value) => {
          setState(() {
            _cacheSize = formatSize(value);
          })
        });
  }

  void showModal(context) {
    showModalBottomSheet(
        clipBehavior: Clip.hardEdge,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.center,
            child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (context, int) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_items[index],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: (_selected == _items[index])
                                    ? Colors.blue
                                    : Colors.black)),
                      ),
                      onTap: () async {
                        setState(() {
                          _selected = _items[index];
                        });
                        // obtain shared preferences
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            'code_viewer_theme', _items[index]);
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }

  void _loadSelectedTheme() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _selected = prefs.getString('code_viewer_theme') ?? 'default';
      });
    });
  }

  Future<int> _calculateCacheSize() async {
    if (kIsWeb) return 0;
    int cacheSize = 0;
    int docDirSize = 0;
    cacheSize = await calculateCacheSize();
    docDirSize = await calculateDocumentDirSize();
    print('Cache Size: $cacheSize');
    print('Document Dir Size: $docDirSize');
    return cacheSize + docDirSize;
  }

  Future<int> calculateCacheSize() async {
    Directory appCacheDir = await getTemporaryDirectory();
    int cacheSize = 0;
    if (appCacheDir.existsSync()) {
      List<FileSystemEntity> files = appCacheDir.listSync(recursive: true);
      for (FileSystemEntity file in files) {
        if (file is File) {
          cacheSize += await file.length();
        }
      }
    }
    return cacheSize;
  }

  Future<int> calculateDocumentDirSize() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    int docDirSize = 0;
    if (appDocDir.existsSync()) {
      List<FileSystemEntity> files = appDocDir.listSync(recursive: true);
      for (FileSystemEntity file in files) {
        if (file is File) {
          docDirSize += await file.length();
        }
      }
    }
    return docDirSize;
  }

  String formatSize(int sizeInBytes) {
    double sizeInMB = sizeInBytes / (1024 * 1024);
    return sizeInMB.toStringAsFixed(2) + ' MB';
  }

  Future<void> deleteCacheFiles() async {
    Directory cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> deleteDocumentFiles() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    if (docDir.existsSync()) {
      docDir.deleteSync(recursive: true);
    }
  }
}
