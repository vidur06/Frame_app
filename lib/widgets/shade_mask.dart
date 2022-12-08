// import 'package:flutter/material.dart';

// Widget linerGradient() {
//   return ShaderMask(
//     blendMode: BlendMode.color,
//     shaderCallback: (rect) => const LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [
//         Colors.red,
//         Colors.green,
//       ],
//     ).createShader(rect),
//     child: ColorFiltered(
//       colorFilter: currentFilter,
//       child: PhotoView(
//         backgroundDecoration: const BoxDecoration(color: Colors.white),
//         enablePanAlways: true,
//         enableRotation: true,
//         imageProvider: FileImage(
//           (_image != null) ? _image : res[0],
//         ),
//       ),
//     ),
//   );
// }
