import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}


// class Shimmers extends StatelessWidget {
//   const Shimmers({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const ;
//   }
// }
// SizedBox(
//         height: MediaQuery.of(context).size.height,
//       ),
//       baseColor: Pallete.redColor,
//       highlightColor: Pallete.greenColor,
//     );
