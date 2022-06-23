import 'package:flutter/material.dart';
import 'package:movie_app/widgetGenerators/apiCalls.dart';
import 'package:movie_app/widgets/movieListItem.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = TextEditingController();
  final Widget _loading = const Center(
    child: CircularProgressIndicator()
  );

  late Widget _currentPage;
  late Widget _mainBody;

  List<String> _dropdownValues = ["Streaming", "None"];

  late List popularMovies;
  late List upcomingMovies;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentPage = _loading;
    getAllMovies();
  }

  getAllMovies() async {
    APICalls api = APICalls();
    popularMovies = await api.getPopularMovies();
    upcomingMovies = await api.getUpcomingMovies();

    setState(() {
      _mainBody = mainBody();
      _currentPage = _buildContent();
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: const Color(0xFFE5E5E5),
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Hello",
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    Image(
                      image: AssetImage("assets/images/vector.png")
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),//or 15.0
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  color: Colors.white,
                  child: const Icon(Icons.person, color: Color(0xFF07C8D4), size: 30.0),
                ),
              ),

            ],
          ),
        ),
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE5E5E5),
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF07C8D4),
        onTap: _onItemTapped,
        showUnselectedLabels: false,
      ),
    );
  }

  Widget _buildContent(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                const Text(
                  "Millions of movies, TV shows to explore now.",
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 10.0,),
                Container(
                  height: 40,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) async {
                      if (value.isEmpty){
                        setState(() {
                          _mainBody = mainBody();
                          _currentPage = _buildContent();
                        });
                      }
                      setState(() {
                        _currentPage = _loading;
                      });

                      List results = await APICalls().search(value: value);

                      setState(() {
                        _mainBody = searchResults(results: results);
                        _currentPage = _buildContent();


                      });
                    },
                    controller: _searchController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(5),
                        hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFCCCCCC)),
                        hintText: "Search for movie, tv show....",
                        fillColor: const Color(0xFFF7F7F7),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isEmpty ? null : IconButton(
                          color: const Color(0xFFCCCCCC),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _mainBody = mainBody();
                              _currentPage = _buildContent();
                            });
                          },
                          icon: const Icon(Icons.clear),
                          iconSize: 20,
                          padding: const EdgeInsets.only(bottom: 1.0),
                        )
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0,),
            _mainBody
          ],
        ),
      ),
    );
  }

  Widget mainBody(){
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "What's Popular",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500
              ),
            ),
            Container(
              height: 24.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFD0F8FF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: DropdownButton(
                iconEnabledColor: Colors.red,
                underline: const SizedBox.shrink(),
                items: _dropdownValues
                    .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ))
                    .toList(),
                onChanged: (String? value) {},
                isExpanded: false,
                value: _dropdownValues.first,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0,),
        SizedBox(
          height: 180.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularMovies.length,
            itemBuilder: (_, i) {
              return popularMovies[i];
            },
          ),
        ),
        const SizedBox(height: 20.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Upcoming Movies",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500
              ),
            ),
            Container(
              height: 24.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFD0F8FF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: DropdownButton(
                iconEnabledColor: Colors.red,
                underline: const SizedBox.shrink(),
                items: _dropdownValues
                    .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ))
                    .toList(),
                onChanged: (String? value) {},
                isExpanded: false,
                value: _dropdownValues.first,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0,),
        SizedBox(
          height: 180.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: upcomingMovies.length,
            shrinkWrap: true,
            // controller: PageController(viewportFraction: 0.7),
            // onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return upcomingMovies[i];
            },
          ),
        ),
      ],
    );
  }

  Widget searchResults({results}){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Search Results",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500
              ),
            ),
            Container(
              height: 24.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFD0F8FF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: DropdownButton(
                iconEnabledColor: Colors.red,
                underline: const SizedBox.shrink(),
                items: _dropdownValues
                    .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ))
                    .toList(),
                onChanged: (String? value) {},
                isExpanded: false,
                value: _dropdownValues.first,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0,),
        SizedBox(
          height: 180.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: results.length,
            shrinkWrap: true,
            // controller: PageController(viewportFraction: 0.7),
            // onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return results[i];
            },
          ),
        ),
      ],
    );
  }
}
