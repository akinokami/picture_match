import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:picture_match/views/widgets/custom_card.dart';
import 'package:picture_match/views/widgets/custom_text.dart';

class GameTimerMobile extends StatelessWidget {
  const GameTimerMobile({
    required this.time,
    super.key,
  });

  final Duration time;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: 1.sw * 0.40,
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.timer,
            size: 20.sp,
          ),
          CustomText(
            text: time.toString().split('.').first.padLeft(8, "0"),
          )
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class GameTimerMobile extends StatelessWidget {
//   const GameTimerMobile({
//     required this.time,
//     super.key,
//   });

//   final Duration time;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(
//         vertical: 20,
//         horizontal: 60,
//       ),
//       elevation: 8,
//       clipBehavior: Clip.antiAlias,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       color: Colors.red[700],
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             const Expanded(
//               flex: 1,
//               child: Icon(
//                 Icons.timer,
//                 size: 40,
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Text(
//                 textAlign: TextAlign.center,
//                 time.toString().split('.').first.padLeft(8, "0"),
//                 style: const TextStyle(
//                   fontSize: 28.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
