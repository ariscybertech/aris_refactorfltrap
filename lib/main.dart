import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refactor_flutter_aps/home/home_view.dart';
import 'package:refactor_flutter_aps/provider/user_context.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => UserContext(),
      child: const MaterialApp(
        home: HomeView(),
      ),
    );
  }
}
