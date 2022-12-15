import "package:flutter/material.dart";

void main() {
  if (true == true) {
    runApp(const Main());
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Host",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Simple Host"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: current == 0
              ? Colors.red[600]
              : current == 1
                  ? Colors.green[600]
                  : Colors.blue[600],
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.computer),
              label: "Servers",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Account",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            )
          ],
          iconSize: 24,
          currentIndex: current,
          onTap: ((value) {
            setState(() {
              current = value;
            });
          }),
        ),
      ),
    );
  }
}
