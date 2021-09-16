class courseModel{
  int id,hours;
  String name,content;

  courseModel(dynamic obj){
    id=obj['id'];
    name=obj['name'];
    content=obj['content'];
    hours=obj['hours'];
  }
 Map<String,dynamic> toMap()=>{
    'id':id,
   'name':name,
   'content':content,
   'hours':hours,
  };
  courseModel.frommap(Map<String,dynamic> data){
    id=data['id'];
    name=data['name'];
    content=data['content'];
    hours=data['hours'];
  }
}