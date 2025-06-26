import 'package:juices/models/categorymodel.dart';


class DrinkModel {
  final int id; // unique id
  final String image;
  final String name;
  final String title;
  final int? price;
  final double? height;
  final double? rightOffset;
  final double? leftOffset;
  final String? size;
  final bool? isHot;
  final int quantity;

  DrinkModel({
    required this.id,
    required this.quantity,
    required this.image,
    required this.name,
    required this.title,
    required this.price,
    this.height,
    this.leftOffset,
    this.rightOffset,
    this.size,
    this.isHot,
  });

  DrinkModel copyWith({
    int? id,
    String? name,
    String? image,
    int? price,
    String? title,
    int? quantity,
    String? size,
    bool? isHot,
  }) {
    return DrinkModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      isHot: isHot ?? this.isHot,
    );
  }

  static List<DrinkModel> drinks = [
    DrinkModel(
      id: 1,
      quantity: 1,
      image: "assets/drinks/Banana.png",
      name: "Banana",
      title: "20 Cups of different flavours",
      price: 23,
    ),
    DrinkModel(
      id: 2,
      quantity: 1,
      image: "assets/drinks/Salted Caramel.png",
      name: "Milkshake",
      title: "20 Cups of different flavours",
      price: 20,
    ),
    DrinkModel(
      id: 3,
      quantity: 1,
      image: "assets/drinks/Chocolate.png",
      name: "Chocolate Drinks",
      title: "20 Cups of different flavours",
      price: 10,
    ),
    DrinkModel(
      id: 4,
      quantity: 1,
      image: "assets/drinks/Strawberry.png",
      name: "Strawberry",
      title: "3 Cups of different flavours",
      price: 40,
    ),
  ];
}


class Product {
  final String image, name;
  final double price;
  final Category category;

  Product(
      {required this.category,
      required this.image,
      required this.name,
      required this.price});
}

List<Product> products = [
  Product(
      image: 'bakery/Blueberry Muffin.png',
      name: 'Blueberry Muffin',
      category: categories[3],
      price: 13),
  Product(
      image: 'bakery/Blueberry Scone.png',
      name: 'Blueberry Scone',
      category: categories[3],
      price: 12),
  Product(
      image: 'bakery/Butter Croissant.png',
      name: 'Butter Croissant',
      category: categories[3],
      price: 10),
  Product(
      image: 'bakery/Petite Vanilla Bean Scone.png',
      name: 'Petite Vanilla Bean Scone',
      category: categories[3],
      price: 13),
  Product(
      image: 'bakery/Pumpkin Cream Cheese Muffin.png',
      category: categories[3],
      name: 'Pumpkin Cream Cheese Muffin',
      price: 15),
  Product(
      image: 'drinks/Evolution Fresh® Mighty Watermelon.png',
      name: 'Evolution Fresh® Mighty Watermelon',
      category: categories[1],
      price: 18),
  Product(
      image: 'drinks/Caramel Brulée Frappuccino® Blended Beverage.png',
      name: 'Caramel Brulée Frappuccino® Blended Beverage',
      category: categories[1],
      price: 18),
  Product(
      image: 'drinks/Mango Dragonfruit Starbucks Refreshers® Beverage.png',
      name: 'Mango Dragonfruit Starbucks Refreshers® Beverage',
      category: categories[1],
      price: 18),
  Product(
      image: 'drinks/Pink Drink Starbucks Refreshers® Beverage.png',
      category: categories[1],
      name: 'Pink Drink Starbucks Refreshers® Beverage',
      price: 18),
  Product(
      image: 'drinks/Pistachio Frappuccino® Blended Beverage.png',
      category: categories[1],
      name: 'Pistachio Frappuccino® Blended Beverage',
      price: 18),
  Product(
      image: 'drinks/Starbucks BAYA™ Energy Mango Guava.png',
      category: categories[1],
      name: 'Starbucks BAYA™ Energy Mango Guava',
      price: 18),
  Product(
      image: 'drinks/Strawberry Crème Frappuccino® Blended Beverage.png',
      category: categories[1],
      name: 'Strawberry Crème Frappuccino® Blended Beverage',
      price: 18),
  Product(
      image: 'drinks/White Chocolate Crème Frappuccino® Blended Beverage.png',
      category: categories[1],
      name: 'White Chocolate Crème Frappuccino® Blended Beverage',
      price: 18),
  Product(
      image: 'hotcoffee/Caffè Americano.png',
      category: categories[0],
      name: 'Caffè Americano',
      price: 18),
  Product(
      image: 'hotcoffee/Caffè Misto.png',
      name: 'Caffè Mistoe',
      category: categories[0],
      price: 18),
  Product(
      image: 'hotcoffee/Cappuccino.png',
      name: 'Cappuccino',
      category: categories[0],
      price: 18),
  Product(
      image: 'hotcoffee/Featured Medium Roast - Pike Place® Roast.png',
      category: categories[0],
      name: 'Featured Medium Roast - Pike Place® Roast',
      price: 18),
  Product(
      image: 'hotcoffee/Honey Almondmilk Flat White.png',
      category: categories[0],
      name: 'Honey Almondmilk Flat White',
      price: 18),
  Product(
      category: categories[2],
      image: 'hotteas/Chai Tea Latte.png',
      name: 'Chai Tea Latte',
      price: 18),
  Product(
      image: 'hotteas/Chai Tea.png',
      category: categories[2],
      name: 'Chai Tea',
      price: 18),
  Product(
      image: 'hotteas/Emperor\'s Clouds & Mist®.png',
      category: categories[2],
      name: 'Emperor\'s Clouds & Mist®',
      price: 18),
  Product(
      image: 'hotteas/Honey Citrus Mint Tea.png',
      category: categories[2],
      name: 'Honey Citrus Mint Tea',
      price: 18),
  Product(
      image: 'hotteas/Matcha Tea Latte.png',
      category: categories[2],
      name: 'Matcha Tea Latte',
      price: 18),
];