import 'dart:async';

import 'package:blocstate/models/contact.dart';

class ContactBloc {
  final List<Contact> _contactList = [
    Contact("Nanda", "assets/images/iconapp.png", "sweet"),
    Contact("Adi", "assets/images/iconapp.png", "sweet"),
    Contact("Saputra", "assets/images/iconapp.png", "sweet"),
    Contact("Biyan", "assets/images/iconapp.png", "sweet"),
    Contact("David",  "assets/images/iconapp.png", "sweet"),
  ];
  final _contactListStreamController = StreamController<List<Contact>>();
  final _deleteTapStreamController = StreamController<Contact>();

  Stream<List<Contact>> get contactListStream =>
      _contactListStreamController.stream;

  StreamSink<List<Contact>> get contactListSink =>
      _contactListStreamController.sink;

  StreamSink<Contact> get deleteTapSink => _deleteTapStreamController.sink;

  ContactBloc() {
    _contactListStreamController.add(_contactList);
    _deleteTapStreamController.stream.listen(_onTapDelete);
  }

  _onTapDelete(Contact contact) {
    _contactList.remove(contact);
    contactListSink.add(_contactList);
  }
  void dispose(){
    _contactListStreamController.close();
    _deleteTapStreamController.close();
  }
}
