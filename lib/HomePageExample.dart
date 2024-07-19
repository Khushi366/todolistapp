import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'EditExample.dart';
import 'InsertExample.dart';
import 'helper/DatabaseHelper.dart';

class HomePageExample extends StatefulWidget {
  const HomePageExample({super.key});

  @override
  State<HomePageExample> createState() => _HomePageExampleState();
}

class _HomePageExampleState extends State<HomePageExample> {

  void _handelPopupMenuSelection(int value, String tid) async
  {
    switch(value){
      case 1:

        DatabaseHelper obj = new DatabaseHelper();
        var status = await obj.deleteTask(tid);
        if(status==1)
        {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Task deleted"))
          );
          setState(() {
            alldata = getdata();
          });

        }
        else
        {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Task not deleted"))
          );
        }
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditExample(updattid: tid)));
        break;
    }
  }


  Future<List>? alldata;

  Future<List> getdata()async{
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.allTask();
    return data;
  }
  @override
  void initState(){
    super.initState();
    setState(() {
      alldata = getdata();

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/img/banner.png",width: 150.0,),
                ],
              ),

              SizedBox(height: 10.0,),
              Expanded(
                child: FutureBuilder(
                  future: alldata,
                  builder: (index,snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length <= 0) {
                        return Center(
                          child: Text("No task found!"),
                        );
                      }
                      else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.all(6.0),
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment : CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(""+snapshot.data![index]["title"].toString(), style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),),
                                            PopupMenuButton(
                                              itemBuilder: (BuildContext contex) {
                                                return [
                                                  PopupMenuItem(
                                                    child: Text("Delete"),
                                                    value: 1,
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("Edit"),
                                                    value: 2,
                                                  )
                                                ];
                                              },
                                              onSelected: (int value) {
                                                _handelPopupMenuSelection(value, snapshot.data![index]["tid"].toString());
                                              },

                                            )

                                          ],
                                        ),
                                        Text(""+snapshot.data![index]["remark"].toString(),textAlign: TextAlign.justify,style: TextStyle(fontSize: 14.0),),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFC0C0C0).withOpacity(
                                            0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(2, 2),
                                      ),
                                      BoxShadow(
                                        color: Color(0xFFC0C0C0).withOpacity(
                                            0.2),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(-2, -2),
                                      ),
                                    ]
                                ),
                              );
                            }
                        );
                      }
                    }
                    else
                    {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){


              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InsertExample()));

            },
            child: Icon(Icons.add,color: Colors.white,size: 25,),
            backgroundColor: Color(0xFF4baf4f)

        ),
      ),
    );
  }
}
