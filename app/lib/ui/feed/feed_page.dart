import 'package:flutter/material.dart';

import '../design_system/widgets/post_user_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 12.0,
          children: [PostUserWidget(), Text('Tela do feed')],
        ),
      ),
    );
  }
}
