import 'package:flutter/material.dart';
import 'package:juices/models/categorymodel.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 72,
          width: 72,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Image.asset('assets/${category.image}'),
        ),
        const SizedBox(height: 10),
        Text(
          category.name.toUpperCase(),
          style: const TextStyle(
              letterSpacing: 1.5,
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}