import 'package:flutter/material.dart';
import 'package:funica/presentation/pages/start_page/start_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _pageController = PageController();
  int _pageIndex = 0;

  List<String> titles = [
    "We provide high quality products just for you",
    "Your satisfaction is our number one priority",
    "Let's fulfill your house needs with Funica right now!",
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              children: [
                for (int i = 1; i <= 3; i++)
                  Image.asset(
                    "assets/images/intro$i.png",
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Items(
              controller: _pageController,
              title: titles[_pageIndex],
              btnTitle: _pageIndex == 2 ? "Get Started" : "Next",
              onTap: () {
                // _pageIndex++;
                // _pageController.jumpToPage(_pageIndex);
                if (_pageIndex == 2) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartPage(),
                      ),
                      (Route<dynamic> route) => false);
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Items extends StatefulWidget {
  final String title;
  final String btnTitle;
  final Function() onTap;
  final PageController controller;

  const Items(
      {super.key,
      required this.title,
      required this.onTap,
      required this.btnTitle,
      required this.controller});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

          // Smooth page indicator
          SmoothPageIndicator(
            controller: widget.controller,
            count: 3,
            effect: const ExpandingDotsEffect(
              dotColor: Colors.black38,
              activeDotColor: Colors.black,
              dotHeight: 10,
              dotWidth: 12,
            ),
          ),

          InkWell(
            onTap: widget.onTap,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.btnTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
