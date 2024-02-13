import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/BottomTab_buyer/buyer_account_tab.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/BottomTab_buyer/buyer_cart_tab.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/BottomTab_buyer/buyer_category_tab.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/BottomTab_buyer/buyer_home_tab.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/BottomTab_buyer/buyer_order_tab.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/searchDelegate.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuyerHomeScreen extends ConsumerStatefulWidget {
  static const String routeName = '/buyerHomeScreen';
  const BuyerHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends ConsumerState<BuyerHomeScreen> {
  int _btmIndex = 0;
  final List<Widget> _pages = [
    const BuyerHometab(),
    const BuyercategoryTab(),
    const BuyerCartTab(),
    const BuyerOrdertab(),
    const BuyerAccountTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            _btmIndex == 0
                ? Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {
                        showSearch(
                            context: context, delegate: SearchDeatils(ref));
                      },
                      icon: const Icon(Icons.search),
                    ),
                  )
                : Container(),
          ],
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
              label: 'Category',
              icon: Icon(Icons.category_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Cart',
              icon: Icon(Icons.trolley),
            ),
            BottomNavigationBarItem(
              label: 'Order',
              icon: Icon(
                Icons.card_giftcard,
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
