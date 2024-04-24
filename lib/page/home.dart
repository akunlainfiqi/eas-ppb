import 'package:ets_ppb/components/movie_card.dart';
import 'package:ets_ppb/db/movie.dart';
import 'package:ets_ppb/models/movie.dart';
import 'package:ets_ppb/page/edit_movie_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late List<Movie> _movies;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _movies = [];
    _loadMovies();
  }

  @override
  void dispose() {
    MovieDatabase.instance.close();
    super.dispose();
  }

  Future<void> _loadMovies() async {
    setState(() {
      isLoading = true;
    });

    final movies = await MovieDatabase.instance.getAll();
    setState(() {
      _movies = movies;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EditMoviePage(),
            ),
          );

          _loadMovies();
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return MovieCardWidget(
                  movie: movie,
                );
              },
            ),
    );
  }
}
