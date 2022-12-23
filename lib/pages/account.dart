import "package:flutter/material.dart";

import "../components/design.dart";

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration(),
    );
  }
}
