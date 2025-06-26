
import 'package:flutter/material.dart';
import 'package:juices/models/model.dart';
import 'package:juices/payment/paymentmethod.dart';

class CartPage extends StatefulWidget {
  final List<DrinkModel> cartItems;
  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<DrinkModel> cartItems;

  @override
  void initState() {
    super.initState();
    
cartItems = CartManager().cartItems;      
    
  }

  void incrementQuantity(DrinkModel drink) {
    setState(() {
      final index = cartItems.indexWhere((item) => 
          item.name == drink.name && 
          item.size == drink.size && 
          item.isHot == drink.isHot);
      
      if (index != -1) {
        cartItems[index] = cartItems[index].copyWith(
          quantity: cartItems[index].quantity + 1,
        );
      }
    });
  }

  void decrementQuantity(DrinkModel drink) {
    setState(() {
      final index = cartItems.indexWhere((item) => 
          item.name == drink.name && 
          item.size == drink.size && 
          item.isHot == drink.isHot);
      
      if (index != -1) {
        if (cartItems[index].quantity > 1) {
          cartItems[index] = cartItems[index].copyWith(
            quantity: cartItems[index].quantity - 1,
          );
        } else {
          cartItems.removeAt(index);
          setState(() {
            cartItems.removeWhere((item) => 
                item.name == drink.name && 
                item.size == drink.size && 
                item.isHot == drink.isHot);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView(
              children: [
                ...cartItems.map((drink) => CartItem(
                      name: drink.name,
                      image: drink.image,
                      price: (drink.price ?? 0).toDouble(),
                      quantity: drink.quantity,
                      size: drink.size ?? 'Unknown',
                      isHot: drink.isHot?? false,
                      onIncrement: () => incrementQuantity(drink),
                      onDecrement: () => decrementQuantity(drink),
                      onRemove: () {
                        setState(() {
                          cartItems.removeWhere((item) => 
                              item.name == drink.name && 
                              item.size == drink.size && 
                              item.isHot == drink.isHot);
                        });
                      },
                    )),
              ],
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: £${cartItems.fold(0.0, (total, item) => total + (item.price ?? 0) * item.quantity).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PaymentMethodScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E3932),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Checkout', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
                    ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.name,
    required this.quantity,
    required this.price,
    required this.size,
    required this.isHot,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  final String image;
  final String name;
  final int quantity;
  final double price;
  final String size;
  final bool isHot;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Image with shadow
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 2,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Size: $size",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Temp: ${isHot ? 'Hot' : 'Cold'}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "£${(price * quantity).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              // Quantity controls
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 20),
                    onPressed: onDecrement,
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 20),
                    onPressed: onIncrement,
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onRemove,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<DrinkModel> cartItems = [];

  void addToCart(DrinkModel newItem) {
    final index = cartItems.indexWhere((item) =>
        item.name == newItem.name &&
        item.size == newItem.size &&
        item.isHot == newItem.isHot);

    if (index != -1) {
      cartItems[index] = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + newItem.quantity,
      );
    } else {
      cartItems.add(newItem);
    }
  }

  void removeFromCart(DrinkModel item) {
    cartItems.removeWhere((d) =>
        d.name == item.name && d.size == item.size && d.isHot == item.isHot);
  }

  void clearCart() {
    cartItems.clear();
  }
}
