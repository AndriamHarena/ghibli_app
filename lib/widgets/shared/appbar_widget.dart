import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppbarWidget extends StatefulWidget implements PreferredSizeWidget {
  final bool showBackButton;
  
  const AppbarWidget({super.key, this.showBackButton = false});

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
  
  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AppbarWidgetState extends State<AppbarWidget>
    with TickerProviderStateMixin {
  late AnimationController _cloudController1;
  late AnimationController _cloudController2;
  late AnimationController _cloudController3;
  late AnimationController _twinkleController;
  late Animation<double> _cloudAnimation1;
  late Animation<double> _cloudAnimation2;
  late Animation<double> _cloudAnimation3;
  late Animation<double> _twinkleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize cloud animations with different speeds
    _cloudController1 = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _cloudController2 = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    );
    _cloudController3 = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
    _twinkleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _cloudAnimation1 = Tween<double>(
      begin: -100,
      end: 400,
    ).animate(CurvedAnimation(
      parent: _cloudController1,
      curve: Curves.linear,
    ));

    _cloudAnimation2 = Tween<double>(
      begin: -150,
      end: 450,
    ).animate(CurvedAnimation(
      parent: _cloudController2,
      curve: Curves.linear,
    ));

    _cloudAnimation3 = Tween<double>(
      begin: -80,
      end: 380,
    ).animate(CurvedAnimation(
      parent: _cloudController3,
      curve: Curves.linear,
    ));

    _twinkleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _twinkleController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _cloudController1.repeat();
    _cloudController2.repeat();
    _cloudController3.repeat();
    _twinkleController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _cloudController1.dispose();
    _cloudController2.dispose();
    _cloudController3.dispose();
    _twinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Stack(
        children: [
          // Twinkling stars
          AnimatedBuilder(
            animation: _twinkleAnimation,
            builder: (context, child) {
              return Stack(
                children: [
                  _buildStar(left: 50, top: 10, opacity: _twinkleAnimation.value * 0.3),
                  _buildStar(left: 150, top: 25, opacity: _twinkleAnimation.value * 0.4),
                  _buildStar(left: 250, top: 15, opacity: _twinkleAnimation.value * 0.2),
                  _buildStar(left: 320, top: 30, opacity: _twinkleAnimation.value * 0.5),
                  _buildStar(left: 80, top: 35, opacity: _twinkleAnimation.value * 0.3),
                ],
              );
            },
          ),
          
          // Subtle floating particles
          AnimatedBuilder(
            animation: _cloudAnimation1,
            builder: (context, child) {
              return Positioned(
                left: _cloudAnimation1.value,
                top: 20,
                child: _buildParticle(size: 3, opacity: 0.1),
              );
            },
          ),
          AnimatedBuilder(
            animation: _cloudAnimation2,
            builder: (context, child) {
              return Positioned(
                left: _cloudAnimation2.value,
                top: 40,
                child: _buildParticle(size: 2, opacity: 0.08),
              );
            },
          ),
          AnimatedBuilder(
            animation: _cloudAnimation3,
            builder: (context, child) {
              return Positioned(
                left: _cloudAnimation3.value,
                top: 30,
                child: _buildParticle(size: 4, opacity: 0.12),
              );
            },
          ),
          
          // AppBar content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  // Back button (positioned on the left)
                  if (widget.showBackButton)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () => context.go('/'),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  
                  // Logo (centered)
                  Center(
                    child: Image.asset(
                      'assets/images/logo.webp', 
                      height: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          'Studio Ghibli',
                          style: GoogleFonts.quicksand(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E2E2E),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticle({required double size, required double opacity}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(opacity * 0.5),
            blurRadius: size * 2,
            spreadRadius: 0.5,
          ),
        ],
      ),
    );
  }

  Widget _buildStar({required double left, required double top, required double opacity}) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(opacity),
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(opacity * 0.5),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
      ),
    );
  }
}