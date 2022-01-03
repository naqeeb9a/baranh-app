import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/app_routes.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  pop(context);
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
            Container(
              decoration: BoxDecoration(
                  color: myWhite,
                  borderRadius:
                      BorderRadius.circular(dynamicWidth(context, 0.1))),
              child: TextFormField(
                decoration: InputDecoration(
                    border:
                        const UnderlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Search",
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, 0.05))),
              ),
            ),
            heightBox(context, 0.02),
            Expanded(
              child: FutureBuilder(
                future: getMenu(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == false) {
                      return text(context, "Server Error", 0.04, Colors.white);
                    } else {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: dynamicWidth(context, 0.5) /
                                dynamicWidth(context, 0.5)),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
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
    );
  }
}

menuCards(context, snapshot, index) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.2),
      borderRadius: BorderRadius.circular(dynamicWidth(context, 0.02)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(dynamicWidth(context, 0.02)),
                topRight: Radius.circular(dynamicWidth(context, 0.02))),
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
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.02)),
          child: text(context, snapshot[index]["name"], 0.03, Colors.white),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.02)),
          child: text(context, "Rs ." + snapshot[index]["sale_price"], 0.04,
              Colors.white),
        ),
        Padding(
            padding:
                EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.02)),
            child: iconsRow(context, snapshot[index])),
        heightBox(context, 0.005),
      ],
    ),
  );
}

iconsRow(context, snapshot) {
  bool check = false;
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
      StatefulBuilder(builder: (context, changestate) {
        return GestureDetector(
          onTap: () {
            changestate(() {
              if (check == false) {
                cartItems.add({
                  "name": snapshot["name"],
                  "sale_price": snapshot["sale_price"],
                  "photo": snapshot["photo"],
                  "quantity": quantity
                });
                check = true;
              } else {
                cartItems.remove(snapshot);
                check = false;
              }
            });
          },
          child: (check == true)
              ? Icon(
                  LineIcons.shoppingCart,
                  color: myOrange,
                  size: dynamicWidth(context, 0.07),
                )
              : Icon(
                  LineIcons.addToShoppingCart,
                  color: myWhite,
                  size: dynamicWidth(context, 0.07),
                ),
        );
      })
    ],
  );
}
