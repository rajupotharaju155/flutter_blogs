import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetbookHotReload extends StatelessWidget {
  WidgetbookHotReload({super.key});
  int pageIndex = 2;

  Widget buildNavButton(int pos, String name, IconData iconData) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   pageIndex = pos;
        // });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              iconData,
              color: pageIndex == pos ? Colors.black : Colors.grey,
              size: 25,
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      pageIndex == pos ? FontWeight.bold : FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCenterNavBtn(
      int pos, String name, IconData iconData, Color color) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        pageIndex = pos;
        // });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: color,
              child: Icon(
                iconData,
                color: Colors.white,
                size: 25,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      pageIndex == pos ? FontWeight.bold : FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }

  WidgetbookUseCase getUseCase(String useCaseName, Color color) {
    return WidgetbookUseCase(
        name: useCaseName,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 7.0, // Soften the shaodw
                    spreadRadius: 0.6,
                    offset: const Offset(0, -5.0),
                  )
                ],
              ),
              child: SizedBox(
                height: 75,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildNavButton(0, "BOOKINGS", Icons.calendar_month),
                    buildNavButton(
                        1, "WISHLIST", Icons.favorite_border_outlined),
                    buildCenterNavBtn(2, "HOME", Icons.checkroom, color),
                    buildNavButton(3, "INBOX", Icons.checkroom),
                    buildNavButton(4, "PROFILE", Icons.account_circle_rounded),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
        themes: [
          WidgetbookTheme(name: 'theme1', data: ThemeData.dark())
        ],
        // lightTheme: ThemeData.light(),
        // darkTheme: ThemeData.dark(),
        categories: [
          WidgetbookCategory(
            name: "Screen1",
            folders: [
              WidgetbookFolder(name: 'folder1', widgets: [
                WidgetbookComponent(name: 'widget1', useCases: [
                  WidgetbookUseCase(
                      name: 'usecase1',
                      builder: (context) {
                        return Container(
                          height: 200,
                          width: 200,
                          color: Colors.red,
                        );
                      }),
                  WidgetbookUseCase(
                      name: 'usecase2',
                      builder: (context) {
                        return Container(
                          height: 200,
                          width: 200,
                          color: Colors.yellow,
                        );
                      }),
                ])
              ])
            ],
          ),
          WidgetbookCategory(name: "Screen2", widgets: [
            WidgetbookComponent(name: 'bottomNavBar', useCases: [
              getUseCase("withBlackColor", Colors.black),
              getUseCase("withGreenColor", Colors.green),
              getUseCase("withOrangeColor", Colors.orange),
              getUseCase("withBlueColor", Colors.blue.shade800),
            ])
          ]),
          WidgetbookCategory(name: "Screen3"),
        ],
        appInfo: AppInfo(name: 'Recipe App'));
  }
}

void main() {
  runApp(WidgetbookHotReload());
}
