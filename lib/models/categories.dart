class Categories {
  final String id;
  final String name;
  final String image;
  final String description;
  final String status;
 

  Categories({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.status,
    
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      status: json['status'],
     
    );
  }
}
