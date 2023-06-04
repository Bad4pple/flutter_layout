import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idk/pages/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organization"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // var data = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemBuilder: (context, index) {
                return MyBox(snapshot.data[index]["title"], snapshot.data[index]["subtitle"], snapshot.data[index]["image_url"], snapshot.data[index]["content"]);
            }, itemCount: snapshot.data.length,);
          },
          future: getData(),
          // future: DefaultAssetBundle.of(context).loadString("assets/data.json"),

        )
      ),
    );
  }
Widget MyBox(String title, String subtitle, String image_url, String content) {
  return Container(
    padding: EdgeInsets.all(20),
    margin: EdgeInsets.only(top: 20),
    height: 150,
    decoration: BoxDecoration(
      color: Colors.red.shade100,
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        image: NetworkImage(image_url),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.darken)
      ),
    ),
    child:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
        Text(subtitle, style: const TextStyle(fontSize: 15, color: Colors.white60),),
        SizedBox(height: 9,),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(title,subtitle,image_url,content),));
          },
          child: Text("Read more")
        )
      ],
    ),
  );
}

Future getData() async {
  var url = Uri.https("raw.githubusercontent.com","/Bad4pple/flutter_layout/main/assets/data.json");
  var response = await http.get(url);
  var result = json.decode(response.body);
  return result; 
}

}
