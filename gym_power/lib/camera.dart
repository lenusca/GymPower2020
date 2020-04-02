import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class Camera extends StatefulWidget {
  static String tag = "camera";
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  String result = "";
  String url = "";
  String name = "";

  
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        url = result.split("\n")[1];
        name = result.split("\n")[0];
        print(url);
        print(name);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    print(url);
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(name, style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 20, fontWeight: FontWeight.w400),),
              ),

              result.toString().isEmpty?Text(""):Container(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),




                    child:YoutubePlayer(

                      controller: YoutubePlayerController(

                          initialVideoId: YoutubePlayer.convertUrlToId(url)
                      ),
                    ),

              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        backgroundColor: Colors.deepOrangeAccent[200],
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
