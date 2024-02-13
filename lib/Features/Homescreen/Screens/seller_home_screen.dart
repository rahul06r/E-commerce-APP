import 'package:app_ecommerce/Features/Auth/Screens/seller_request_screen.dart';
import 'package:app_ecommerce/Features/Homescreen/Screens/bottomNavBar/acoountScren_tab.dart';
import 'package:app_ecommerce/Features/Homescreen/Screens/bottomNavBar/add_product_screen_tab.dart';
import 'package:app_ecommerce/Features/Homescreen/Screens/bottomNavBar/all_orders_tab.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellerHomeScreen extends ConsumerStatefulWidget {
  const SellerHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SellerHomeScreenState();
}

class _SellerHomeScreenState extends ConsumerState<SellerHomeScreen> {
  int _btmIndex = 0;
  final List<Widget> _pages = [
    const SellerRequestScreen(),
    // const SellerRequestScreen(),
    const AddProductTab(),
    const AllOrdersTab(),
    const AccountScreentab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.loginBgColor,
          centerTitle: true,
          title: const Text(
            "ShopStream",
            style: TextStyle(
              letterSpacing: 1,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Pallete.loginBgColor,
          selectedIconTheme: const IconThemeData(
            color: Pallete.whiteColor,
          ),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Pallete.whiteColor,
          selectedLabelStyle: const TextStyle(color: Pallete.whiteColor),
          currentIndex: _btmIndex,
          onTap: (index) {
            setState(() {
              _btmIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Add',
              icon: Icon(
                Icons.add,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Orders',
              icon: Icon(
                Icons.online_prediction_rounded,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
        body: _pages[_btmIndex]);
  }
}
