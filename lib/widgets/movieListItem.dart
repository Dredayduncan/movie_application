import 'package:flutter/material.dart';
import 'package:movie_app/views/movieDetails.dart';

class MovieListItem extends StatelessWidget {
  final String id;
  final String releaseDate;
  final String title;
  final String imagePath;


  const MovieListItem({
    Key? key,
    required this.id,
    required this.releaseDate,
    required this.title,
    required this.imagePath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetails(
                  id: id,
                  image: imagePath,
                  title: title,
                  releaseDate: releaseDate
                )
            )
        );
      },
      child: SizedBox(
          width: 170,
          child: Card(
              color: Color(0xFF5E5E5),
              elevation: 0.0,
              margin: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image:
                        DecorationImage(
                            image: NetworkImage("https://image.tmdb.org/t/p/w500/$imagePath"),
                                fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            releaseDate,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xFF7A7A7A),
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ]
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }
}
