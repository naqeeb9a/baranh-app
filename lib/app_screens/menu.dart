import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var quantity = 1;
    return Scaffold(
      backgroundColor: myBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
        child: Column(
          children: [
            heightBox(context, 0.05),
            text(context, "Menu", 0.05, myWhite),
            const Divider(
              thickness: 1,
              color: myWhite,
            ),
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
                                dynamicWidth(context, 0.7)),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return menuCards(
                              context, snapshot.data, index, quantity);
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

menuCards(context, snapshot, index, quantity) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.3),
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
                  "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png",
              height: dynamicWidth(context, 0.3),
              width: dynamicWidth(context, 0.5),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.02)),
          child: text(context, snapshot[index]["name"], 0.04, Colors.white),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(dynamicWidth(context, 0.02)),
                      border: Border.all(color: myWhite, width: 1)),
                  child: itemPlusMinus(context, quantity)),
              tapIcon()
            ],
          ),
        ),
        heightBox(context, 0.005),
      ],
    ),
  );
}

tapIcon() {
  bool check = false;
  return StatefulBuilder(builder: (context, changestate) {
    return GestureDetector(
      onTap: () {
        changestate(() {
          if (check == false) {
            check = true;
          } else {
            check = false;
          }
        });
      },
      child: (check == true)
          ? const Icon(
              Icons.shopping_bag_rounded,
              color: myWhite,
            )
          : const Icon(
              Icons.shopping_bag_outlined,
              color: myWhite,
            ),
    );
  });
}

Widget itemPlusMinus(context, quantity) {
  return StatefulBuilder(builder: (context, changeState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
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
        GestureDetector(
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
  });
}
