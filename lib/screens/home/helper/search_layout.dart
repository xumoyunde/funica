import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funica/components/my_button.dart';
import 'package:funica/components/search_field.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/home/components/popular_product.dart';
import 'package:funica/screens/home/components/recent.dart';
import 'package:funica/screens/home/helper/filter_product.dart';
import 'package:get/route_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SearchLayout extends StatefulWidget {
  const SearchLayout({super.key});

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  bool showBottomSheet = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
        child: Column(
          children: [
            SearchField(
              suffix: InkWell(
                onTap: () {
                  bottomSheet(context: context);
                },
                child: const Icon(CupertinoIcons.settings),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Clear All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 40,
              thickness: 1,
            ),
            const Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                    Recent(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // bottomSheet: showBottomSheet ? null : null,
    );
  }
}

bottomSheet({required context}) {
  final List<Widget> _popularProduct = [
    const PopularProduct(
      productName: 'All',
    ),
    const PopularProduct(
      productName: 'Sofa',
    ),
    const PopularProduct(
      productName: 'Chair',
    ),
    const PopularProduct(
      productName: 'Table',
    ),
    const PopularProduct(
      productName: 'Kitchen',
    ),
    const PopularProduct(
      productName: 'Chair',
    ),
    const PopularProduct(
      productName: 'Chair',
    ),
  ];

  final List<Widget> _sortBy = [
    const PopularProduct(
      productName: 'Popular',
    ),
    const PopularProduct(
      productName: 'Most Recent',
    ),
    const PopularProduct(
      productName: 'Price High',
    ),
    const PopularProduct(
      productName: 'Price Medium',
    ),
    const PopularProduct(
      productName: 'Price Low',
    ),
  ];

  final List<Widget> _rating = [
    const PopularProduct(
      productName: '️All',
      icon: Icons.star,
    ),
    const PopularProduct(
      productName: '5',
      icon: Icons.star,
    ),
    const PopularProduct(
      productName: '️4',
      icon: Icons.star,
    ),
    const PopularProduct(
      productName: '3',
      icon: Icons.star,
    ),
    const PopularProduct(
      productName: '2',
      icon: Icons.star,
    ),
    const PopularProduct(
      productName: '1',
      icon: Icons.star,
    ),
  ];

  RangeValues _currentRangeValues = const RangeValues(40, 80);

  String productIndex = '';

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(40),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.only(top: 5, right: 20, left: 20),
        // height: MediaQuery.of(context).size.height * .8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
                child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(50),
              ),
            )),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Sort & Filter',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 40,
            ),
            const Text(
              'Categories',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _popularProduct.length,
                itemBuilder: (context, index) {
                  // productIndex = _popularProduct[2].;
                  return _popularProduct[index];
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Price Range',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            RangeSlider(
              activeColor: Colors.black,
              inactiveColor: Colors.grey.shade200,
              values: _currentRangeValues,
              max: 100,
              divisions: 5,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                _currentRangeValues = values;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Sort by',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _sortBy.length,
                itemBuilder: (context, index) {
                  return _sortBy[index];
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Rating',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _rating.length,
                itemBuilder: (context, index) {
                  return _rating[index];
                },
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 40),
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    onTap: () {},
                    title: 'Reset',
                    theme: 'light',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: MyButton(
                      onTap: () {
                        // Get.toNamed(AppRoute.filter,
                        //     arguments: FilterProduct(
                        //       productName: _popularProduct[index],
                        //     ));
                      },
                      title: 'Apply'),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      );
    },
  );
}
