import 'package:flutter/material.dart';
import 'package:movies_app/models/movies/movie_filters.dart';
class MoviesSearchBar extends StatefulWidget {
  final MovieFilters? filters;
  final Function(MovieFilters) onSearch;
  const MoviesSearchBar({
    Key? key,
    required this.filters,
    required this.onSearch
  }) : super(key: key);

  @override
  State<MoviesSearchBar> createState() => _MoviesSearchBarState();
}

class _MoviesSearchBarState extends State<MoviesSearchBar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MovieFilters _filters = MovieFilters();

  @override
  void initState() {
    if(widget.filters != null) {
      _filters.fromMovieFilters(widget.filters!);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        validator: (value) => value?.isNotEmpty != false ? null
            : "required",
        onSaved: (value){
          _filters.name = value;
        },
        textInputAction: TextInputAction.search,
        onEditingComplete: (){
          if(_formKey.currentState?.validate() == false){
            return;
          }
          _formKey.currentState?.save();
          widget.onSearch(_filters);
        },
        decoration: const InputDecoration(
          label: Text("Search")
        ),
      ),
    );
  }
}
