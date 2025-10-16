// import 'package:flutter/material.dart';
// import '../../../utills/helpers.dart';
//
// class TruckVtsCard extends StatelessWidget {
//   final TruckVts truckVtsItem;
//   const TruckVtsCard({super.key, required this.truckVtsItem});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         color: Colors.white,
//         elevation: 0.25,
//         surfaceTintColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         margin: EdgeInsets.zero,
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         color: Constants.primary50,
//                         borderRadius: BorderRadius.circular(4)
//                     ),
//                     padding: const EdgeInsets.all(6),
//                     child: Image.asset("assets/images/truck.png", color: Constants.primary, height: 20),
//                   ),
//                   const SizedBox(width: 8,),
//                   Expanded(child: Text(truckVtsItem.truckNumber, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 16))),
//                   const SizedBox(width: 8,),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: truckVtsItem.isError ? Colors.red.shade50 : Colors.green.shade50,
//                       borderRadius: BorderRadius.circular(30)
//                     ),
//                     child: Text(truckVtsItem.isError ? "Failure" : "Success", style: TextStyle(color: truckVtsItem.isError ? Colors.red : Colors.green, fontSize: 14)),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Text("Latitude", style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 12.5),),
//               const SizedBox(height: 4),
//               Text("${truckVtsItem.latitude}", style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 14)),
//               const SizedBox(height: 20),
//               Text("Longitude", style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 12.5),),
//               const SizedBox(height: 4),
//               Text("${truckVtsItem.longitude}", style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 14)),
//               const SizedBox(height: 20),
//               Text("VTS Date & Time", style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 12.5),),
//               const SizedBox(height: 4),
//               Text(Helpers.parseDateTime(truckVtsItem.vtsDate), style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 14)),
//             ],
//           ),
//         )
//     );
//   }
// }
