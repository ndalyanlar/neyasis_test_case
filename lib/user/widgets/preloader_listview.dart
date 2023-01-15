import 'package:flutter/material.dart';

class PreloaderListView extends StatelessWidget {
  const PreloaderListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
