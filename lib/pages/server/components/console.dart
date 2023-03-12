import "package:flutter/material.dart";

class ConsoleBox extends StatelessWidget {
  const ConsoleBox({Key? key, required this.logs}) : super(key: key);

  final List<String> logs;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      height: height * 6 / 10,
      width: width * 99 / 100,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 5, 2),
            child: Text(
              // ignore: unnecessary_string_interpolations
              '> ${logs[index]}',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "sans-serif",
                fontSize: 18,
              ),
            ),
          );
        },
        itemCount: logs.length,
      ),
    );
  }
}
