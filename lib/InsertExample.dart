import 'package:flutter/material.dart';
import 'package:todolistapp/HomePageExample.dart';

import 'helper/DatabaseHelper.dart';

class InsertExample extends StatefulWidget {
  const InsertExample({super.key});

  @override
  State<InsertExample> createState() => _InsertExampleState();
}

class _InsertExampleState extends State<InsertExample> {

  TextEditingController _title = TextEditingController();
  TextEditingController _remask = TextEditingController();

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
                  Expanded(child: Center(child: Text("New Task",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14.0),))),
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

                  var title  =  _title.text.toString();
                  var remark =  _remask.text.toString();
                  DatabaseHelper obj = new DatabaseHelper();
                  var id = await obj.insertTask(title,remark);
                  if(id>=1)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Task Inserted : " + id.toString()))
                    );
                    _title.text = "";
                    _remask.text = "";

                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error!"))
                    );
                  }


                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePageExample()));
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
                child: Text("Add",style: TextStyle(fontFamily: "SourceSansPro",color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
