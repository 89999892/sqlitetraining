import 'package:flutter/material.dart';
import 'package:sqlite_addnewcourse/models/coursemodel.dart';
import 'package:sqlite_addnewcourse/pages/updatecourse.dart';
import '../dbHelper.dart';
import 'addcourse.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper help;
  void initState() {
    // TODO: implement initState
    super.initState();
    help = DbHelper();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('courses'),centerTitle: true,elevation: 10,
        
        actions: [
          IconButton(icon: Icon(Icons.delete), onPressed: (){
            showDialog(context: context,
            builder: (crx){
              return AlertDialog(
                title: Text('are you sure that you want to delet all courses?'),
                actions: [
                  RaisedButton(
                    child: Text('delete all'),
                      onPressed: (){setState(() {
                        help.deletAll();
                        Navigator.of(crx).pop();
                      });}),
                  RaisedButton(
                      child: Text('cancle'),
                      onPressed: ()=>Navigator.of(crx).pop())
                ],

              );
            }
           );
          })
        ],
      ),
      body: FutureBuilder(
        future:  help.allcourses(),
        builder: (context,AsyncSnapshot snapshot){

          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
                itemBuilder:(cto,index){
                courseModel course=courseModel.frommap(snapshot.data[index]);
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Text('${index+1}       ${course.hours}'),
                    title: Text('${course.name}'),
                    subtitle: Text('${course.content}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      Expanded(
                        child: IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: (){setState(() {
                          help.deletcourse(course.id);
                        });},),
                      ),
                      Expanded(
                        child: IconButton(icon: Icon(Icons.upgrade_outlined), onPressed: ()async{
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>updateCourse(course: course)));
                        }),
                      )
                    ],)

                  ),
                );
                } );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>addCourse()));
        },
      ),

    );
  }
}
