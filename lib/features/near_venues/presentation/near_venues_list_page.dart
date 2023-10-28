import 'package:flutter/material.dart';

class NearVenuesListPage extends StatelessWidget {
  const NearVenuesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Icon(
            Icons.favorite,
            size: 128,
          ),
        ),
      ),
    );
  }
}
