import 'package:ets_ppb/models/movie.dart';
import 'package:ets_ppb/page/detail_movie_page.dart';
import 'package:flutter/material.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({super.key, required this.movie, this.onPressed});

  final Movie movie;
  final Future<Null>? onPressed;

  @override
  Widget build(BuildContext context) {
    bool isUrlValid =
        movie.imageUrl.isNotEmpty && Uri.parse(movie.imageUrl).host.isNotEmpty;
    return InkWell(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieDetailPage(movie: movie)));

        if (onPressed != null) {
          onPressed;
        }
      },
      child: Column(
        children: <Widget>[
          Image.network(
            isUrlValid
                ? movie.imageUrl
                : "https://dummyimage.com/400x600/000000/fff.jpg&text=no+image",
            errorBuilder: (context, exception, stacktrace) {
              return const Card(child: Icon(Icons.error));
            },
          ),
          Text(movie.title),
        ],
      ),
    );
  }
}
