import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailItemPage extends StatelessWidget {
  final String idItem;

  const DetailItemPage({super.key, required this.idItem});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Detal Produk'),
      ),
      body: Center(
        child: Text(idItem),
      ),
    ));
  }
}

// class _DetailItemPageState extends State<DetailItemPage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Halaman Detail Produk"),
//         ),
//         body: const Center(
//           child: Text(),
//         ),
//       ),
//     );
//   }
// }
