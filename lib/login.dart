import 'dart:convert';

import 'package:epic_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});
  @override
  _LoginDemoState createState()=>_LoginDemoState();

}

class _LoginDemoState extends State<LoginDemo> {

  final ecnController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    ecnController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(top: 40,bottom: 40),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('asset/images/epicenter.jpg')
                ),
              ),
      ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child: TextField(
                  controller: ecnController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ECN',
                    hintText: 'e01234<ECN No.>',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                      hintText: 'Password',
                  ),
                ),
              ),
      Container(
        height: 50,
        width: 250,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10)
        ),
        child: FlatButton(
          onPressed: (){
            if(ecnController.text.isEmpty){
              makeToast("ECN is required!");
            }else if(passController.text.isEmpty){
              makeToast("Password is required!");
            }else{
              callAPI(ecnController.text, passController.text);
            }
          }
            //Navigator.push(context, MaterialPageRoute(builder: (_)=>
            //const MyHomePage(title: 'Welcome Home',)));
          ,
          child: const Text(
              'Login',
            style: TextStyle(color: Colors.white,fontSize: 25),
          ),
        ),
      ),

          ],
        ),
      ),
    );
  }

  Future<void> callAPI(String ecn,String pass) async {
    var url = Uri.parse('https://epinet.epicentertechnology.com/SOSAPI/API/Timesheet/Login');
    var response = await http.post(url, body: jsonEncode({'UserName': ecn, 'Password': pass}),
    headers: {"content-type":"application/json"});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if(response.statusCode==200){
      makeToast("Logged in successfully");
      Navigator.push(context, MaterialPageRoute(builder: (_)=>
      const MyHomePage(title: 'Welcome Home',)));
    }else{
      makeToast("Failed to logged in");
    }
  }

  void makeToast(String s){
    Fluttertoast.showToast(
      msg: s,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.black,
      fontSize: 14,
    );
  }

}

