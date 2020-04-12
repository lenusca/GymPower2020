import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/loading.dart';
import 'package:http/http.dart' as http;

class Playlist extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  Future<List> getData() async{
    final response = await http.get("https://gympower.herokuapp.com");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot){

          if(snapshot.hasError){
            print(snapshot.error);
          }
          return snapshot.hasData? ListVideo(list: snapshot.data,):Loading();
        },
      ),
    );
  }
}

class ListVideo extends StatelessWidget {
  final List list;
  ListVideo({this.list});
  @override

  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null?0:list.length,
      itemBuilder: (context, index){
        return Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  height: 210.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(list[index]['snippet']['thumbnails']['high']['url']),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                onTap: ()=> Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPlay(url: "http://youtube.com/embed/${list[index]['contentDetails']['videoId']}",)
                )),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Text(list[index]['snippet']['title'], style: TextStyle(fontSize: 18.0),),
              Padding(padding: EdgeInsets.all(10.0)),
              Divider(),
            ],
          ),
        );
      }
    );
  }
}

class VideoPlay extends StatelessWidget {
  final String url;

  const VideoPlay({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebviewScaffold(
        url: url,
      ),
    );
  }
}

