import 'package:flutter/material.dart';
import 'package:key_of_turist/model/place.dart';
import 'package:key_of_turist/model_view/constants.dart';
import 'package:key_of_turist/model_view/data_repo.dart';
import 'package:key_of_turist/my_widget/places_list.dart';


class SearchedCard extends StatefulWidget {
  final String searchText;
  const SearchedCard({ required this.searchText , super.key});

  @override
  State<SearchedCard> createState() => _SearchedCardState();
}

class _SearchedCardState extends State<SearchedCard> {
  final DataRepo _dataRepo = DataRepo(Constants());
  late List<Places> _placesList = [];
  late final Constants _constants = Constants();
  List<Places> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      List<Places> placesList = await _dataRepo.fetchTravelPlaces();
      setState(() {
        _placesList = placesList;
        _searchResults = placesList;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  void _search(String query) {
    query = query.toLowerCase();
    setState(() {
      _searchResults = _placesList.where((place) {
        final lowerCaseName = place.name.toLowerCase();
        // Split the query into words and check if any word is present in the place name
        final queryWords = query.split(' ');
        return queryWords.any((word) => lowerCaseName.contains(word));
      }).toList();
    });
  }

  void _clearSearchResults() {
    setState(() {
      _searchResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          "Swah",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Expanded(
        child: PlacesListWidget(
          placesList: _searchResults.isEmpty ? _placesList : _searchResults,
          constants: _constants,
        ),
      ),
    );
  }
}
