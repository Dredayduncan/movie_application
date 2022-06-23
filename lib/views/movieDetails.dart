import 'package:flutter/material.dart';
import 'package:movie_app/widgetGenerators/apiCalls.dart';

class MovieDetails extends StatefulWidget {
  final String image;
  final String title;
  final String releaseDate;
  final String id;

  const MovieDetails({
    Key? key,
    required this.id,
    required this.image,
    required this.title,
    required this.releaseDate

  }) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late String overview;
  late List movieCast;
  Widget _currentPage = const Center(
    child: CircularProgressIndicator(),
  );



  @override
  void initState() {
    super.initState();
    getAllDetails();
  }

  getAllDetails() async {
    APICalls api = APICalls();
    overview = await api.getMovieOverview(movieID: widget.id);
    movieCast = await api.getMovieCast(movieID: widget.id);

    setState(() {
      _currentPage = _buildContent();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: _currentPage
    );
  }

  Widget _buildContent(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageHeader(context),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              overview,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15.0,
                color: Color(0xFF7A7A7A)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Cast",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(
            height: 150.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieCast.length,
              shrinkWrap: true,
              // controller: PageController(viewportFraction: 0.7),
              // onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (_, i) {
                return movieCast[i];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              width: 400,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF07C8D4)
                ),
                onPressed: () {},
                child: Text("Play Trailer"),
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: (){},
              child: const Text(
                "Download",
                style: TextStyle(
                  color: Color(0xFF40404C)
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _imageHeader(BuildContext context){
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            height: 450,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0)),
              image: DecorationImage(
                  image: NetworkImage("https://image.tmdb.org/t/p/w500/${widget.image}"),
                  fit: BoxFit.fill),
            ),
          )
        ),
        Positioned(
          top: 70,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),//or 15.0
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          color: const Color(0xFF07C8D4),
                          iconSize: 20.0, onPressed: () {
                            // Navigator.pop();
                            Navigator.of(context).pop();
                      },),
                    ),
                  ),
                ),
                const SizedBox(width: 300),
                // Spacer(),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    )
                )
              ],

            ),
          ),
        ),
        Positioned(
          top: 300,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        widget.releaseDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.only(right: 135.0),
                      child: Container(
                        height: 24.0,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF07C8D4),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Action",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 100,),
                Text(
                  widget.releaseDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
