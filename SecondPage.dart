import 'package:contactbook/dbdatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';

class SecondPage extends StatefulWidget {

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  TextEditingController name= TextEditingController();
  TextEditingController number= TextEditingController();

  bool st = true;
  bool st1 = true;

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getdatabase();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: name,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-z]'))],
                decoration: InputDecoration(errorText: st?null:"valid name",
                  border: OutlineInputBorder(),
                  label: Text("name") ,
                ),onChanged: (value) {
                  if(value!="")
                    {
                      setState(() {
                        st=true;
                      });
                    }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: number,maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(errorText: st1?null:"vaild number",
                  border: OutlineInputBorder(),
                  label: Text("number"),
                ),
                onChanged: (value) {
                  if(value!="")
                      {
                        setState(() {
                          st1=true;
                        });
                      }
                },
              ),
            ),
            ElevatedButton(onPressed: () {
                String s=name.text;
                String ss=number.text;
                dbdatabase().insertdata(s,ss,db!).then((value){
                });
              print(s);
              print(ss);
                if(name.text =="") {
                  setState(() {
                    st = false;
                  });
                }
              else if(number.text =="") {
                  setState(() {
                    st1 = false;
                  });
                }
              else {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return firstpage();
                },));
              }
              // name.text ="";
              // number.text ="";

            }, child: Text("insent"))
          ],
        ),
      ),
    );
  }

  void getdatabase() {

    dbdatabase().fordatabase().then((value) {

      setState(() {
        db = value;
      });

    });

  }
}
