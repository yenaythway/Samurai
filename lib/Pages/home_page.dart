import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello"),
            Text("Jordan"),
            // Column(
            //   children: [
            //     TabBar(
            //         controller: TabController(length: , 2vsync: vsync),
            //         tabs: [
            //           Container(
            //             decoration: BoxDecoration(color: Colors.blue),
            //             child: Text("data"),
            //           )
            //         ]),
            //     // TabBarView(
            //     //   children: <Widget>[
            //     //     Center(
            //     //       child: Text("Group"),
            //     //     ),
            //     //     // Center(
            //     //     //   child: Text(""),
            //     //     // ),
            //     //     // Center(
            //     //     //   child: Text(""),
            //     //     // ),
            //     //   ],
            //     // )
            //   ],
            // )
            // Stack(children: [
            //   Container(
            //     width: double.infinity,
            //     decoration: BoxDecoration(color: Colors.grey),
            //   ),
            // ]),
            // Expanded(
            //     child: ListView.builder(
            //         itemBuilder: ((context, index) => Container()))),
          ],
        ),
      ),
    );
  }
}
