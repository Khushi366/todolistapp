import 'package:flutter/material.dart';
import 'package:todolistapp/HomePageExample.dart';
import 'package:todolistapp/InsertExample.dart';

import 'helper/DatabaseHelper.dart';

class EditExample extends StatefulWidget {
  var updattid = "";
   EditExample({required this.updattid});

  @override
  State<EditExample> createState() => _EditExampleState();
}

class _EditExampleState extends State<EditExample> {
  TextEditingController _title = TextEditingController();
  TextEditingController _remask = TextEditingController();

  getdata() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.getSingleTask(widget.updattid);


    setState(() {
      _title.text = data[0]["title"].toString();
      _remask.text = data[0]["remark"].toString();
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined,size: 20.0,)),
                  Expanded(child: Center(child: Text("Edit Task",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14.0),))),
                ],
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: _title,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Title",
                ),
              ),

              SizedBox(height: 15.0,),
              TextField(
                controller: _remask,
                keyboardType: TextInputType.text,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Remark",
                ),
              ),
              SizedBox(height: 15.0,),

              ElevatedButton(
                onPressed: ()async{
                  var title = _title.text.toString();
                  var remark = _remask.text.toString();


                  DatabaseHelper obj = new DatabaseHelper();

                  var status = await obj.updateTask(title,remark,widget.updattid);

                  if(status==1)
                  {
                    Navigator.of(context).pop();//edit
                    Navigator.of(context).pop();//view
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>HomePageExample())
                    );
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error!"))
                    );
                  }

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF4baf4f)),
                  fixedSize: MaterialStateProperty.all(Size(300.0,45.0)),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                ),
                child: Text("Edit",style: TextStyle(fontFamily: "SourceSansPro",color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
