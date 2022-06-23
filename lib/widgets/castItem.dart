import 'package:flutter/material.dart';

class CastItem extends StatelessWidget {
  final String name;
  final String image;

  const CastItem({
    Key? key,
    required this.name,
    required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                          image: NetworkImage("https://image.tmdb.org/t/p/w500/$image"),
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
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ]
                  ),
                ),
              ],
            )
        )
    );
  }
}
