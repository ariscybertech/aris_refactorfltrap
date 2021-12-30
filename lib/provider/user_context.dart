import 'package:flutter/cupertino.dart';

class UserContext extends ChangeNotifier {
  User? user;
}

class User {
  String? name;

  final String surname;

  int age = 15;

  User(this.surname, {this.name});
}
