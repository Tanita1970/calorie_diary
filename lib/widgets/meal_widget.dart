import 'package:calorie_diary/clients/calorizator_client_impl.dart';
import 'package:calorie_diary/providers/meal.dart';
import 'package:calorie_diary/providers/meals.dart';
import 'package:calorie_diary/providers/products.dart';
import 'package:calorie_diary/repository/MealRepository.dart';
import 'package:calorie_diary/screens/search_food_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calorie_diary/repository/MealRepository.dart';

class MealWidget extends StatefulWidget {
  static const routeName = '/meal-widget';

  // final String mealName;
  final MealType mealType;

  // final List<CalorizatorShortFoodData> mealItems;

  MealWidget(this.mealType);

  @override
  _MealWidgetState createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  bool isExpanded = false;
  List<CalorizatorShortFoodData> mealItems = [];

  CalorizatorShortFoodData _selectedProduct =
      CalorizatorShortFoodData(name: 'name', kcal: 0);

  _navigateToSearchProduct() async {
    print('== 1 == Поиск в Калоризаторе!!!================================================');
    final meal = await Provider.of<Meal>(context, listen: false);
    // final meal = await Provider.of<Future<Meal>>(context, listen: false);
    print('== 2 == Поиск в Калоризаторе!!!================================================');
    var mealRepository = await Provider.of<MealRepository>(context, listen: false);
    print('== 3 == Поиск в Калоризаторе!!!================================================');
    final result = await Navigator.of(context)
        .pushNamed(SearchFoodScreen.routeName) as CalorizatorShortFoodData;
    print('== 4 == Поиск в Калоризаторе!!!================================================');
    setState(() {
      _selectedProduct = result;
      meal.addUserProduct(UserProduct(
          weightProduct: 0,
          product: Product.fromShortCalorizator(_selectedProduct)));
      mealItems.add(_selectedProduct);
      print('meal.items======> ${meal.mealType} ${meal.mealDate} ${meal.items.map((e) => e.product.name)}');
      print('mealItems======> $mealItems');
      MealRepository().save(meal);
      print('== 5 == Поиск в Калоризаторе!!!================================================');
      // MealRepository().save(meal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(3, -2), // changes position of shadow
              ),
            ],
          ),
          // padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.mealType}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(isExpanded ? 0.5 : 0),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ],
          ),
        ),
        if (isExpanded)
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
            padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: FutureBuilder(
              future: Provider.of<Future<Meal>>(context),
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (dataSnapshot.error != null) {
                    // ...
                    // Do error handling stuff
                    return Center(
                      child: Text('An error occurred!'),
                    );
                  } else {
                    return Column(
                      children: [
                        ...dataSnapshot.data!.items
                            .map((e) => Text(e.product.name))
                            .toList()
                      ],
                    );
                  }
                }
              },
            ),
            // SearchFoodWidget();
          ),
        TextButton(
          onPressed: _navigateToSearchProduct,
          child: const Text('Добавить еду'),
        )
      ],
    );
  }
}
