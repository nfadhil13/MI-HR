// import 'package:flutter/material.dart';
//
// class FutureImage extends StatelessWidget {
//   const FutureImage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String?>(
//       future: ,
//       builder: (ctx, snapshot) {
//         if(snapshot.hasData){
//           if(snapshot.data != null){
//             return Image.network(
//               _employee.imageURL,
//               headers: {
//                 'Cookie' : snapshot.data!
//               },
//               errorBuilder:(_, __, ___)  {
//                 print("Erroor");
//                 return Text("Error");
//               },
//               fit: BoxFit.cover,
//             );
//           }else{
//             _userDao.logout().then((value) => print("Logout"));
//           }
//         }
//         if(snapshot.hasError){
//           print(snapshot.error);
//         }
//         print("loading diluar");
//         return _buildLoadingImage();
//       },
//     );
//   }
// }
