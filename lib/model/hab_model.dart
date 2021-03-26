class Hab{
  String title;
  String hab_url;
  String body;

  Hab({this.title, this.hab_url, this.body});

  Map<String, dynamic> toJson()=>{
    'title': title,
    'hab_url': hab_url,
    'body': body,
  };

  Hab.fromJson(Map<String,dynamic>json):
      title = json['title'],
      hab_url = json['hab_url'],
      body = json['body'];
}