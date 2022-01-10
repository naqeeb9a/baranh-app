import 'package:baranh/apis/api.dart';
import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'menu.dart';

List menuList = [];

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.05),
          ),
          child: Column(
            children: [
              heightBox(context, 0.05),
              text(context, "Notifications", 0.05, myWhite),
              const Divider(
                thickness: 1,
                color: myWhite,
              ),
              heightBox(context, 0.03),
              IconButton(
                onPressed: () {
                  // log(menuList.toString());
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: myWhite,
                ),
              ), // IconButton
              Expanded(
                child: FutureBuilder(
                  future: getMenu(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == false) {
                        return text(
                            context, "Server Error", 0.04, Colors.white);
                      } else {
                        DioData().getInfo();
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: dynamicWidth(context, 0.5) /
                                      dynamicWidth(context, 0.7)),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            menuList.add(snapshot.data[index]);
                            return menuCards(context, snapshot.data, index);
                          },
                        );
                      }
                    } else {
                      return LottieBuilder.asset(
                        "assets/loader.json",
                        width: dynamicWidth(context, 0.3),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  // List searchTerms = getMenu();

  List searchTerms = [
    'Apple',
    'Banana',
    'Pear',
    'Watermelons',
    'Oranges',
    'Blueberries',
    'strawberries',
    'Raspberries ',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ) // IconButton
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    ); // IconButton
  }

  @override
  Widget buildResults(BuildContext context) {
    // return FutureBuilder(
    //   future: getMenu(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done &&
    //         snapshot.hasData) {
    //       return GridView.builder(
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 2,
    //             crossAxisSpacing: 10,
    //             mainAxisSpacing: 10,
    //             childAspectRatio:
    //                 dynamicWidth(context, 0.5) / dynamicWidth(context, 0.7)),
    //         itemCount: snapshot.data.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return menuCards(context, snapshot.data, index);
    //         },
    //       );
    //     } else {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //   },
    // );
    List<String> matchQuery = [];
    for (var fruit in menuList) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        ); // ListTile
      },
    ); // ListView.builder
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        ); // ListTile
      },
    ); // ListView.
  }
}
