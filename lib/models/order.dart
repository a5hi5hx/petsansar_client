class Order {
    final String id;
    final String user;
    final List<Productt> products;
    final List<int> quantity;
    final Addresss address;
    final int totalPrice;
    final int deliveryFee;
    final String paymentType;
    final String status;
    final DateTime createdAt;
    final DateTime updatedAt;
  
    Order({
      required this.id,
      required this.user,
      required this.products,
      required this.quantity,
      required this.address,
      required this.totalPrice,
      required this.deliveryFee,
      required this.paymentType,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
    });
  
    factory Order.fromJson(Map<String, dynamic> json) {
      return Order(
        id: json['_id'],
        user: json['user'],
        products: List<Productt>.from(json['products'].map((product) => Productt.fromJson(product))),
        quantity: List<int>.from(json['quantity']),
        address: Addresss.fromJson(json['address']),
        totalPrice: json['totalPrice'],
        deliveryFee: json['deliveryFee'],
        paymentType: json['paymentType'],
        status: json['status'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );
    }
     Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'products': products,
      'quantity': quantity,
      'address': address,
      'totalPrice': totalPrice,
      'deliveryFee': deliveryFee,
      'paymentType': paymentType,
      'status': status,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      user: map['user'],
      products: map['products'],
      quantity: map['quantity'],
      address: map['address'],
      totalPrice: map['totalPrice'],
      deliveryFee: map['deliveryFee'],
      paymentType: map['paymentType'],
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
  }
  
  class Productt {
    final String id;
    final String name;
    final String description;
    final int price;
    final String category;
    final String brand;
    final List<String> image;
    final int quantity;
    //final int discount;
    final List<String> keywords;
  
    Productt({
      required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.category,
      required this.brand,
      required this.image,
      required this.quantity,
     // required this.discount,
      required this.keywords,
    });
  
    factory Productt.fromJson(Map<String, dynamic> json) {
      return Productt(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        category: json['category'],
        brand: json['brand'],
        image: List<String>.from(json['image']),
        quantity: json['quantity'],
        //discount: json['discount']?? '',
        keywords: List<String>.from(json['keywords']),
      );
    }
  }
  
  class Addresss {
    final String id;
    final String phone;
    final String street;
    final String city;
    final String state;
    final String postalCode;
  
    Addresss({
      required this.id,
      required this.phone,
      required this.street,
      required this.city,
      required this.state,
      required this.postalCode,
    });
  
    factory Addresss.fromJson(Map<String, dynamic> json) {
      return Addresss(
        id: json['_id'],
        phone: json['phone'],
        street: json['street'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
      );
    }

    
  }
  