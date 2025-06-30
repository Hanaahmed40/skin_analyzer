import 'package:flutter/material.dart';
// import 'Home_Screen.dart';

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
            (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: i == pagenum ? 25 : 6,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: i == pagenum ? Colors.black : const Color(0xFF017CFD),
          ),
        ),
      ),
    );
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
          // Page 1
          buildPage(
            image: 'assets/images/image(1).png',
            title: 'Personalize Your Experience',
            desc:
            'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
            buttonText: 'Next',
            onPressed: () => nextpage.animateToPage(1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn),
          ),
          // Page 2
          buildPage(
            image: 'assets/images/image(2).png',
            title: 'Scan, Analyze & Take Care of Your Skin with AI',
            desc:
            'Your skin deserves the best care! With Skin Analyser.AI, you can scan your skin in seconds and let our AI detect potential skin conditions. Get instant insights, expert-backed recommendations, and personalized skincare tips.',
            buttonText: 'Next',
            onPressed: () => nextpage.animateToPage(2,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn),
          ),
          // Page 3
          buildPage(
            image: 'assets/images/image(3).png',
            title: "Don't Forget to Share Your Journey",
            desc:
            'Tracking your skin’s progress is important—but sharing it makes it even better! Stay connected with friends, exchange tips, and celebrate your improvements together.',
            buttonText: "Let's Start",
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routName);
            },
          ),
        ],
      ),
    );
  }Widget buildPage({
    required String image,
    required String title,
    required String desc,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        const SizedBox(height: 70),
        Image.asset(image),
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF017CFD),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        const Spacer(),ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF017CFD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            fixedSize: const Size(200, 56),
          ),onPressed: onPressed,
          child: Text(buttonText, style: const TextStyle(fontSize: 20)),
        ),
        const SizedBox(height: 30),
        dotPageView(),
        const SizedBox(height: 30),
      ],
    );
  }
}