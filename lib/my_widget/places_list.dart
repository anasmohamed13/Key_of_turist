import 'package:flutter/material.dart';
import 'package:key_of_turist/model/place.dart';
import 'package:key_of_turist/model_view/constants.dart';
import 'package:key_of_turist/view/details_screen.dart';


class PlacesListWidget extends StatefulWidget {
  final List<Places> placesList;
  final Constants constants;

  const PlacesListWidget({
    Key? key,
    required this.placesList,
    required this.constants,
  }) : super(key: key);

  @override
  State<PlacesListWidget> createState() => _PlacesListWidgetState();
}

class _PlacesListWidgetState extends State<PlacesListWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildPlacesList();
  }

  Widget _buildPlacesList() {
    if (widget.placesList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return GridView.count(
        crossAxisCount: 2,
        children: widget.placesList.map((place) => _buildPlaceCard(place)).toList(),
      );
    }
  }

  Widget _buildPlaceCard(Places place) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      color: Colors.amber[200],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,           children: [
            _buildPlaceImage(place),
            _buildNameAndDescription(place),
            _buildShowMoreButton(place),
          ]),
        ),
      ),
    );
  }

  Widget _buildPlaceImage(Places place) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      child: Image.network(
        place.placeImages?.isNotEmpty == true ? place.placeImages![0].image ?? '' : '',
        width: 300,
        height: 150,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildNameAndDescription(Places place) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.name,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            place.description,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowMoreButton(Places place) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: place.name != 'Item not found',
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
              ),
              child: const Text(
                "Show More ..",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceDetailsScreen(place: place),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}