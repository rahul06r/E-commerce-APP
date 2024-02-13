import 'package:app_ecommerce/Admin_Part/Features/Admin_Auth/Controller/admin_auth_contro.dart';
import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Screens/adminHomeScreen.dart';
import 'package:app_ecommerce/Admin_Part/Models/Admin_model.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Auth/Controller/buyer_auth_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/buyer_home_screen.dart';
import 'package:app_ecommerce/Buyer_Part/Models/Buyer_Model.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Features/Auth/Controller/seller_auth_contro.dart';
import 'package:app_ecommerce/Features/Auth/Screens/seller_signup_screen.dart';
import 'package:app_ecommerce/Features/Homescreen/Screens/seller_home_screen.dart';
import 'package:app_ecommerce/Models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  SellerModel? sellerModel;

  void getuserData(User data, WidgetRef ref) async {
    sellerModel = await ref
        .watch(sellerauthControllerProvider.notifier)
        .getUserdata(data.uid)
        .first;
    if (sellerModel != null) {
      ref.read(sellerUserProvider.notifier).update((state) => sellerModel);
      // print(s)
      setState(() {});
    }
  }

  // BuyerModel? buyerModel;
  // void getuserData(User data, WidgetRef ref) async {
  //   buyerModel = await ref
  //       .watch(buyerAuthControProvider.notifier)
  //       .getUserdata(data.uid)
  //       .first;
  //   if (buyerModel != null) {
  //     ref.read(buyerUserProvider.notifier).update((state) => buyerModel);
  //     // print(s)
  //     setState(() {});
  //   }
  // }
  // AdminModel? adminModel;
  // void getuserData(User data, WidgetRef ref) async {
  //   adminModel = await ref
  //       .watch(adminAuthControProvider.notifier)
  //       .getUserdata(data.uid)
  //       .first;
  //   if (adminModel != null) {
  //     ref.read(admiUserProvider.notifier).update((state) => adminModel);
  //     // print(s)
  //     setState(() {});
  //   }
  // }
  //
  // chnage to sellerauthstatechnagesprovider
  // chnage to adminauthstatechanegprovider

  @override
  Widget build(BuildContext context) {
    return ref.watch(sellerAuthStateChangedProvider).when(data: (data) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          // themeMode: ThemeMode.dark,
          // darkTheme: ThemeData.dark()
          title: 'Ecommerce App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Builder(builder: (context) {
            if (data != null) {
              getuserData(data, ref);
              if (sellerModel != null) {
                // return const AdminHomeScreen();
                // return const BuyerHomeScreen();
                return const SellerHomeScreen();
              }

              return const SellerSignupScreen();
            } else {
              return const SellerSignupScreen();
            }
          }));
    }, error: (error, stackTrace) {
      return ErrorText(errorMessage: error.toString());
    }, loading: () {
      return const Loader();
    });
  }
}
