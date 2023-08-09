import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:funica/screens/home/components/banner_card.dart';
import 'package:funica/screens/home/components/default_appbar.dart';

class SpecialOffers extends StatelessWidget {
  SpecialOffers({super.key});

  int _currentIndex = 0;

  // late List<Widget> _bannerList;

  final List<BannerCard> _bannerList = [
    const BannerCard(
      discount: '25%',
      period: "Today's Special!",
      description: 'Get discount for every order, only valid for today',
      image: 'assets/images/chair.png',
    ),
    const BannerCard(
      discount: '25%',
      period: "Today's Special!",
      description: 'Get discount for every order, only valid for today',
      image: 'assets/images/chair.png',
    ),
    const BannerCard(
      discount: '25%',
      period: "Today's Special!",
      description: 'Get discount for every order, only valid for today',
      image: 'assets/images/chair.png',
    ),
    const BannerCard(
      discount: '25%',
      period: "Today's Special!",
      description: 'Get discount for every order, only valid for today',
      image: 'assets/images/chair.png',
    ),
    const BannerCard(
      discount: '14%',
      period: "Today's Special!",
      description: 'Get discount for every order',
      image: 'assets/images/sofa.png',
    ),
    const BannerCard(
      discount: '',
      period: "Today's Special!",
      description: 'Find discounts for today',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DefaultAppBar(
              title: 'Special Offers',
              trailing: InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Icon(Icons.more_horiz_outlined),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                itemCount: _bannerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: _bannerList[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Offers extends StatefulWidget {
  const Offers({
    super.key,
  });

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  int _currentIndex = 0;
  late List<Widget> _bannerList;

  @override
  void initState() {
    _bannerList = [
      const BannerCard(
        discount: '25%',
        period: "Today's Special!",
        description: 'Get discount for every order, only valid for today',
        image: 'assets/images/chair.png',
      ),
      const BannerCard(
        discount: '14%',
        period: "Today's Special!",
        description: 'Get discount for every order',
        image: 'assets/images/sofa.png',
      ),
      const BannerCard(
        discount: '',
        period: "Today's Special!",
        description: 'Find discounts for today',
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 18 / 8,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          }),
      items: _bannerList,
    );
  }
}
