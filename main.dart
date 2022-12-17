import 'package:contactbook/SecondPage.dart';
import 'package:contactbook/dbdatabase.dart';
import 'package:contactbook/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: firstpage(),
  ));
}

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  Database? dbs;
  List<Map> pp = [];

  List<Map> searchlist = [];

  bool search = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getdat();
  }

  void getdat() {
    dbdatabase().fordatabase().then((value) {
      setState(() {
        dbs = value;
      });

      dbdatabase().viewdata(dbs!).then((listofmap) {
        setState(() {
          pp = listofmap;
          searchlist = listofmap;
          print("================$pp");
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: search
          ? AppBar(
              title: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              search = false;
                            });
                          },
                          icon: Icon(Icons.close))),
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        searchlist =[];
                        for (int i = 0; i < pp.length; i++) {
                          String title = pp[i]['name'];
                          String ttt=pp[i]['number'];
                          if(title.toLowerCase().contains(value.toLowerCase())) {
                            searchlist.add(pp[i]);
                          }
                          else if(ttt.toLowerCase().contains(value.toLowerCase()))
                            {
                              searchlist.add(pp[i]);
                            }
                        }
                      } else {
                        searchlist = pp;
                      }
                    });
                  },
                ),
              ),
              // title: Center(child: Text("CONTACT BOOK")),
              // elevation: 20,
              // actions: [Icon(Icons.search)],
            )
          : AppBar(
              title: Text("notes"),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        search = true;
                      });
                    },
                    icon: Icon(Icons.search))
              ],
            ),
      body: ListView.builder(
       itemCount: search?searchlist.length : pp.length,
        // itemCount: pp.length,
         // shrinkWrap: true,
        itemBuilder: (context, index) {
          Map temp = search? searchlist[index]:pp[index];
          return Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Text("${temp['id']}"),
              title: Text("${temp['name']}"),
              subtitle: Text(
                "${temp['number']}",
              ),
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              String name = pp[index]['name'];
                              String number = pp[index]['number'];
                              int id = pp[index]['id'];
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return updatepage(name, number, id);
                                },
                              ));
                            },
                            child: Icon(Icons.update)),
                        TextButton(
                            onPressed: ()
                            {
                              int dell = pp[index]['id'];
                              dbdatabase()
                                  .deletedata2(dbs!, dell)
                                  .then((value) {
                                setState(() {
                                  getdat();
                                  Navigator.pop(context);
                                });
                              });
                            },
                            child: Icon(Icons.delete))
                      ],
                      title: Text("ARE YOU SURE ?"),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return SecondPage();
            },
          ));
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
