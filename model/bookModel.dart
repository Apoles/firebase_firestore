class Book {
  final String id;
  final String isim;
  final String yazar;
  final int sayfa;

  Book( {this.id,this.isim, this.yazar, this.sayfa});


  Map<String,dynamic> toMap()=>{
    'id':id,
    'isim':isim,
    'yazar':yazar,
    'sayfa':sayfa,
  };


  factory Book.fromMap(Map map)=> Book(
    id:map['id'],
    yazar:map['yazar'],
    isim: map['isim'],
    sayfa: map['sayfa'],



  );




}