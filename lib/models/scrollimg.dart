// class ScrollImg {
//   String id;
//   String title;
//   String pictures;

//   ScrollImg({
//     required this.id,
//     required this.title,
//     required this.pictures,
//   });

//   factory ScrollImg.fromJson(Map<String, dynamic> json) {
//     return ScrollImg(
//       id: json['_id'],
//       title: json['title'],
//       pictures: json['pictures'],
//     );
//   }
// }
class ScrollImg {
  String id;
  String title;
  String pictures;
  int v;

  ScrollImg({
    required this.id,
    required this.title,
    required this.pictures,
    required this.v,
  });

  factory ScrollImg.fromJson(Map<String, dynamic> json) {
    return ScrollImg(
      id: json['_id'],
      title: json['title'],
      pictures: json['pictures'],
      v: json['__v'],
    );
  }

  @override
  String toString() {
    return 'ScrollImg{id: $id, title: $title, pictures: $pictures, v: $v}';
  }
}
