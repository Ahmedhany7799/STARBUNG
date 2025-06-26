import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  int _currentPage = 0;

  late AnimationController _bgController;
  late Animation<Color?> _bgAnimation;

  final List<Map<String, dynamic>> _pages = [
    {
      "animation": "assets/onboarding/iced coffee-amico.svg",
      "title": "Brewed Just for You",
      "subtitle": "Find your perfect drink with just a few taps.",
      "color": Color(0xFF1E3932),
    },
    {
      "animation": "assets/onboarding/Coffee shop-rafiki.svg",
      "title": "Customize Everything",
      "subtitle": "Pick size, sweetness, and toppings easily.",
      "color": Color(0xFF0A3622),
    },
    {
      "animation": "assets/onboarding/delivery.svg",
      "title": "Fast Delivery",
      "subtitle": "Delivered hot and fresh to your doorstep.",
      "color": Color(0xFF004D40),
    },
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        pageBuilder: (_, __, ___) =>  Home(),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.ease);
    } else {
      _completeOnboarding();
    }
  }

  void _skip() => _completeOnboarding();

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _bgAnimation = ColorTween(
      begin: _pages[0]['color'],
      end: _pages[1]['color'],
    ).animate(_bgController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    _bgController.reset();
    _bgAnimation = ColorTween(
      begin: _pages[index]['color'],
      end: index + 1 < _pages.length ? _pages[index + 1]['color'] : _pages[index]['color'],
    ).animate(_bgController);
    _bgController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bgAnimation,
      builder: (context, child) => Scaffold(
        backgroundColor: _bgAnimation.value,
        body: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(page['animation'], height: 300),
                        const SizedBox(height: 30),
                        Text(
                          page['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['subtitle'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Skip button
              Positioned(
                top: 20,
                right: 20,
                child: TextButton(
                  onPressed: _skip,
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ),

              // Page indicator
              Positioned(
                bottom: 110,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pages.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      height: 10,
                      width: _currentPage == index ? 22 : 10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
                ),
              ),

              // Next / Get Started button
              Positioned(
                bottom: 40,
                left: 24,
                right: 24,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _pages[_currentPage]['color'],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1 ? "Get Started" : "Next",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
