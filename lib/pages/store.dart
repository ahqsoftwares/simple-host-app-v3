import "package:flutter/material.dart";

import "../components/design.dart";

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  MarketPlaceState createState() => MarketPlaceState();
}

class MarketPlaceState extends State<MarketPlace> {
  double width = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      width = (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .size
                  .width *
              98) /
          100;
      height = 80;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration(),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(10),
      child: Container(
        height: height,
        width: width,
        decoration: boxOverlayDecoration(),
      ),
    );
  }
}
