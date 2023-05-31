import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    Key? key,
    required this.mainController,
    required this.selectedIndex,
  }) : super(key: key);
  final MainController mainController;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 9,
      color: const Color(0x00ffffff),
      shadowColor: blackColor,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,

          selectedLabelStyle: const TextStyle(fontSize: 14, color: redColor),
          unselectedLabelStyle:
              const TextStyle(fontSize: 14, color: Color(0xff85959E)),
          items: <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: const Icon(Icons.home,
                  color: paragraphColor),
              activeIcon: const Icon(Icons.home,color: redColor,),
              label: "Home",
            ),

            BottomNavigationBarItem(
              tooltip: "Compare Ads",
              activeIcon: const Icon(Icons.change_circle,color: redColor,),
              icon: const Icon(Icons.change_circle_outlined, color: paragraphColor),
              label: "Compare Ads",
            ),

            BottomNavigationBarItem(
              tooltip: "Profile",
              activeIcon:
              const Icon(Icons.person, color: redColor),
              icon:
              const Icon(Icons.person_outline, color: paragraphColor),
              label: "Profile",
            ),
          ],
          // type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (int index) {
            print("$index");
            mainController.naveListener.sink.add(index);
          },
        ),
      ),
    );
  }
}
