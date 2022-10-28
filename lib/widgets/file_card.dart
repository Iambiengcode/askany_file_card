// import 'package:flutter/material.dart';

// class FileCard extends StatelessWidget {
//   final double? radius;
//   final Color? colorBackground;

//   const FileCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: colorBackground,
//         borderRadius: BorderRadius.circular(radius ?? 10),
//       ),
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: 10,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(
//             icon,
//             height: 28.sp,
//             width: 28.sp,
//           ),
//           SizedBox(width: 6.sp),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Dao-Hong-Vinh-...08123213123873.pdf',
//                 style: TextStyle(
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.w600,
//                   color: Theme.of(context).textTheme.bodyText1?.color,
//                 ),
//               ),
//               Text(
//                 '190,10 KB',
//                 style: TextStyle(
//                   fontSize: 8.sp,
//                   color: Theme.of(context).brightness == Brightness.dark
//                       ? colorGray2
//                       : colorGray1,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
