////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoading extends StatefulWidget {
  const SkeletonLoading({Key? key}) : super(key: key);

  @override
  _SkeletonLoadingState createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text(
          "",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: 8,
            itemBuilder: (BuildContext ctx, index) {
              int timer = 1000;

              if (Theme.of(context).colorScheme.brightness == Brightness.dark) {
              } else {}
              return Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.brightness ==
                        Brightness.dark
                    ? const Color.fromARGB(255, 77, 75, 75)
                    : Color.fromARGB(
                        255, 216, 201, 201), //Color.fromARGB(255, 77, 75, 75),
                highlightColor:
                    Theme.of(context).colorScheme.brightness == Brightness.dark
                        ? const Color.fromARGB(255, 167, 164, 164)
                        : const Color.fromARGB(255, 196, 192,
                            192), // Color.fromARGB(255, 196, 192, 192),
                period: Duration(milliseconds: timer),
                child: box(),
              );
            }),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Widget box() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 150,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
