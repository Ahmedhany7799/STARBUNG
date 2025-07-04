
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juices/models/categorymodel.dart';
import 'package:juices/views/cart.dart';
import 'package:juices/views/details.dart';
import 'package:juices/widgets/background.dart';
import 'package:juices/widgets/category_item.dart';
import 'package:juices/widgets/product_image.dart';
import 'package:juices/models/model.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentCategory = 0;
  int currentProduct = 0;
  PageController? controller;
  double viewPortFraction = 0.6;
  double? pageOffset = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        PageController(initialPage: 1, viewportFraction: viewPortFraction)
          ..addListener(() {
            setState(() {
              pageOffset = controller!.page;
            });
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> dataProducts =products
        .where((element) => element.category == categories[currentCategory])
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Center(
          child: SvgPicture.asset(
            'assets/coffee-cup.svg',
            color: Colors.brown,
            width: 24,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'STARBUNG',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Smoothies & Juices',
              style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12),
            )
          ],
        ),
        actions: [
          Center(
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  color: Colors.brown,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage(cartItems: [],)),
                    );
                  },
                ),
                Positioned(
                  right: 5,
                  top: 0,
                  child: Container(
                    width: 7.5,
                    height: 7.5,
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Stack(
        children: [
          const Background(),
          const Positioned(
            top: 30,
            left: 40,
            right: 40,
            child: Text(
              'Smooth Out Your Everyday',
              style: TextStyle(
                  color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 150,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF1E3932),
                child: Row(
                  children: [
                    ...List.generate(
                        categories.length,
                        (index) => Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width /
                                  categories.length,
                              color: currentCategory == index
                                  ? Colors.brown
                                  : Colors.transparent,
                            ))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 155,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF1E3932),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...List.generate(categories.length, (index) {
                      int decrease = 0;
                      int max = 1;
                      int bottomPadding = 0;
                      for (var i = 0; i < categories.length; i++) {
                        bottomPadding =
                            index > max ? index - decrease++ : index;
                      }
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentCategory = index;
                            dataProducts = products
                                .where((element) =>
                                    element.category ==
                                    categories[currentCategory])
                                .toList();
                            if (controller!.hasClients) {
                              controller!.animateToPage(1,
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut);
                            }
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: bottomPadding.abs() * 70),
                          child: CategoryItem(
                            category: categories[index],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.52,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF1E3932),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                ClipPath(
                  clipper: Clip(),
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: controller,
                      onPageChanged: (value) {
                        setState(() {
                          currentProduct = value % dataProducts.length;
                        });
                      },
                      itemBuilder: (context, index) {
                        double scale = max(
                            viewPortFraction,
                            (1 -
                                (pageOffset! - index).abs() +
                                viewPortFraction));
                        double angle = 0.0;
                        if (controller!.position.haveDimensions) {
                          angle = index.toDouble() - (controller!.page ?? 0);
                          angle = (angle * 0.05).clamp(-1, 1);
                        } else {
                          angle = index.toDouble() - (1);
                          angle = (angle * 0.05).clamp(-1, 1);
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DrinkDetails(
                                      drink: DrinkModel(
                                        name: dataProducts[index % dataProducts.length].name,
                                        title: dataProducts[index % dataProducts.length].name,
                                        image: dataProducts[index % dataProducts.length].image,
                                        price: (dataProducts[index % dataProducts.length].price).toInt(),
                                        id: index % dataProducts.length,
                                        quantity: 1,
                                      )),
                                ));
                          },
                          child: Hero(
                            tag: dataProducts[index % dataProducts.length].name,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 180 - (scale / 1.6 * 180)),
                              child: Transform.rotate(
                                angle: angle * pi,
                                child: Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  children: [
                                    ProductImage(
                                      product: dataProducts[
                                          index % dataProducts.length],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dataProducts[currentProduct % dataProducts.length]
                                .name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\$${dataProducts[currentProduct % dataProducts.length].price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ...List.generate(
                            dataProducts.length, (index) => indicator(index))
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer indicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              width: 3,
              color: index == currentProduct
                  ? Colors.brown.withOpacity(0.6)
                  : Colors.transparent)),
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
            color: index == currentProduct ? Colors.white : Colors.white.withOpacity(0.6),
            shape: BoxShape.circle),
      ),
    );
  }
}

class Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 70);
    path.quadraticBezierTo(size.width / 2, -30, 0, 70);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}