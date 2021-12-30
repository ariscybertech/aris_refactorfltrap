import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:refactor_flutter_aps/add/ogrenci_provider.dart';

class StudentAddView extends StatefulWidget {
  const StudentAddView({Key? key}) : super(key: key);

  @override
  _StudentAddViewState createState() => _StudentAddViewState();
}

class _StudentAddViewState extends State<StudentAddView> {
  TextEditingController? editingController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<OgrenciProvider>().backgroundColor ?? Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<OgrenciProvider>().degistirColor();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: editingController,
            onTap: () {
              editingController ??= TextEditingController();
            },
          ),
          TextButton(
              onPressed: () {
                context.read<OgrenciProvider>().title = editingController!.text;
                context.read<OgrenciProvider>().kayitAdd();
                Navigator.pop(context);
              },
              child: Text('kayit et'))
        ],
      ),
    );
  }
}
