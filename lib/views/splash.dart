// import 'package:flutter/material.dart';
// import 'home.dart';

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late Animation<double> _logoAnimation;

//   late AnimationController _textController;
//   late Animation<double> _textFade;

//   @override
//   void initState() {
//     super.initState();

//     _logoController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );

//     _textController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );

//     _logoAnimation = CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.easeOutBack,
//     );

//     _textFade = CurvedAnimation(
//       parent: _textController,
//       curve: Curves.easeIn,
//     );

//     _logoController.forward();
//     Future.delayed(const Duration(milliseconds: 1000), () => _textController.forward());

//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const Home()));
//     });
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF1E3932), Color(0xFF006241)], // Starbucks-like gradient
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ScaleTransition(
//               scale: _logoAnimation,
//               child: Image.asset("assets/logo/logo.jpg", width: 220, fit: BoxFit.cover),
//             ),
          
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  late AnimationController _textController;
  late Animation<Offset> _textSlide;
  late Animation<double> _textFade;

  late AnimationController _bgController;
  late Animation<double> _bgFade;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _textFade = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _bgFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeIn),
    );

    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 800), () => _textController.forward());
    Future.delayed(const Duration(milliseconds: 500), () => _bgController.forward());

    Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  Home()));
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Gradient
          Container(
           decoration: const BoxDecoration(
  gradient: LinearGradient(
    colors: [Color.fromARGB(255, 254, 255, 254), Color.fromARGB(255, 236, 240, 236)], // lighter green tones
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
),

          ),

          // Optional overlay animation
          FadeTransition(
            opacity: _bgFade,
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.white24, Colors.transparent],
                  radius: 0.8,
                  center: Alignment(0.0, -0.3),
                ),
              ),
            ),
          ),

          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
  scale: _logoAnimation,
  child: Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.4), // glow color
          blurRadius: 40,
          spreadRadius: 5,
        ),
      ],
    ),
    child: Image.asset(
      "assets/logo/logo.png",
      width: 160,
      height: 160,
      fit: BoxFit.cover,
    ),
  ),
),

              const SizedBox(height: 20),
              SlideTransition(
                position: _textSlide,
                child: FadeTransition(
                  opacity: _textFade,
                  child: const Text(
                    "STARBUNG",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
