// import 'package:belajar_api/model/album.dart';
// import 'package:flutter/material.dart';

// class EditScreen extends StatefulWidget {
//   const EditScreen({super.key});

//   @override
//   State<EditScreen> createState() => _EditScreenState();
// }

// class _EditScreenState extends State<EditScreen> {
//   final TextEditingController _controller = TextEditingController();
//   late Future<Album> _futureAlbum;

//   // void fetchAlbums() async {
//   //   final result = await AlbumService.fetchAlbum();
//   //   albums = result;
//   //   setState(() {});
//   // }

//   @override
//   void initState() {
//     super.initState();
//     _futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         child: FutureBuilder<Album>(
//           future: _futureAlbum,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.hasData) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(snapshot.data!.title),
//                     TextField(
//                       controller: _controller,
//                       decoration: const InputDecoration(
//                         hintText: 'Enter Title',
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _futureAlbum = updateAlbum(_controller.text);
//                         });
//                       },
//                       child: const Text('Update Data'),
//                     ),
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }
//             }
//             return const CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }
