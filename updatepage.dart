import 'package:contactbook/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'dbdatabase.dart';

class updatepage extends StatefulWidget {
  String name;
  String number;
  int id;

  updatepage(this.name, this.number, this.id);

  @override
  State<updatepage> createState() => _updatepageState();
}

class _updatepageState extends State<updatepage> {

  TextEditingController namee=TextEditingController();
  TextEditingController numberr=TextEditingController();

  Database? dbs1;

  bool bt = false;
  bool bt1 =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namee.text=widget.name;
    numberr.text=widget.number;
    getdata1();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("upadate"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: namee,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-z]'))],
              decoration: InputDecoration(errorText: bt?"Enter name":null,
                  label: Text("Name"),
                  hintText: "Enter your name",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              onChanged: (value) {
                if(value!=""){
                  setState(() {
                    bt=false;
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: numberr,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(errorText: bt1?"Enter Number":null,
                  label: Text("Number"),
                  hintText: "Enter your number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              onChanged: (value) {
                if(value!="")
                  {
                    setState(() {
                      bt1=false;
                    });
                  }
              },
            ),
          ),
         ElevatedButton(onPressed: () {
           //
           // String d=namee.text;
           // String dd=numberr.text;

          dbdatabase().Updatedata(dbs1!,namee.text,numberr.text,widget.id).then((value){

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return firstpage();
            },));
          });
           // print(d);
           // print(dd);

           if(namee.text=="")
             {
               setState(() {
                 bt=true;
               });
             }
           else if(numberr.text=="")
           {
                 setState(() {
                   bt1=true;
                 });
           }
           // namee.text="";
           // numberr.text="";
         }, child: Icon(Icons.update,size: 30,))
        ],
      ),
    );
  }

  void getdata1() {
    dbdatabase().fordatabase().then((value) {
      setState(() {
        dbs1=value;
      });
    });

  }
}
