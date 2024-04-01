import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phase_2_implementation/constantns/app_colors.dart';
import 'package:phase_2_implementation/controller/cart_controller.dart';
import 'package:phase_2_implementation/main_screenF/main_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late DatabaseReference _dbRef;
  List<Cart> items = [
    Cart(
        title: "wings",
        image: "assets/chicken-leg.png",
        isQuantity: false,
        category: "Chicken",
        expiryDate: "13/2/24",
        quantity: "500g"),
    Cart(
        title: "ciabatta",
        image: "assets/bread.jpeg",
        isQuantity: false,
        category: "Bread",
        quantity: "130 g",
        expiryDate: "13/2/24"),
  ];

  getFood() async {
    _dbRef = FirebaseDatabase.instance.ref('default');

    final database = FirebaseDatabase.instance;

    // _messagesRef = database.ref('messages');

    database.setLoggingEnabled(true);

    if (!kIsWeb) {
      database.setPersistenceEnabled(true);
      database.setPersistenceCacheSizeBytes(10000000);
    }

    if (!kIsWeb) {
      await _dbRef.keepSynced(true);
    }
  }

  Future<void> createRecord() async {
    try {
      await FirebaseDatabase.instance.ref().child("savedObjects").set({
        'name': 'John Doe',
        'email': 'johndoe@example.com',
        'age': 30,
      });
      // ignore: avoid_print
      print("SET");
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState() {
    createRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      createRecord();
                    },
                    child: DottedBorder(
                      borderType: BorderType.Circle,
                      strokeWidth: 5,
                      dashPattern: const [5, 5],
                      color: AppColors.mainColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/profile.png",
                          height: 55,
                          width: 60,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 35),
                    child: Column(
                      children: [
                        /*Text(
                          userName?.toUpperCase() ?? "Unknown user",
                          style: const TextStyle(
                              fontSize: 24, color: Colors.black54),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * .05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              child: Row(
                children: [
                  Text(
                    "Items info:",
                    style: Get.theme.textTheme.titleLarge
                        ?.copyWith(color: AppColors.mainColor, fontSize: 28),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: AppColors.mainColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: items.length,
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      items[index].image,
                                      height: 75,
                                      width: 75,
                                    ),
                                    Text(
                                      items[index].category,
                                      style: Get.theme.textTheme.labelLarge
                                          ?.copyWith(decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox(
                                  width: Get.width * .45,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(items[index].title,
                                          style: Get.theme.textTheme.labelMedium
                                              ?.copyWith(height: 1.5, color: Colors.black54)),
                                      !items[index].isQuantity
                                          ? Text("${items[index].quantity}",
                                              style: Get.theme.textTheme.labelMedium
                                                  ?.copyWith(height: 1.5, color: Colors.black54))
                                          : Container(),
                                      Text(items[index].expiryDate,
                                          style: Get.theme.textTheme.labelMedium
                                              ?.copyWith(height: 1.5, color: Colors.black54)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(" ${index + 1} ",
                                              style: Get.theme.textTheme.titleLarge
                                                  ?.copyWith(fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(50)),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.add_circle,
                    color: Colors.black,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  label: ""),
            ],
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            fixedColor: Colors.transparent,
            useLegacyColorScheme: false,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            iconSize: 30,
            onTap: (index) {
              MainNavigation.of(context)?.setIndex(index);
              // Get.lazyPut(() => MainController());
              // Get.find<MainController>().currentIndex = index;
              // Get.find<MainController>().update();
              // Get.to(() => const HomeScreen());
            },
          ),
        ),
      ),
    );
  }
}
