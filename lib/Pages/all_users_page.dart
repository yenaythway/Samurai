import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_time_chatting/Models/user.dart';
import 'package:real_time_chatting/Providers/login_provider.dart';
import 'package:real_time_chatting/Utils/extension.dart';

class AllUserWidget extends ConsumerWidget {
  const AllUserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final userData = ref.watch(userDataProvider);
    return userData.when(
        data: (userData) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: userData.length,
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color.fromARGB(255, 212, 212, 212),
                ),
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () => null,
                  child: EachUserWiget(
                    user: userData[index],
                  ),
                )),
        error: (_, __) => Center(
              child: Text(
                "There is error",
                style: context.bm,
              ),
            ),
        loading: () => Center(
              child: CircularProgressIndicator(),
            ));
  }
}

class EachUserWiget extends StatelessWidget {
  final User user;
  const EachUserWiget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            user.nickname ?? "-",
            style: context.bm!.copyWith(color: Colors.black),
          ),
          Icon(Icons.chat_bubble_outline)
        ],
      ),
    );
  }
}


// class EachUserWiget extends StatelessWidget {
//   final User user;
//   const EachUserWiget({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             backgroundColor: Colors.grey,
//             child: Icon(
//               Icons.person,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Name",
//                 style: context.bm!.copyWith(color: Colors.black),
//               ),
//               Text(
//                 "Mg ly yay",
//                 style: context.bm!.copyWith(color: Colors.grey),
//               ),
//             ],
//           ),
//           const Expanded(child: SizedBox()),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color.fromARGB(255, 55, 0, 255)),
//                 child: Text(
//                   "1",
//                   style: context.bm,
//                 ),
//               ),
//               Text(
//                 "10:45 PM",
//                 style: context.bm!.copyWith(color: Colors.black),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
