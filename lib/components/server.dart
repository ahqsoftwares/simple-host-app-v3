import "package:flutter/material.dart";

class ServerContainer extends StatelessWidget {
  const ServerContainer(
      {Key? key,
      required this.onTap,
      required this.labelText,
      required this.status})
      : super(key: key);

  final VoidCallback onTap;
  final String labelText;
  final String status;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 75,
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              //Colors.blue,
              (status == "Stopped"
                  ? Colors.red[300]
                  : status == "Running"
                      ? Colors.green[300]
                      : Colors.yellow[300]) as Color,
              //Color.fromRGBO(41, 56, 169, 1),
              (status == "Stopped"
                  ? Colors.red[900]
                  : status == "Running"
                      ? Colors.green[900]
                      : Colors.yellow[900]) as Color,
            ],
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(31, 40, 112, 1),
              blurRadius: 30,
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(37, 64, 110, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.storage,
                color: Colors.white,
                size: 25,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                width >= 500
                    ? labelText
                    : width >= 300
                        ? labelText.length > 6
                            ? '${labelText.substring(0, 6)}...'
                            : labelText
                        : labelText.length > 4
                            ? '${labelText.substring(0, 4)}...'
                            : labelText,
                style: TextStyle(
                  color: status == "Stopped" || status == "Running"
                      ? Colors.white
                      : Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
