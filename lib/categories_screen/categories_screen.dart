import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phase_2_implementation/constantns/app_colors.dart';
import 'package:phase_2_implementation/firebase/firebase_manager.dart';
import 'package:phase_2_implementation/item_specs_page/item_specs_page.dart';
import 'package:phase_2_implementation/models/food_category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isSelected = false;
  int selectedIndex = -1;

  List<FoodCategory> foodCategories = [];

  @override
  void initState() {
    super.initState();

    FirebaseManager.getFoodCategories().then(
      (value) => setState(() {
        foodCategories = value;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseManager.getFoodCategories();
          // Navigate to screen to add new category
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: Get.width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(150),
                ),
                color: Color.fromARGB(255, 230, 201, 246)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "Categories",
                  style: Get.theme.textTheme.labelLarge?.copyWith(fontSize: 45),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: foodCategories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 25),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    setState(() {
                      selectedIndex = index;
                    });

                    await Future.delayed(const Duration(milliseconds: 100)).whenComplete(
                      () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return FoodItemPage(foodCat: foodCategories[index]);
                          },
                        ));
                      },
                    );
                  },
                  child: Container(
                    width: 20,
                    height: 65,
                    decoration: BoxDecoration(
                        color: selectedIndex == index ? AppColors.mainColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColors.mainColor)),
                    child: Center(
                      child: Text(
                        foodCategories[index].categoryName,
                        style: Get.theme.textTheme.labelLarge?.copyWith(fontSize: 30),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
