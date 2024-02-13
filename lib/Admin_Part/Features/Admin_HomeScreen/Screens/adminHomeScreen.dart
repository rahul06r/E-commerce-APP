import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Screens/BottomTabBar/admin_account_tab.dart';
import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Screens/BottomTabBar/admin_add_screen.dart';
import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Screens/BottomTabBar/admin_hometab.dart';
import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Screens/BottomTabBar/admin_seller_accept_tab.dart';
import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Screens/Extra_Screen/searchSeller_delegate.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/searchDelegate.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Extra_Screen/searchProducts_delegate.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen> {
  int _btmIndex = 0;
  final List<Widget> _pages = [
    const AdminHomeTab(),
    const AdminAddTab(),
    const AdminSellerAcceptTab(),
    const AdminAccountTab(),
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
                        context: context,
                        delegate: SearchProductsDelegate(ref),
                      );
                    },
                    icon: const Icon(Icons.search),
                  ),
                )
              : Container(),
          _btmIndex == 2
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: SearchSellerDelegate(ref));
                    },
                    icon: const Icon(Icons.search),
                  ),
                )
              : Container(),
        ],
        backgroundColor: Pallete.blueColor,
        centerTitle: true,
        title: const Text(
          "ShopStream",
          style: TextStyle(
            letterSpacing: 1,
            fontSize: 22,
            color: Pallete.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Pallete.whiteColor,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Pallete.blueColor,
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
            icon: Icon(Icons.add),
          ),
          BottomNavigationBarItem(
            label: 'Seller',
            icon: Icon(Icons.person_search_sharp),
          ),
          // BottomNavigationBarItem(
          //   label: 'Order',
          //   icon: Icon(
          //     Icons.card_giftcard,
          //     size: 30,
          //   ),
          // ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: _pages[_btmIndex],
    );
  }
}
