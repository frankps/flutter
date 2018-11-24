import 'package:firebase1/model/basemodel.dart';

class Note extends BaseModel {
  String _title;
  String _description;

  Note();

  Note.fromValues(this._title, this._description);

  Note.fromValuesWithId(String id, this._title, this._description) {
    super.id = id;
  }

  Note.map(dynamic obj) {
    this.id = obj['id'];
    this._title = obj['title'];
    this._description = obj['description'];
  }

  String get title => _title;
  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = _title;
    map['description'] = _description;

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
  }

  Note fromMap(Map<String, dynamic> map) {
    var note = new Note();

    note.id = map['id'];
    note._title = map['title'];
    note._description = map['description'];

    return note;
  }

  Note createNew() {
    return Note();
  }
}
