import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/bottomnavbar.dart';
import '../customwigdets/my_button.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedLogoWithMessage();
  }
}

class AnimatedLogoWithMessage extends StatefulWidget {
  @override
  _AnimatedLogoWithMessageState createState() =>
      _AnimatedLogoWithMessageState();
}

class _AnimatedLogoWithMessageState extends State<AnimatedLogoWithMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _moveAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _appNameOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.4, end: 0.7).animate(_controller);
    _moveAnimation = Tween<double>(begin: 0, end: -110).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.7, 1, curve: Curves.easeIn),
      ),
    );
    _appNameOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: (context, child) => Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.purpleAccent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _moveAnimation.value),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Image.asset(
                          'assets/images/b.png',
                          width: 350.w,
                          height: 350.h,
                        ),
                      ),
                      FadeTransition(
                        opacity: _appNameOpacityAnimation,
                        child: Text(
                          'ECM',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Transform.translate(
                  offset: Offset(0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 180.h),
                      Text(
                        'Register for Events now',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      mybutton(
                        ontap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Mainscreen()),
                        ),
                        btext: 'See events',
                        color: Colors.teal,
                        fontSize: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
