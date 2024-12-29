import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/joke.dart';
import '../providers/joke_provider.dart';
import '../services/api_service.dart';
import 'package:provider/provider.dart';

// class JokeListPage extends StatelessWidget {
//   final String type;
//
//   const JokeListPage({required this.type, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$type Jokes'),
//       ),
//       body: FutureBuilder<List<Joke>>(
//         future: ApiService.fetchJokesByType(type),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final jokes = snapshot.data!;
//             return ListView.builder(
//               itemCount: jokes.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(jokes[index].setup),
//                   subtitle: Text(jokes[index].punchline),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }


class JokeListPage extends StatelessWidget {
  final String type;

  const JokeListPage({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildStandardAppBar(context, title: '$type Joke'),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jokes = snapshot.data!;
            return Consumer<JokeProvider>(  // Consumer to listen to changes
              builder: (context, favoritesProvider, child) {
                return ListView.builder(
                  itemCount: jokes.length,
                  itemBuilder: (context, index) {
                    final joke = jokes[index];
                    final isFavorite = favoritesProvider.isFavorite(joke.setup);

                    return ListTile(
                      title: Text(joke.setup),
                      subtitle: Text(joke.punchline),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            favoritesProvider.removeFavorite(joke.setup);
                          } else {
                            favoritesProvider.addFavorite(joke.setup, joke.punchline);
                          }
                        },
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
