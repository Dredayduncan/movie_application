import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/widgets/castItem.dart';

import '../widgets/movieListItem.dart';

class APICalls {

  Future<List> getPopularMovies() async {
    var url = Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=8245a3d992a2b57cad7bee0fd868e9a7&language=en-US&page=1");
    var response = await http.get(url);
    List results = [];

    List res = jsonDecode(response.body)['results'];

    for (var i = 0; i < 15; i++){

      results.add(
        MovieListItem(
          id: res[i]['id'].toString(),
          title: res[i]['title'],
          imagePath: res[i]['poster_path'],
          releaseDate: res[i]['release_date'],
        )
      );
    }
    return results;
  }

  Future<List> getUpcomingMovies() async {
    var url = Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=8245a3d992a2b57cad7bee0fd868e9a7&language=en-US");
    var response = await http.get(url);
    List results = [];

    List res = jsonDecode(response.body)['results'];

    for (var i = 0; i < 15; i++){

      results.add(
          MovieListItem(
            id: res[i]['id'].toString(),
            title: res[i]['title'],
            imagePath: res[i]['poster_path'],
            releaseDate: res[i]['release_date'],
          )
      );
    }
    return results;
  }

  Future<List> search({value}) async {
    String result = value.replaceAll(RegExp(' '), '+');
    var url = Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=8245a3d992a2b57cad7bee0fd868e9a7&query=$result");
    var response = await http.get(url);

    List res = jsonDecode(response.body)['results'];

    List results = [];

    for (var i = 0; i < 15; i++){

      results.add(
          MovieListItem(
            id: res[i]['id'].toString(),
            title: res[i]['title'],
            imagePath: res[i]['poster_path'],
            releaseDate: res[i]['release_date'],
          )
      );
    }
    return results;
  }

  Future<String> getMovieOverview({movieID}) async {
    var url = Uri.parse("https://api.themoviedb.org/3/movie/$movieID?api_key=8245a3d992a2b57cad7bee0fd868e9a7&language=en-US");
    var response = await http.get(url);

    return jsonDecode(response.body)['overview'];
  }

  Future<List> getMovieCast({movieID}) async {
    var url = Uri.parse("https://api.themoviedb.org/3/movie/$movieID/credits?api_key=8245a3d992a2b57cad7bee0fd868e9a7&language=en-US");
    var response = await http.get(url);
    List results = [];

    List res = jsonDecode(response.body)['cast'];

    for (var i = 0; i < res.length; i++){

      results.add(
        CastItem(
            name: res[i]['name'],
            image: res[i]['profile_path']
        )
      );
    }
    return results;
  }


}