import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:refactor_flutter_aps/add/ogrenci_provider.dart';
import 'package:refactor_flutter_aps/add/student_ekle_view.dart';
import 'package:refactor_flutter_aps/provider/user_context.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ResourceModel? resourceModel;
  String? title;
  bool isLoading = false;

  Future<void> fetchItems() async {
    setState(() {
      isLoading = true;
    });
    final response = await Dio().get('https://reqres.in/api/unknown');

    setState(() {
      resourceModel = ResourceModel.fromJson(response.data);
      isLoading = false;
    });
  }

  Future<void> pageNumber() async {
    final prefences = await SharedPreferences.getInstance();
    if (resourceModel!.page! > 1) {
      int x = resourceModel!.page!;
      int y = context.read<UserContext>().user?.age ?? 0;
      await prefences.setInt("name", x * y);
      setState(() {
        title = x.toString();
      });
    }

    setState(() {
      title = resourceModel!.support!.text;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('add'),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ChangeNotifierProvider(
                builder: (context, child) => StudentAddView(),
                create: (context) {
                  return OgrenciProvider();
                },
              );
            },
          ));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ...resourceModel!.data!.map((e) {
              return Card(
                child: ListTile(
                  leading: Container(
                    width: 10,
                    color: HexColor(e.color!),
                  ),
                  // leading: Container(
                  // color: Color(int.parse('FF${resourceModel!.data![index].color!.replaceAll('#', '')}', radix: 16))),
                  title: Text(e.name.toString()),
                ),
              );
            }).toList(),
            Text(
              'data',
              style: TextStyle(fontSize: 35),
            ),
            Divider(thickness: 5),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Text('a');
              },
            ),
            OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Text('Helloi');
                    },
                  );
                },
                child: Text('Show')),
            Text(
              'Heyo',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),
            ),
            TextButton(
                onPressed: () {
                  launch("https://pub.dev/packages/url_launcher");
                },
                child: Text("Open Web")),
            TextButton(
                onPressed: () {
                  launch("tel:+1 555 010 999");
                },
                child: Container(
                    height: 46,
                    child: Center(
                        child: Text(
                      'call',
                      style: TextStyle(color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(23)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x65ff6969), offset: Offset(0, 5), blurRadius: 10, spreadRadius: 0)
                        ],
                        color: Colors.red))),
            TextButton(
                onPressed: () {
                  launch("tel:+1 555 010 999");
                },
                child: Container(
                    height: 46,
                    child: Center(
                        child: Text(
                      'call',
                      style: TextStyle(color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(23)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x65ff6969), offset: Offset(0, 5), blurRadius: 10, spreadRadius: 0)
                        ],
                        color: Colors.red)))
          ],
        ),
      ),
    );
  }
}
