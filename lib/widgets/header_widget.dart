import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  // date
  String date = DateFormat("yMMMMd").format(DateTime.now());

  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];

    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // locality name
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: GoogleFonts.pacifico(
              fontSize: 50,
              height: 2,
            ),
            // style: const TextStyle(
            //   fontSize: 35,
            //   height: 2,
            // ),
          ),
        ),

        // date and time
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: Colors.grey[700],
              height: 1.5,
            ),
            // style: TextStyle(
            //   fontSize: 14,
            //   color: Colors.grey[700],
            //   height: 1.5,
            // ),
          ),
        )
      ],
    );
  }
}
