class Places {
  int? id;
  String name;
  String description;
  double? rate;
  bool? status;
  String? open;
  double? entrancePrice;
  String? closed;
  List<PlaceImages>? placeImages;
  int? placeTypeId;
  PlaceType? placeType;

  Places({
    this.id,
    required this.name,
    required this.description,
    this.rate,
    this.status,
    this.open,
    this.entrancePrice,
    this.closed,
    this.placeImages,
    this.placeTypeId,
    this.placeType,
  });

  // Named constructor for creating a Places instance from JSON
  Places.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        rate = json['rate'],
        status = json['status'],
        open = json['open'],
        entrancePrice = json['entrancePrice'],
        closed = json['closed'],
        placeImages = List<PlaceImages>.from(
          json['placeImages']?.map((x) => PlaceImages.fromJson(x)) ?? [],
        ),
        placeTypeId = json['placeTypeId'],
        placeType = json['placeType'] != null
            ? PlaceType.fromJson(json['placeType'])
            : null;

  // Method for converting Places instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'description': description,
      'rate': rate,
      'status': status,
      'open': open,
      'entrancePrice': entrancePrice,
      'closed': closed,
      'placeImages': placeImages?.map((x) => x.toJson()).toList(),
      'placeTypeId': placeTypeId,
      'placeType': placeType?.toJson(),
    };

    // Remove null values from the map to ensure a clean JSON representation
    data.removeWhere((key, value) => value == null);

    return data;
  }
}

class PlaceImages {
  int? id;
  String? image;

  PlaceImages({this.id, this.image});

  // Named constructor for creating a PlaceImages instance from JSON
  PlaceImages.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'];

  // Method for converting PlaceImages instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'image': image,
    };

    // Remove null values from the map to ensure a clean JSON representation
    data.removeWhere((key, value) => value == null);

    return data;
  }
}

class PlaceType {
  int? id;
  String? name;

  PlaceType({this.id, this.name});

  // Named constructor for creating a PlaceType instance from JSON
  PlaceType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  // Method for converting PlaceType instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,


    };

    // Remove null values from the map to ensure a clean JSON representation
    data.removeWhere((key, value) => value == null);

    return data;
  }
}