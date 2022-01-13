import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/buttons.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

class MenuPage extends StatelessWidget {
  final String saleId, tableNo;

  const MenuPage({Key? key, required this.saleId, required this.tableNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    saleIdGlobal = saleId;
    tableNoGlobal = tableNo;

    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: Column(
          children: [
            heightBox(context, 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  if (cartItems.isEmpty) {
                    pop(context);
                  } else {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        text:
                            "if you leave this page your cart items will discard",
                        confirmBtnText: "Continue",
                        cancelBtnText: "Cancel",
                        onCancelBtnTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        onConfirmBtnTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          cartItems.clear();
                          pop(context);
                        });
                  }
                },
                child: const Icon(
                  LineIcons.arrowLeft,
                  color: myWhite,
                ),
              ),
            ),
            heightBox(context, 0.02),
            text(context, "Menu", 0.05, myWhite),
            const Divider(
              thickness: 1,
              color: myWhite,
            ),
            heightBox(context, 0.02),
            Expanded(
              child: FutureBuilder(
                future: getMenu(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == false) {
                      return Center(
                        child: coloredButton(
                          context,
                          "Retry",
                          myOrange,
                          width: dynamicWidth(context, .4),
                          function: () {
                            globalRefresh();
                          },
                        ),
                      );
                    } else {
                      if (snapshot.data.length == 0) {
                        return Center(
                          child:
                              text(context, "No Items in Menu", 0.04, myWhite),
                        );
                      } else {
                        return StatefulBuilder(builder: (context, changeState) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showSearch(
                                    context: context,
                                    delegate:
                                        CustomSearchDelegate(snapshot.data),
                                  ).then((value) => changeState(() {}));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: myWhite,
                                      borderRadius: BorderRadius.circular(
                                          dynamicWidth(context, 0.1))),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: const UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "Search",
                                        enabled: false,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                dynamicWidth(context, 0.05))),
                                  ),
                                ),
                              ),
                              heightBox(context, 0.02),
                              StatefulBuilder(builder: (context, changeState) {
                                menuRefresh = () {
                                  changeState(() {});
                                };
                                return Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            childAspectRatio:
                                                dynamicWidth(context, 0.5) /
                                                    dynamicWidth(context, 0.5)),
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return menuCards(
                                          context, snapshot.data, index);
                                    },
                                  ),
                                );
                              }),
                            ],
                          );
                        });
                      }
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
    );
  }
}

menuCards(context, snapshot, index) {
  return Container(
    decoration: BoxDecoration(
      color: myBlack,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, 0.02),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                dynamicWidth(context, 0.02),
              ),
              topRight: Radius.circular(
                dynamicWidth(context, 0.02),
              ),
            ),
            child: Image.network(
              snapshot[index]["photo"] ??
                  "https://neurologist-ahmedabad.com/wp-content/themes/apexclinic/images/no-image/No-Image-Found-400x264.png",
              height: dynamicWidth(context, 0.2),
              width: dynamicWidth(context, 0.5),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.02),
          ),
          child: text(
            context,
            snapshot[index]["name"],
            0.03,
            myWhite,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.02)),
          child: text(
            context,
            "Rs ." + snapshot[index]["sale_price"],
            0.04,
            myWhite,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.02)),
          child: iconsRow(
            context,
            snapshot[index],
          ),
        ),
        heightBox(context, 0.005),
      ],
    ),
  );
}

iconsRow(context, snapshot) {
  var quantity = 1;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dynamicWidth(context, 0.02)),
              border: Border.all(color: myWhite, width: 1)),
          child: StatefulBuilder(builder: (context, changeState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (quantity > 1) {
                      changeState(() {
                        quantity--;
                      });
                    }
                  },
                  child: SizedBox(
                    width: dynamicWidth(context, .1),
                    height: dynamicWidth(context, .07),
                    child: Icon(
                      Icons.remove,
                      size: dynamicWidth(context, .03),
                      color: myOrange,
                    ),
                  ),
                ),
                Text(
                  quantity.toString(),
                  style: TextStyle(
                    color: myOrange,
                    fontSize: dynamicWidth(context, .03),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (quantity < 30) {
                      changeState(() {
                        quantity++;
                      });
                    }
                  },
                  child: SizedBox(
                    width: dynamicWidth(context, .1),
                    height: dynamicWidth(context, .07),
                    child: Icon(
                      Icons.add,
                      size: dynamicWidth(context, .03),
                      color: myOrange,
                    ),
                  ),
                ),
              ],
            );
          })),
      StatefulBuilder(builder: (context, changeState) {
        return GestureDetector(
          onTap: () {
            if (!cartItems.contains(snapshot)) {
              snapshot["qty"] = quantity;
              snapshot['setState'] = () {
                changeState(() {});
              };
              cartItems.add(snapshot);

              changeState(() {});
            } else {
              cartItems.remove(snapshot);

              changeState(() {});
            }
          },
          child: Icon(
            cartItems.contains(snapshot)
                ? LineIcons.shoppingCart
                : LineIcons.addToShoppingCart,
            color: cartItems.contains(snapshot) ? myOrange : myWhite,
            size: dynamicWidth(context, 0.07),
          ),
        );
      })
    ],
  );
}

class CustomSearchDelegate extends SearchDelegate {
  dynamic menu;

  CustomSearchDelegate(this.menu);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        textSelectionTheme: const TextSelectionThemeData(cursorColor: myWhite),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: myBlack),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: myBlack),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: myBlack),
          ),
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: myWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(color: myBlack),
        scaffoldBackgroundColor: myBlack);
  }

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
    dynamic matchQuery = [];
    for (var item in menu) {
      if (item["name"].toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return Padding(
      padding: EdgeInsets.all(dynamicWidth(context, 0.05)),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio:
                dynamicWidth(context, 0.5) / dynamicWidth(context, 0.5)),
        itemCount: matchQuery.length,
        itemBuilder: (BuildContext context, int index) {
          return menuCards(context, matchQuery, index);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    dynamic matchQuery = [];
    for (var item in menu) {
      if (item["name"].toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Padding(
      padding: EdgeInsets.all(dynamicWidth(context, 0.05)),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio:
                dynamicWidth(context, 0.5) / dynamicWidth(context, 0.5)),
        itemCount: matchQuery.length,
        itemBuilder: (BuildContext context, int index) {
          return menuCards(context, matchQuery, index);
        },
      ),
    ); // ListTile
  }
}
