// import 'package:flutter/material.dart';
//
// import '../models/agenda.dart';
//
// class displayCard extends StatefulWidget {
//
//   const displayCard({Key? key,}) : super(key: key);
//
//   @override
//   State<displayCard> createState() => _displayCardState();
// }
//
// class _displayCardState extends State<displayCard> {
//   String _subtotal = hitungSubtotal(1);
//   String _info = "Total Keseluruhan Saldo";
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.8,
//       height: MediaQuery.of(context).size.height / 2,
//       child: Container(
//             margin: const EdgeInsets.symmetric(vertical: 30.0),
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             decoration: BoxDecoration(
//               color: Color(0xff2093c3),
//               border: Border.all(color: Colors.tealAccent,width: 3),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     Column(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.monetization_on),
//                           color: Colors.white,
//                           onPressed: (){
//                             setState(() {
//                               _subtotal = hitungSubtotal(1);
//                               _info = "Total Keseluruhan Saldo";
//                             });
//                           },
//                         ),
//                         const Text(
//                           "     Saldo    ",
//                           style: TextStyle(
//                             fontFamily: "Poppins",
//                             color: Colors.white,
//                           ),
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.wallet),
//                           color: Colors.white,
//                           onPressed: (){
//                             setState(() {
//                               _subtotal = hitungSubtotal(2);
//                               _info = "Total Pendapatan yang Diterima";
//                             });
//                           },
//                         ),
//                         const Text(
//                             "Pendapatan",
//                             style: TextStyle(
//                               fontFamily: "Poppins",
//                               color: Colors.white,
//                             )
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.wallet_travel),
//                           color: Colors.white,
//                           onPressed: (){
//                             setState(() {
//                               _subtotal = hitungSubtotal(3);
//                               _info = "Total Pengeluaran yang Digunakan";
//                             });
//                           },
//                         ),
//                         const Text(
//                           "Pengeluaran",
//                             style: TextStyle(
//                               fontFamily: "Poppins",
//                               color: Colors.white,
//                             )
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 Container(
//                     margin: const EdgeInsets.symmetric(vertical: 15.0),
//                     child: Center(
//                       child: Text(
//                         _info,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           fontFamily: "Poppins",
//                         ),
//                       ),
//                     )
//                 ),
//                 Center(
//                   child: Text(
//                     _subtotal,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontFamily: "Poppins",
//                     ),
//                   ),
//                 ),
//               ],
//             )
//         ),
//     );
//   }
// }
//
// String hitungSubtotal(int idx) {
//   int subtotalAll = 0;
//   int subtotalPendapatan = 0;
//   int subtotalPengeluaran = 0;
//   listKas.forEach((element) {
//     if(element.isPendapatan) {
//       subtotalAll += element.nominal;
//       subtotalPendapatan += element.nominal;
//     }
//     else {
//       subtotalAll -= element.nominal;
//       subtotalPengeluaran += element.nominal;
//     }
//   });
//   if(idx == 1) {
//     return "Rp. ${subtotalAll}";
//   }
//   else if(idx == 2) {
//     return "Rp. ${subtotalPendapatan}";
//   }
//   else{
//     return "Rp. ${subtotalPengeluaran}";
//   }
// }
