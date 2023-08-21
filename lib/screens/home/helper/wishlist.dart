import 'package:flutter/material.dart';
import 'package:funica/firebase_helper/firestore.dart';
import 'package:funica/models/category_model.dart';
import 'package:funica/models/product_model.dart';
import 'package:funica/screens/home/components/category_builder.dart';
import 'package:funica/screens/home/components/default_appbar.dart';
import 'package:funica/screens/home/components/product.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<CategoryModel> _categoryList = [];
  List<ProductModel> _productList = [];
  List<ProductModel> _filteredProductList = [];

  String _selectedCategory = '';

  bool isLoading = false;

  Future<void> getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    _categoryList = await FirebaseFirestoreService.instance.getCategory();
    _categoryList.insert(0, CategoryModel(name: 'All', id: ''));
    _productList = await FirebaseFirestoreService.instance.getProduct();
    setState(() {
      isLoading = false;
      _filteredProductList = _productList;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  bool isPressed = false;

  String selectedCategory = 'All';

  // This function is called whenever the category is selected
  void filterProductsByCategory(String enteredKeyword) {
    setState(() {
      isLoading = true;
    });
    List<ProductModel> products = [];
    if (enteredKeyword == 'All') {
      // if the keyword is 'All', show all products
      products = _productList;
      setState(() {
        isLoading = false;
      });
    } else {
      // otherwise, filter by category id
      products = _productList
          .where((product) => product.category == enteredKeyword)
          .toList();
      setState(() {
        isLoading = false;
      });
    }

    // Refresh the UI
    setState(() {
      _filteredProductList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _categoryList.add(CategoryModel(name: 'All', id: ''));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DefaultAppBar(
              title: 'My Wishlist',
              trailing: InkWell(
                child: const Icon(Icons.search),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _categoryList.length,
                itemBuilder: (context, index) {
                  return CategoryBuilder(
                      name: _categoryList[index].name,
                      selectedCategory: selectedCategory,
                      click: () {
                        filterProductsByCategory(_categoryList[index].name);
                        setState(() {
                          selectedCategory = _categoryList[index].name;
                        });
                      });
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 30,
                    childAspectRatio: 8 / 12),
                itemCount: _filteredProductList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Product(
                    product: _filteredProductList[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
