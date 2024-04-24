import 'package:ets_ppb/components/movie_form.dart';
import 'package:ets_ppb/db/movie.dart';
import 'package:ets_ppb/models/movie.dart';
import 'package:flutter/material.dart';

class EditMoviePage extends StatefulWidget {
  final Movie? movie;

  const EditMoviePage({super.key, this.movie});

  @override
  State<EditMoviePage> createState() => _EditMoviePageState();
}

class _EditMoviePageState extends State<EditMoviePage> {
  final _formkey = GlobalKey<FormState>();
  late String _title;
  late String _imageUrl;
  late String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.movie?.title ?? '';
    _imageUrl = widget.movie?.imageUrl ?? '';
    _description = widget.movie?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: createOrUpdateMovie,
                icon: const Icon(Icons.save_rounded),
              ),
            ],
          ),
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MovieForm(
                title: _title,
                description: _description,
                imageUrl: _imageUrl,
                onTitleChanged: (title) => setState(() {
                      _title = title;
                    }),
                onImageUrlChanged: (imageUrl) => setState(() {
                      _imageUrl = imageUrl;
                    }),
                onDescriptionChanged: (description) => setState(() {
                      _description = description;
                    }),
                onSavedPressed: createOrUpdateMovie),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = _title.isNotEmpty && _imageUrl.isNotEmpty;

    return IconButton(
        onPressed: isFormValid ? () {} : null,
        icon: const Icon(Icons.save_rounded));
  }

  void createOrUpdateMovie() async {
    final isValid = _formkey.currentState!.validate();

    if (isValid) {
      if (widget.movie == null) {
        await createMovie();
      } else {
        await updateMovie();
      }
    }

    Navigator.of(context).pop();
  }

  Future updateMovie() async {
    final isValid = _formkey.currentState!.validate();

    if (isValid) {
      final movie = widget.movie?.copy(
        title: _title,
        imageUrl: _imageUrl,
        description: _description,
      );

      await MovieDatabase.instance.update(movie!);
    }
  }

  Future createMovie() async {
    final movie = Movie(
      title: _title,
      imageUrl: _imageUrl,
      description: _description,
      dateCreated: DateTime.now(),
      dateUpdated: DateTime.now(),
    );

    await MovieDatabase.instance.create(movie);
  }
}
