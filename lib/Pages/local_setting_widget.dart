import 'package:ezpos_redesign/constants/colors.dart';
import 'package:ezpos_redesign/constants/local_constant.dart';
import 'package:ezpos_redesign/custom_widgets/easy_text.dart';
import 'package:ezpos_redesign/src/providers/login_screen_provider.dart';
import 'package:ezpos_redesign/src/providers/setting_provider.dart';
import 'package:ezpos_redesign/utilites/storage_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalSettingPage extends StatelessWidget {
  const LocalSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider =
        Provider.of<SettingProvider>(context, listen: false);
    LoginScreenProvider loginScreenProvider =
        Provider.of<LoginScreenProvider>(context, listen: false);
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          title: const EasyText(
            text: 'Local Settings',
            color: kKeyDark,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              settingProvider.clickBackBtn();
            },
          ),
        ),
        body: Column(
          children: [
            Text("Current Location"),
            DropdownButton<String>(
              // isExpanded: true,
              elevation: 1,
              underline: Spacer(),
              // style: TextStyle(color: Colors.amber),
              borderRadius: BorderRadius.circular(5),
              value: 'One',
              dropdownColor: Colors.amber,
              focusColor: Colors.blue,

              onChanged: (String? newValue) {},
              items: <String>['One', 'Two', 'Three', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    // decoration: BoxDecoration(
                    //   borderRadius:
                    //       BorderRadius.circular(10.0), // Set the desired radius
                    //   color: Colors.grey[200], // Set the background color
                    // ),
                    padding: EdgeInsets.all(10.0), // Add padding for content
                    child: Text(value),
                  ),
                );
              }).toList(),
            ),
            // Expanded(
            //   child: GridView.builder(
            //     physics: const BouncingScrollPhysics(),
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 7,
            //       mainAxisSpacing: 5.0,
            //       crossAxisSpacing: 5.0,
            //       childAspectRatio: 3 / 4,
            //     ),
            //     itemCount: loginScreenProvider.locationList.length,
            //     itemBuilder: (conetxt, index) => GestureDetector(
            //       onTap: () {
            //         StorageUtils.putString(lLocSysKey,
            //             loginScreenProvider.locationList[index].code ?? "");
            //         StorageUtils.putString(lLocCode,
            //             loginScreenProvider.locationList[index].t1 ?? "");
            //         loginScreenProvider.getCountersByLoc();
            //       },
            //       child: Card(
            //         elevation: 1,
            //         color: kGrey100,
            //         child: Column(
            //           children: [
            //             const Expanded(
            //               flex: 2,
            //               child: Icon(
            //                 Icons.location_on_outlined,
            //                 size: 60,
            //                 color: Color.fromRGBO(17, 19, 21, 0.1),
            //               ),
            //             ),
            //             Expanded(
            //               flex: 1,
            //               child: Center(
            //                 child: SingleChildScrollView(
            //                   scrollDirection: Axis.horizontal,
            //                   child: EasyText(
            //                     text:
            //                         "${loginScreenProvider.locationList[index].description}",
            //                     fontSize: 18,
            //                     color: kLocationBlackTextColor,
            //                     fontWeight: FontWeight.w500,
            //                     overflow: TextOverflow.visible,
            //                   ),
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Text("Counter"),
            // Expanded(child: Consumer<LoginScreenProvider>(
            //     builder: (context, loginScreenProvider, child) {
            //   return GridView.builder(
            //     physics: const BouncingScrollPhysics(),
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 7,
            //       mainAxisSpacing: 5.0,
            //       crossAxisSpacing: 5.0,
            //       childAspectRatio: 3 / 4,
            //     ),
            //     itemCount: loginScreenProvider.counterByLocList.length,
            //     itemBuilder: (conetxt, index) => GestureDetector(
            //       onTap: () {
            //         StorageUtils.putString(
            //             lCounterName,
            //             loginScreenProvider
            //                 .counterByLocList[index].description!);
            //         StorageUtils.putString(lCountersysKey,
            //             loginScreenProvider.counterByLocList[index].code!);
            //         StorageUtils.putString(lOrderPrintUrl,
            //             loginScreenProvider.counterByLocList[index].t6!);
            //         StorageUtils.putBool(lhasChosenCounter, true);
            //       },
            //       child: Card(
            //         elevation: 1,
            //         color: kGrey100,
            //         child: Column(
            //           children: [
            //             const Expanded(
            //               flex: 2,
            //               child: Icon(
            //                 Icons.location_on_outlined,
            //                 size: 60,
            //                 color: Color.fromRGBO(17, 19, 21, 0.1),
            //               ),
            //             ),
            //             Expanded(
            //               flex: 1,
            //               child: Center(
            //                 child: SingleChildScrollView(
            //                   scrollDirection: Axis.horizontal,
            //                   child: EasyText(
            //                     text:
            //                         "${loginScreenProvider.counterByLocList[index].description}",
            //                     fontSize: 18,
            //                     color: kLocationBlackTextColor,
            //                     fontWeight: FontWeight.w500,
            //                     overflow: TextOverflow.visible,
            //                   ),
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   );
            // }))
          ],
        ),
      ),
    );
  }
}
