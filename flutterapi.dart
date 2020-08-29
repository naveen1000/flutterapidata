import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(
    MaterialApp(
      home : Home(),
    )
  );
}
class WorldTime {

  String id; // location name for UI
  String title; // the time in that location

  WorldTime({ this.id, this.title });
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter = 1;
  Map data = {};

    List<WorldTime> locations = [
    WorldTime(id: '1', title: 'click + to get data by data'),
  ];


  void getData(int counters) async{
    Response response = await get('https://jsonplaceholder.typicode.com/todos/$counters');
    Map datas = jsonDecode(response.body);
    print(counters);
    print(datas);
    locations.add(WorldTime(id: datas['id'].toString(), title: datas['title']));
    setState(() {
      data = jsonDecode(response.body);
      counter = counters + 1;
    });
    print(locations.length);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Get data from API +',
          style: TextStyle(
            fontSize: 20.0,
          ),
          ),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return ListTile(
                onTap: () {},
                title: Text(locations[index].title),
                );
        },
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getData(counter);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
