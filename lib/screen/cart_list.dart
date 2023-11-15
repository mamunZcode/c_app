
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../component/my_item.dart';
import '../state/all_problems.dart';
import 'home_screen.dart';
import 'item_view.dart';

class CartList extends StatelessWidget {
  final ViewType viewType;

  const CartList({super.key, required this.viewType});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<AllProblems>(
      builder: (context, data, child) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: viewType == ViewType.grid
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: data.problems?.chapters?.length ?? 0,
                  itemBuilder: (context, index) {
                    return MyGridItem(
                        chapters: data.problems?.chapters![index],
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemView(
                                        index: index,
                                      )));
                        });
                  },
                )
              : ListView.builder(
                  itemCount: data.problems?.chapters?.length ?? 0,
                  itemBuilder: (context, index) {
                    return MyListItem(
                        chapters: data.problems?.chapters![index],
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemView(
                                        index: index,
                                      )));
                        });
                  }),
        );
      },
    ));
  }
}
