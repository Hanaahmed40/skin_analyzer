import 'package:event_planning/core/helpers/cache_helper.dart';
import 'package:event_planning/core/helpers/cache_keys.dart';
import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/core/router/routes.dart';
//import 'package:event_planning/ui/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController nextpage = PageController();
  int pagenum = 0;

  Widget dotPageView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (i) => Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: i == pagenum ? 25 : 6,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: i == pagenum ? Colors.black : Color(0xFF017CFD),
          ),
        ),
      ),
    );
  }

  void _goLogin() async {
    await CacheHelper.setData(CacheKeys.onboarding, true);
    context.pushReplacementNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: nextpage,
        onPageChanged: (value) {
          setState(() {
            pagenum = value;
          });
        },
        children: [
          // ----------- Page 1 ------------
          Column(
            children: [
              SizedBox(height: 70),
              Image.asset('assets/images/image(1).png'),
              SizedBox(height: 80),
              Text(
                "Personalize Your Experience",
                style: TextStyle(
                  color: Color(0xFF017CFD),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF017CFD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: Size(150, 56),
                ),
                onPressed: () {
                  nextpage.animateToPage(1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                child: Text("Next", style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              dotPageView(),
              SizedBox(height: 30),
            ],
          ),

          // ----------- Page 2 ------------
          Column(
            children: [
              SizedBox(height: 70),
              Image.asset('assets/images/image(2).png'),
              SizedBox(height: 80),
              Text(
                "Scan, Analyze & Take Care of Your Skin with AI",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF017CFD),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Your skin deserves the best care! With Skin Analyser.AI, you can scan your skin in seconds and let our AI detect potential skin conditions. Get instant insights, expert-backed recommendations, and personalized skincare tips.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF017CFD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: Size(150, 56),
                ),
                onPressed: () {
                  nextpage.animateToPage(2,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                child: Text("Next", style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              dotPageView(),
              SizedBox(height: 30),
            ],
          ),

          // ----------- Page 3 ------------
          Column(
            children: [
              SizedBox(height: 70),
              Image.asset('assets/images/image(3).png'),
              SizedBox(height: 80),
              Text(
                "Don't Forget to Share Your Journey",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF017CFD),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Tracking your skin’s progress is important—but sharing it makes it even better! Stay connected with friends, exchange tips, and celebrate your improvements together.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF017CFD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: Size(200, 56),
                ),
                onPressed: () => _goLogin(),
                child: Text("Let's Start", style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 30),
              dotPageView(),
              SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
