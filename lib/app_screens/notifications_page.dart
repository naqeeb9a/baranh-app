import 'package:baranh/app_functions/functions.dart';
import 'package:baranh/utils/config.dart';
import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:baranh/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'menu.dart';

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
              FutureBuilder(
                future: getMenu(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == false) {
                      return Center(
                          child: text(
                              context, "Server Error", 0.04, Colors.white));
                    } else {
                      if (snapshot.data.length == 0) {
                        return Center(
                          child: text(
                              context, "No Items in Menu", 0.04, Colors.white),
                        );
                      } else {
                        return Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate(snapshot.data),
                                );
                              },
                              icon: const Icon(
                                Icons.search,
                                color: myWhite,
                              ),
                            ),
                            SizedBox(
                              height: dynamicHeight(context, 0.5),
                              width: dynamicWidth(context, 1),
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
                                itemBuilder: (BuildContext context, int index) {
                                  return menuCards(
                                      context, snapshot.data, index);
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    }
                  } else {
                    return LottieBuilder.asset(
                      "assets/loader.json",
                      width: dynamicWidth(context, 0.3),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

