import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/theme_map.dart';
import 'package:flutter_highlighter/themes/default.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CodeViewer extends StatefulWidget {
  String fileName;
  CodeViewer({super.key, required this.fileName});
  @override
  State<CodeViewer> createState() => _CodeViewerState();
}

class _CodeViewerState extends State<CodeViewer>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final ExpansionTileController controller = ExpansionTileController();
  String code = '';
  String codeViewTheme = 'default';
  bool enableCodeCopy = true;
  late AnimationController animationController;
  late Animation<double> animation;

  void setCodeViewTheme(String value) {
    setState(() {
      codeViewTheme = value;
    });
  }

  void setCode(String value) {
    setState(() {
      code = value;
    });
  }

  Future<String> loadCodeFile() async {
    if (kIsWeb) {

      final uri = Uri.parse(
          'https://raw.githubusercontent.com/mamunZcode/100cProblems/main/${widget.fileName}.c');
      String fileContent = '';
      try {
        final response = await http.get(uri);

        if (response.statusCode == 200) {
          setState(() {
            fileContent = response.body;
          });
        } else {
          // Handle errors, e.g., file not found, unauthorized, etc.
          fileContent = 'Failed to load the file';
        }
      } catch (e) {
        // Handle network errors
        fileContent = 'Network error: $e';
      }
      return fileContent;
    }
    Directory directory = await getApplicationDocumentsDirectory();
    File file =
        File('${directory.path}/101CProblemSolution/${widget.fileName}.c');
    return file.readAsStringSync();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..forward()
      ..repeat(reverse: true);
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        codeViewTheme = prefs.getString('code_viewer_theme') ?? 'default';
        enableCodeCopy = prefs.getBool('enable_code_copy') ?? true;
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (code.isEmpty) {
      loadCodeFile().then((value) => {
            if (context.mounted) {setCode(value)}
          });
    }

    return Container(
        alignment: Alignment.topLeft,
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          controller: controller,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                AnimatedIcon(
                  progress: animation,
                  icon: AnimatedIcons.add_event,
                  size: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Code:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width),
                    child: HighlightView(
                      code,
                      language: 'c',
                      padding: const EdgeInsets.all(8.0),
                      theme: themeMap[codeViewTheme] ?? defaultTheme,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
                enableCodeCopy
                    ? Positioned(
                        bottom: 8.0, // Adjust as needed for your layout
                        right: -8.0, // Adjust as needed for your layout
                        child: MaterialButton(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          shape: const CircleBorder(),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: code));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Copied to Clipboard'),
                              ),
                            );
                          },
                          child: const Icon(Icons.copy, size: 16.0),
                        ))
                    : Container(),
              ],
            )
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
