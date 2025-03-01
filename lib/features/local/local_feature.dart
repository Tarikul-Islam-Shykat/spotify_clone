import 'package:flutter/material.dart';
import 'package:spotify_clone/main.dart';

class LocalFeature extends StatefulWidget {
  const LocalFeature({super.key});

  @override
  State<LocalFeature> createState() => _LocalFeatureState();
}

class _LocalFeatureState extends State<LocalFeature> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [Text("Changes Made By Tarikul branch")],
      ),
    );
  }
}
