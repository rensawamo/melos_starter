import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text('remon')],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              // context.goNamed('detail', extra: product);
            },
            child: const Column(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton.outlined(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
