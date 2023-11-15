
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../model/problems.dart';

class AllProblems extends ChangeNotifier {
  Problems? problems;

  Problems? get getProblems => problems;

  AllProblems() {
    loadData();
  }

  loadData() async {
    debugPrint('loadData');
    String jsonString = await rootBundle.loadString('assets/problems.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    problems = Problems.fromJson(jsonData);
    notifyListeners();
  }
}
