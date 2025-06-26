import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juices/views/cart.dart';
import 'package:juices/components/toggle_widget.dart';
import 'package:juices/models/model.dart';

class DrinkDetails extends StatefulWidget {
  final DrinkModel drink;

  const DrinkDetails({super.key, required this.drink});

  @override
  State<DrinkDetails> createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
  late PageController _controller;
  late ValueNotifier<double> _pageNotifier;
  late int initialIndex;
  int selectedSize = 1;
  bool isIced = true; 

  int quantity = 1;
  final List<DrinkModel> cartItems = [];

  @override
  void initState() {
    super.initState();
    initialIndex = DrinkModel.drinks.indexOf(widget.drink);
    _controller = PageController(viewportFraction: 0.55, initialPage: initialIndex);
    _pageNotifier = ValueNotifier<double>(initialIndex.toDouble());

    _controller.addListener(() {
      if (_controller.hasClients) {
        _pageNotifier.value = _controller.page ?? initialIndex.toDouble();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageNotifier.dispose();
    super.dispose();
  }

  void addToCart(DrinkModel newItem) {
    setState(() {
      final existingIndex = cartItems.indexWhere((item) =>
          item.name == newItem.name &&
          item.title == newItem.title &&
          item.isHot == newItem.isHot);

      if (existingIndex != -1) {
        cartItems[existingIndex] = cartItems[existingIndex].copyWith(
          quantity: cartItems[existingIndex].quantity + newItem.quantity,
        );
      } else {
        cartItems.add(newItem);
      }
    });
  }

  double _calculateScale(int index, double currentPage) {
    final diff = (currentPage - index).abs();
    return (1 - (diff * 0.2)).clamp(0.8, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: ValueListenableBuilder<double>(
          valueListenable: _pageNotifier,
          builder: (context, value, _) {
            final currentIndex = value.round().clamp(0, DrinkModel.drinks.length - 1);
            final selectedDrink = DrinkModel.drinks[currentIndex];
            return ElevatedButton(
              onPressed: () {

  
  
  final newDrink = selectedDrink.copyWith(
    size: selectedSize == 0
        ? "SMALL"
        : selectedSize == 1
            ? "MEDIUM"
            : selectedSize == 2
                ? "LARGE"
                : "EXTRA LARGE",
    quantity: quantity,
    isHot: !isIced, 
  );

  CartManager().addToCart(newDrink); 

  addToCart(newDrink); 

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CartPage(cartItems: cartItems),
    ),
  );


              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E3932),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text(
                "Add to Cart",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  bottom: constraints.maxHeight * 0.18,
                  left: 20,
                  right: 0,
                  child: Image.asset(
                    "assets/drinks/Ellipse 2.png",
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: ValueListenableBuilder<double>(
                    valueListenable: _pageNotifier,
                    builder: (context, value, _) {
                      final index = value.round().clamp(0, DrinkModel.drinks.length - 1);
                      final drink = DrinkModel.drinks[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: const Icon(Icons.arrow_back), color: Colors.black),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             
                             
                              Text(drink.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(drink.title, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Text("£${drink.price}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  top: constraints.maxHeight * 0.15,
                  bottom: constraints.maxHeight * 0.35,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: DrinkModel.drinks.length,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          final currentPage = _pageNotifier.value;
                          final scale = _calculateScale(index, currentPage);
                          return Transform.scale(
                            scale: scale,
                            child: Hero(
                              tag: DrinkModel.drinks[index].image,
                              child: Image.asset(DrinkModel.drinks[index].image, height: 380),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 30,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          const sizes = ["SMALL", "MEDIUM", "LARGE", "EXTRA LARGE"];
                          return GestureDetector(
                            onTap: () => setState(() => selectedSize = index),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedSize == index ? Color(0xFF1E3932): Colors.white,
                                    border: Border.all(
                                      color: selectedSize == index ? Color(0xFF1E3932) : Colors.grey,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/Vector.svg",
                                    color: selectedSize == index ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  sizes[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: selectedSize == index ? Color(0xFF1E3932) : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(child:DrinkToggle(
  isIced: isIced,
  onChanged: (value) {
    setState(() => isIced = value);
  },
),
),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => setState(() {
                                  if (quantity > 1) quantity--;
                                }),
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
                              IconButton(
                                onPressed: () => setState(() => quantity++),
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

extension DrinkCopy on DrinkModel {
  DrinkModel copyWith({
    String? name,
    String? title,
    String? image,
    double? price,
    int? quantity,
    bool? isHot,
  }) {
    return DrinkModel(
      id: this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      image: image ?? this.image,
      price: (price ?? this.price) as int?,
      quantity: quantity ?? this.quantity,
      isHot: isHot ?? this.isHot,
    );
  }
}