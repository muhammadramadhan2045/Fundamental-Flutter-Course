import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/result_state.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/widget/list_restaurant_tile.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/restaurant_search_page';
  const RestaurantSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchRestaurantProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Restaurant"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                hintText: 'Search Restaurant',
                suffixIcon: Icon(Icons.search),
              ),
              controller: searchProvider.searchController,
              onChanged: (value) {
                searchProvider.searchRestaurant(value);
              },
            ),
            const SizedBox(height: 8),
            Consumer<SearchRestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: secondaryColor,
                    ),
                  );
                } else {
                  if (state.state == ResultState.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.result.restaurants?.length,
                        itemBuilder: (context, index) {
                          return ListRestaurantTile(
                            restaurants: state.result.restaurants![index],
                          );
                        },
                      ),
                    );
                  } else if (state.state == ResultState.error) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: Text("No Data"),
                    );
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
