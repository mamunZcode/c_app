class Problems {
  List<Chapters>? _chapters;

  Problems({List<Chapters>? chapters}) {
    if (chapters != null) {
      this._chapters = chapters;
    }
  }
  List<Chapters>? get chapters => _chapters;
  set chapters(List<Chapters>? chapters) => _chapters = chapters;
  Problems.fromJson(Map<String, dynamic> json) {
    if (json['chapters'] != null) {
      _chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        _chapters!.add(new Chapters.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._chapters != null) {
      data['chapters'] = this._chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Chapters {
  String? _id;
  String? _title;
  String? _primaryColor;
  String? _secondaryColor;
  List<Questions>? _questions;
  Chapters(
      {String? id,
      String? title,
      String? primaryColor,
      String? secondaryColor,
      List<Questions>? questions}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (primaryColor != null) {
      this._primaryColor = primaryColor;
    }
    if (secondaryColor != null) {
      this._secondaryColor = secondaryColor;
    }
    if (questions != null) {
      this._questions = questions;
    }
  }

  String? get id => _id;

  set id(String? id) => _id = id;

  String? get title => _title;

  String? get primaryColor => _primaryColor;

  String? get secondaryColor => _secondaryColor;

  set title(String? title) => _title = title;

  set primaryColor(String? primaryColor) => _primaryColor = primaryColor;

  set secondaryColor(String? secondaryColor) =>
      _secondaryColor = secondaryColor;

  List<Questions>? get questions => _questions;

  set questions(List<Questions>? questions) => _questions = questions;

  Chapters.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _primaryColor = json['primaryColor'];
    _secondaryColor = json['secondaryColor'];
    if (json['questions'] != null) {
      _questions = <Questions>[];
      json['questions'].forEach((v) {
        _questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['primaryColor'] = this._primaryColor;
    data['secondaryColor'] = this._secondaryColor;
    if (this._questions != null) {
      data['questions'] = this._questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? _id;
  String? _title;

  Questions({int? id, String? title}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  String? get title => _title;

  set title(String? title) => _title = title;

  Questions.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    return data;
  }
}
