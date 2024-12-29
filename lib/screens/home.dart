import 'package:flutter/material.dart';
import '../main.dart';
import '../services/api_service.dart';
import '../widgets/emoji_button.dart';
import '../widgets/joke_card.dart';
import 'favorites.dart';
import 'joke_list.dart';
import 'random_joke.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('213091 Joke Type'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.casino),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => RandomJokePage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: EmojiButton(),
//           ),
//           Expanded(
//             child: FutureBuilder<List<String>>(
//               future: ApiService.fetchJokeTypes(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else {
//                   final types = snapshot.data!;
//                   return ListView.builder(
//                     itemCount: types.length,
//                     itemBuilder: (context, index) {
//                       return JokeCard(
//                         title: types[index],
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   JokeListPage(type: types[index]),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildStandardAppBar(context, title: '213091 Joke Type'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: EmojiButton(),
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: ApiService.fetchJokeTypes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final types = snapshot.data!;
                  return ListView.builder(
                    itemCount: types.length,
                    itemBuilder: (context, index) {
                      return JokeCard(
                        title: types[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  JokeListPage(type: types[index]),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}