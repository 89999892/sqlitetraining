import 'package:flutter/material.dart';
import 'package:sqlite_addnewcourse/models/coursemodel.dart';
import 'package:sqlite_addnewcourse/dbHelper.dart';

import 'home.dart';
class addCourse extends StatefulWidget {
  @override
  _addCourseState createState() => _addCourseState();
}

class _addCourseState extends State<addCourse> {
  String name,content;
  int hours;
  DbHelper helper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper=DbHelper();
  }
  void _changehours( val){
    setState(() {
      hours=int.parse(val);
      print('$hours');
    });
  }
  void _changename(val){
   setState(() {
     name=val;
     print('$name');
   });
  }
  void _changecontent(val){
   setState(() {
     content=val;
     print('$content');
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add new course'),elevation: 10
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _fieldfunc(hint: 'Enter course name', onchange: _changename, maxline: 2),
                SizedBox(height: 10,),
                _fieldfunc(hint: 'Enter course content', onchange:_changecontent, maxline: 10),
                SizedBox(height: 10,),
                _fieldfunc(hint: 'Enter course hours', onchange:_changehours, maxline:2,keytype: TextInputType.number),
                Padding(padding: EdgeInsets.all(60),
                  child: Center(
                    child: RaisedButton(
                      padding: EdgeInsets.all(10),
                      child: Text('save',style: TextStyle(fontSize: 20),),
                      onPressed: ()async{
                        var course=courseModel({'name':this.name,'content':this.content,'hours':this.hours});
                        int id=await helper.Creatcourse(course);
                        print('course id is $id');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));

                      },
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

Widget  _fieldfunc({@required String hint,@required Function onchange,@required int maxline,TextInputType keytype}) {
    return            TextFormField(
      keyboardType:keytype ,
        decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))

  ),
      onChanged: onchange,
      maxLines: maxline,
    );
}
}
