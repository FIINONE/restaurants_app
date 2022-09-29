import 'package:flutter/material.dart';

class RestaurantsListScreens extends StatelessWidget {
  const RestaurantsListScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64.0, right: 16, left: 16),
      child: Column(
        children: [
          const SearchField(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return const RestaurantWidget();
              },
            ),
          )
        ],
      ),
    );
  }
}

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        constraints: BoxConstraints(maxHeight: 42),
        helperText: 'Поиск',
        border: OutlineInputBorder(),
      ),
    );
  }
}
