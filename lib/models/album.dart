class Album{
 final  int userId;
 final int id;
 final String title;
  Album({
    required this.userId,
    required this.id,
   required this.title
   });

 factory Album.fromJson(Map<String, dynamic> json) {
   return Album(
     id: json['id'],
     userId: json['userId'],
     title: json['title']
   );
 }

 Map<String, dynamic> toJson() => {
   'id': id,
   'userId': userId,
   'title': title
 };

}