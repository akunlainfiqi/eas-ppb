import 'package:ets_ppb/db/movie.dart';
import 'package:ets_ppb/models/movie.dart';
import 'package:ets_ppb/page/edit_movie_page.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie? movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Movie movie;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    movie = widget.movie!;
  }

  @override
  Widget build(BuildContext context) {
    bool isUrlValid =
        movie.imageUrl.isNotEmpty && Uri.parse(movie.imageUrl).host.isNotEmpty;
    return Scaffold(
      appBar: AppBar(actions: [editButton(), deleteButton()]),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              Text(
                "judul: ${movie.title}",
              ),
              Text(
                "deskripsi: ${movie.description}",
              ),
              Text(
                "url: ${movie.imageUrl}",
              ),
              isUrlValid ? Image.network(movie.imageUrl) : const SizedBox(),
            ],
          )),
    );
  }

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditMoviePage(movie: movie),
        ));

        Navigator.of(context).pop();
      });
  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await MovieDatabase.instance.delete(widget.movie?.id ?? 0);

          Navigator.of(context).pop();
        },
      );
}
