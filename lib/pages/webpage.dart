import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_640710502/helpers/api_caller.dart';
import 'package:final_640710502/helpers/dialog_utils.dart';
import 'package:final_640710502/helpers/my_list_tile.dart';
import 'package:final_640710502/helpers/my_text_field.dart';
import 'package:final_640710502/models/todo_item.dart';
import 'package:flutter/material.dart';

class webpage extends StatefulWidget {
  const webpage({super.key});

  @override
  State<webpage> createState() => _webpageState();
}

class _webpageState extends State<webpage> {
  List<TodoItem> _todoItems = [];
  var _urlController = TextEditingController();
  var _detailController = TextEditingController();
  var _sendController = TextEditingController();

  @override
  void _getCountries() async {
    var dio = Dio(BaseOptions(responseType: ResponseType.plain));
    var response = await dio.get(
        'https://cpsu-api-49b593d4e146.herokuapp.com/api/2_2566/final/web_types');
    List list = jsonDecode(response.data);

    setState(() {
      _todoItems = list.map((e) => TodoItem.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Webby Fondue',style: TextStyle(color: Colors.white),),
    centerTitle: true,
    bottom: PreferredSize(
        child: Text("ระบบรายงานเว็บเลวๆ",style: TextStyle(color: Colors.white),),
        preferredSize: Size.zero),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            MyTextField(
              controller: _urlController,
              label: 'URL',
              hintText: 'URL *',
              onChanged: (value) {},
            ),
            SizedBox(height: 8.0),
            MyTextField(
              controller: _detailController,
              label: 'Detail',
              hintText: 'รายละเอียด',
              onChanged: (value) {},
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: _todoItems == null
                  ? SizedBox.shrink()
                  : ListView.builder(
                      itemCount: _todoItems!.length,
                      itemBuilder: (context, index) {
                        var item = _todoItems![index];

                        return MyListTile(
                          title: item.title!,
                          subtitle: item.subtitle!,
                          imageUrl:
                              'https://cpsu-api-49b593d4e146.herokuapp.com${item.image}',
                          selected: false,
                          onTap: () {
                            print('Item ${item.title} tapped');
                            showOkDialog(
                              context: context,
                              title: item.title!,
                              message: item.subtitle!,
                            );
                          },
                        );
                      },
                    ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      print('Button tapped');
                      showOkDialog(
                        context: context,
                        title: 'Success',
                        message: 'ส่งข้อมูลสําเร็จ',
                      );
                    },
                    child: const Text('ส่งข้อมูล',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }
}