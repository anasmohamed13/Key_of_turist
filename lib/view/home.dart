import 'package:flutter/material.dart';
import 'package:key_of_turist/model/place.dart';
import 'package:key_of_turist/model_view/constants.dart';
import 'package:key_of_turist/model_view/data_repo.dart';
import 'package:key_of_turist/my_widget/my_searchbar.dart';
import 'package:key_of_turist/my_widget/places_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final Places place;
  final DataRepo _dataRepo = DataRepo(Constants());
  late List<Places> _placesList;
  late TextEditingController _textController;
  late List<Places> _filteredPlacesList;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _placesList = [];
    _filteredPlacesList = [];
    _textController = TextEditingController();
    _loadData();

    _tabController = TabController(
      vsync: this,
      length: 3, // TODO 1 : make this comes from API
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      List<Places> placesList = await _dataRepo.fetchTravelPlaces();
      setState(() {
        _placesList = placesList;
        _filteredPlacesList = placesList; // Initially, show all places
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  void _filterPlaces(String searchText) {
    setState(() {
      // Use the 'where' method to filter places based on the search text
      _filteredPlacesList = _placesList
          .where((place) =>
              place.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void _handleSearch(String searchText) async {
    // Clear the previous filtered list
    _filteredPlacesList.clear();

    // Check if the search text is empty
    if (searchText.isNotEmpty) {
      // Perform the search asynchronously
      await Future.delayed(const Duration(milliseconds: 300));

      setState(() {
        // If the filtered list is empty, show a message
        if (_filteredPlacesList.isEmpty) {
          _filteredPlacesList.add(
            Places(
              placeImages: [PlaceImages(id: 0, image: Constants.errorImage)],
              name: 'Item not found',
              description: 'Please try again.',
              rate: 0,
              // open: null,
              status: false,
              entrancePrice: 0,
              // closed: null,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: const Text(
            "Key of tourist",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          bottom: TabBar(
              isScrollable: false,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "Islamic",
                ),
                Tab(
                  text: "Pharaonic",
                ),
                Tab(text: "Christian"),
              ]),
        ),
        resizeToAvoidBottomInset: true,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 2.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                    child: MySearchBar(
                      hintText: "  Where to ?",
                      onSubmitted: _handleSearch,
                      onChanged: _filterPlaces,
                    ),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      onPressed: () {
                        _handleSearch(_textController.text);
                      }),
                  IconButton(
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      size: 30,
                    ),
                    onPressed: () {
                      // add you AI function
                    },
                  )
                ]),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  // Content for the "All" tab
                  PlacesListWidget(
                    placesList: _filteredPlacesList,
                    constants: Constants(),
                  ),

                  // Content for the "Islamic" tab
                  PlacesListWidget(
                      placesList: _filteredPlacesList
                          .where((place) => place.placeType?.id == 2)
                          .toList(),
                      constants: Constants()),

                  // Content for the "Pharaonic" tab
                  PlacesListWidget(
                    placesList: _filteredPlacesList
                        .where((place) => place.placeType?.id == 1)
                        .toList(),
                    constants: Constants(),
                  ),

                  // Content for the "Christian" tab

                  PlacesListWidget(
                    placesList: _filteredPlacesList
                        .where((place) => place.placeType?.id == 3)
                        .toList(),
                    constants: Constants(),
                  ),
                ]),
              ),
            ]),
      ),
    );
  }
}
