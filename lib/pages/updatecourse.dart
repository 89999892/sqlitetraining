import 'package:flutter/material.dart';
import 'package:sqlite_addnewcourse/dbHelper.dart';
import 'package:sqlite_addnewcourse/models/coursemodel.dart';

import 'home.dart';
class updateCourse extends StatefulWidget {
 final courseModel course;

  const updateCourse({@required this.course}) ;

  @override
  _updateCourseState createState() => _updateCourseState();
}

class _updateCourseState extends State<updateCourse> {
  var nameEdite=TextEditingController();
  var contentEdite=TextEditingController();
  var hoursEdite=TextEditingController();
  DbHelper helper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper=DbHelper();
    nameEdite.text=widget.course.name;
    contentEdite.text=widget.course.content;
    hoursEdite.text=widget.course.hours.toString();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('courseUpdate'),),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameEdite,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))

                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(

                controller: contentEdite,
                maxLines: 10,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))

                ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: hoursEdite,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(

                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))

                ),
              ),
            ),
            SizedBox(height: 30,),
            RaisedButton(
              child:Text('Update course') ,
                onPressed: (){
                showDialog(context: context,
                builder: (ctx){
                  return AlertDialog(
                    title: Text('are you sure that you want to save updates?'),
                    actions: [
                      RaisedButton(
                          child: Text('save'),
                          onPressed: () {
                            var updatedCourse = courseModel({
                              'id': widget.course.id,
                              'name': nameEdite.text,
                              'content': contentEdite.text,
                              'hours': int.parse(hoursEdite.text)
                            });

                            helper.courseUpdate(updatedCourse);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));

                          } ),
                      RaisedButton(
                          child: Text('cancle'),
                          onPressed: ()=>Navigator.of(ctx).pop())
                    ],

                  );
                });
                })
          ],
        ),
      ),
    );
  }
}
