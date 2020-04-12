import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gym_power/home.dart';

class Payment extends StatefulWidget {
  static String tag = "payment";
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int _cardNumber;
  int _cardDate;
  String _cardName = "";
  FlutterLocalNotificationsPlugin flutterLocalNotificationPugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initializationSettingsAndroid= new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationPugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationPugin.initialize(initializationSettings);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment", style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.deepOrangeAccent[200],
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed:(){
                Navigator.of(context).pushNamed(Home.tag);
              }
          )
        ],

      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 2, 25, 0),
        child: ListView(

          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade100,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.075),
                        offset: Offset(10, 10),
                        blurRadius: 10
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-10, -10),
                        blurRadius: 10
                    ),
                  ]
              ),
              child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('VISA', style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)),
                        Icon(Icons.more_horiz, color: Colors.grey.shade700,),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _cardNumber.toString().length<16?Text('* * * *', style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)):
                        Text(_cardNumber.toString().trim()[0]+_cardNumber.toString().trim()[1]+_cardNumber.toString().trim()[2]+_cardNumber.toString().trim()[3], style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)),
                        _cardNumber.toString().length<16?Text('* * * *', style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)):
                        Text(_cardNumber.toString().trim()[4]+_cardNumber.toString().trim()[5]+_cardNumber.toString().trim()[6]+_cardNumber.toString().trim()[7], style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)),
                        _cardNumber.toString().length<16?Text('* * * *', style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)):
                        Text(_cardNumber.toString().trim()[8]+_cardNumber.toString().trim()[9]+_cardNumber.toString().trim()[10]+_cardNumber.toString().trim()[11], style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)),
                        _cardNumber.toString().length<16?Text('* * * *', style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)):
                        Text(_cardNumber.toString().trim()[12]+_cardNumber.toString().trim()[13]+_cardNumber.toString().trim()[14]+_cardNumber.toString().trim()[15], style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Card Holder', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w700)),
                            _cardName==""?Text('Name', style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)):
                            Text(_cardName, style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Expires', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w700)),
                            _cardDate.toString().length<4?Text('00 / 00', style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)):
                            Text(_cardDate.toString().trim()[0]+_cardDate.toString().trim()[1]+"/"+_cardDate.toString().trim()[2]+_cardDate.toString().trim()[3], style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w700)),
                          ],
                        ),

                      ],
                    ),
                  ])
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
                    labelText: 'Card Holder'
                ),
                keyboardType: TextInputType.text,
                onChanged: (val) => setState(() => _cardName = val),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Icon(Icons.credit_card, color: Colors.grey),
                  ),
                  labelText: 'Card Number'
                ),
                keyboardType: TextInputType.number,
                maxLength: 16,
                onChanged: (val) => setState(() => _cardNumber = num.tryParse(val)),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: EdgeInsets.all(5),
                  width: 85,
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'MM/YY'
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    onChanged: (val) => setState(() => _cardDate = num.tryParse(val)),
                  ),
                ),
                SizedBox(width: 120,),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: EdgeInsets.all(5),
                  width: 85,
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'CVV'
                    ),
                    maxLength: 3,
                    keyboardType: TextInputType.number,

                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            RaisedButton(
              disabledColor: Colors.deepOrangeAccent[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              color: Colors.deepOrangeAccent[200],
              child: Text('Pay', style: TextStyle(color: Colors.white, fontSize: 18),),
              onPressed: (){
                _showNotification();
                Navigator.of(context).pushReplacementNamed(Home.tag);
              },

            ),

          ],
        ),
      ),
    );
  }

  Future onSelectNotification(String payload) async{
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: const Text("Payment Successful"),
        )
    );
  }

  Future _showNotification() async{
    var androidPlataformChannerSpecifics = new AndroidNotificationDetails('your channel ID', 'your channel name', 'your channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test'
    );

    var iosPlataformChannerSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(androidPlataformChannerSpecifics, iosPlataformChannerSpecifics);

    await flutterLocalNotificationPugin.show(3, 'Payment Successful', '', platformChannelSpecifics, payload: 'Default_Sound');

  }
}
