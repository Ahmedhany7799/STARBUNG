import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(children: const [
        CoffeBean(degress: 80, left: -50, top: 0),
        CoffeBean(degress: 170, left: -70, top: 150),
        CoffeBean(degress: 75, right: -20, top: 150),
        CoffeBean(degress: 100, right: -70, top: 300),
        CoffeBean(degress: 155, right: 70, top: 350),
      ]),
    );
  }
}

class CoffeBean extends StatelessWidget {
  final double? top, left, right, bottom, degress;
  const CoffeBean({
    Key? key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.degress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: degress! * pi / 180,
        child: SvgPicture.asset(
          'assets/coffee-bean.svg',
          width: 150,
        ),
      ),
    );
  }
}