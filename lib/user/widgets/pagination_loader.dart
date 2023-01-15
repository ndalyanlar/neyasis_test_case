import 'package:flutter/material.dart';

class PaginationLoader extends StatelessWidget {
  const PaginationLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
        dimension: 40, child: CircularProgressIndicator());
  }
}
