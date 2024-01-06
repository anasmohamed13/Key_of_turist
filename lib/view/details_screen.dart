import 'package:flutter/material.dart';
import 'package:key_of_turist/model/place.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final Places place;
   String statusOC ="";

  String placeStatus (){
    if (place.status == false ){
      return statusOC = "Closed";
    }
    else {
      return statusOC = "Open";
    }

  }

  PlaceDetailsScreen({Key? key, required this.place }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        //name view area

        title: Text("${place.name} Details" ,
          style: const TextStyle(
            color: Colors.black ,
          ),
        ),
      ),

      body: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        color: Colors.amber[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image area
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Container(
                  color: Colors.black87,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: place.placeImages?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Image.network(
                        place.placeImages?.isNotEmpty == true
                            ? place.placeImages![index].image ?? ''
                            : '',
                        fit: BoxFit.cover,
                      );
                     },
                 ),
               ),
             ),

              const SizedBox(height: 16.0),


              //description view area
              SizedBox(
                height: 150,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      place.description,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 16.0,),
              // rate view area
              Text("rate : ${place.rate}",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

              // entrancePrice view area
              Text("Price for entrance : ${place.entrancePrice} EP",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

              //open\close status view area
              Text("Open / Closed : ${placeStatus()}",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

            ]),
        ),
      ),
    );
  }
}
