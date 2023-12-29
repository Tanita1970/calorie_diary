import 'package:calorie_diary/clients/calorizator_client_impl.dart';
import 'package:flutter/material.dart';

class SearchFoodScreen extends StatefulWidget {
  static const routeName = '/search-food';

  @override
  _SearchFoodScreenState createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {
  List<CalorizatorShortFoodData> _productsList = [];
  String _searchText = "";

  void _updateSearch(String searchText) {
    setState(() {
      _searchText = searchText;
      _fetchProducts(searchText);
    });
  }

  void _fetchProducts(String searchText) async {
     CalorizatorClientImpl client = CalorizatorClientImpl();
     var products = await client.searchProducts(searchText);

    setState(() {
      _productsList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Поиск Продукта')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            onChanged: _updateSearch,
            decoration: InputDecoration(
              labelText: "Search for a food item",
              hintText: "Type here...",
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _productsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${_productsList[index].name} ${_productsList[index].kcal} Ккал'),
                  onTap: () {
                     _onFoodItemSelected(_productsList[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onFoodItemSelected(CalorizatorShortFoodData selectedProduct) {
    print("Selected product ==========================>>>>>>>>>>>>>>>>>>>: $selectedProduct");
    Navigator.pop(context, selectedProduct);
  }
}