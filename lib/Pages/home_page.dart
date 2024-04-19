import 'package:flutter/material.dart';
import 'package:real_time_chatting/Utils/extension.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.notifications, color: Colors.white),
            SizedBox(
              width: 10,
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 55, 0, 255),
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          title: Text(
            "Chats",
            style: context.bl,
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(255, 55, 0, 255),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: 100,
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1,
                      color: const Color.fromARGB(255, 212, 212, 212),
                    ),
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () => null,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style:
                                      context.bm!.copyWith(color: Colors.black),
                                ),
                                Text(
                                  "Mg ly yay",
                                  style:
                                      context.bm!.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 55, 0, 255)),
                                  child: Text(
                                    "1",
                                    style: context.bm,
                                  ),
                                ),
                                Text(
                                  "10:45 PM",
                                  style:
                                      context.bm!.copyWith(color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
