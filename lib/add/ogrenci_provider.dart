import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refactor_flutter_aps/provider/user_context.dart';

class OgrenciProvider extends ChangeNotifier {
  String? title;
  BuildContext? context;
  Color? backgroundColor;
  Future<void> kayitAdd() async {
    final response = await Dio().post(
      'https://reqres.in/api/register',
      data: {"email": "$title"},
    );

    context?.read<UserContext>().user?.name = "new";
  }

  void degistirColor() {
    backgroundColor = Colors.white;
    notifyListeners();
  }

  // void back() {}
}
