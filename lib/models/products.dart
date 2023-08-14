class Product {
  final String id;
  final String name;
  final String description;
  final int price;
  final String category;
  final String brand;
  final List<String> image;
  final int quantity;
  final int discount;
  final List<String> keywords;
  

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.brand,
    required this.image,
    required this.quantity,
    required this.discount,
    required this.keywords,
    
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      brand: json['brand'],
      image: List<String>.from(json['image']),
      quantity: json['quantity'] ?? 0,
      discount: json['discount'] ?? 0,
      keywords: List<String>.from(json['keywords']),
     
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'brand': brand,
      'image': imagesToString(),
      'quantity': quantity,
      'discount': discount,
      'keywords': keywordsToString(),
      
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      category: map['category'],
      brand: map['brand'],
      image: stringToImages(map['image']),
      quantity: map['quantity'],
      discount: map['discount'],
      keywords: stringToKeywords(map['keywords']),
     
    );
  }

   String imagesToString() {
    return image.join(';'); // Use a delimiter of your choice (e.g., ;)
  }

  // Convert the single string representation back to a list of images
   static List<String> stringToImages(String imageString) {
    return imageString.split(';'); // Use the same delimiter used in imagesToString()
  }
  String keywordsToString() {
    return keywords.join(';'); // Use a delimiter of your choice (e.g., ;)
  }

  // Convert the single string representation back to a list of keywords
  static List<String> stringToKeywords(String keywordsString) {
    return keywordsString.split(';'); // Use the same delimiter used in keywordsToString()
  }
}
