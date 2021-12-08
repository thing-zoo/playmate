import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'components/build_detail_sheet.dart';

class GoogleMapBody extends StatefulWidget {
  @override
  State<GoogleMapBody> createState() => _GoogleMapBodyState();
}


class _GoogleMapBodyState extends State<GoogleMapBody> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.4537251, 126.7960716),
    zoom: 14.4746,
  );

  List<Marker> _markers = [];
  late Uint8List markerIcon;

 
 Future<void> setCustomMapPin() async {
    markerIcon = await getBytesFromAsset('assets/map/playground.png', 130);

    _markers.add(Marker(
       markerId: MarkerId("1"),
       draggable: false,
       onTap: () => {
         buildDetailSheet
       },
       icon: BitmapDescriptor.fromBytes(markerIcon),
       position: LatLng(37.4537251, 126.7960716)
      ));
  }

	Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

 @override
 void initState() {
   super.initState();
   setCustomMapPin();
 }


@override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        markers: Set.of(_markers),
        initialCameraPosition: _kGooglePlex,
        onCameraMove: (_) {},
        myLocationButtonEnabled: false,
      ),
    );
  }
}