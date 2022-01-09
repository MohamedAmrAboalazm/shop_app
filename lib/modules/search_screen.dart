import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            "SearchScreen",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}