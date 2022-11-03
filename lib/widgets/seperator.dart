import 'package:flutter/material.dart';

class Seperator extends StatelessWidget {
  const Seperator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.black,
      height: 20,
      thickness: 5,
      indent: 20,
      endIndent: 0,
    );
  }
}
