class Motel {
  final String name;
  final double price;
  final String image;

    Motel({
      required this.name,
      required this.price,
      required this.image,
    });

    factory Motel.fromJson(Map<String, dynamic> json) {
      return Motel(
        name: json['name'],
        price: json['price'].toDouble(),
        image:  json['image']
      );
    }
}