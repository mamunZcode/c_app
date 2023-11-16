import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../component/code_viewer.dart';
import '../model/problems.dart';
import '../state/all_problems.dart';

class ItemView extends StatefulWidget {
  static const id = 'item_view';
  final int index;

  const ItemView({Key? key, required this.index}) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final ExpansionTileController controller = ExpansionTileController();
  final ExpansionTileController controller1 = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AllProblems>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            data.getProblems!.chapters?[widget.index].title
                    ?.replaceAll("\n", ' ') ??
                '',
            style: const TextStyle(fontSize: 16, fontFamily: 'mono'),
          ),
        ),
        body: ListView.builder(
          itemCount:
              data.getProblems!.chapters?[widget.index].questions?.length,
          itemBuilder: (BuildContext context, int index) {
            Questions? questions =
                data.getProblems!.chapters![widget.index].questions?[index];
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListTile(
                    title: Container(
                      color: Colors.purpleAccent.withOpacity(0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Problem ${questions?.id}:',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'mono'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              questions?.title ?? '',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'mono'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(4),
                    subtitle: CodeViewer(
                      key: Key(index.toString()),
                      fileName: questions!.id.toString(),
                    ),
                  ),
                ));
          },
        ),
      );
    });
  }
}
