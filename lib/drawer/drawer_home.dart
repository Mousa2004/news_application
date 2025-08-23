import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:news_application/apptheme.dart';
import 'package:news_application/drawer/title_item.dart';

class DrawerHome extends StatefulWidget {
  final void Function() resetSelected;
  const DrawerHome({super.key, required this.resetSelected});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  List<String> getTheme = ["Dark", "Light"];
  List<Language> getLanguage = [
    Language(code: "en", lang: "English"),
    Language(code: "ar", lang: "Arabic"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(color: Apptheme.black),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(color: Apptheme.white),
            child: Text(
              "News App",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Apptheme.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    widget.resetSelected();
                    Navigator.of(context).pop();
                  },
                  child: TitleItem(icon: "home", text: "Go To Home"),
                ),
                SizedBox(height: 24),
                Divider(color: Apptheme.white),
                SizedBox(height: 24),
                TitleItem(icon: "theme", text: "Theme"),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Apptheme.white),
                  ),
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: Apptheme.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),

                      offset: Offset(0, -2),
                    ),
                    iconStyleData: IconStyleData(
                      iconSize: 40,
                      iconEnabledColor: Apptheme.white,
                    ),
                    underline: SizedBox(),

                    value: getTheme[0],
                    items: getTheme
                        .map(
                          (theme) => DropdownMenuItem<String>(
                            value: theme,
                            child: Text(
                              theme,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 24),
                Divider(color: Apptheme.white),
                SizedBox(height: 24),
                TitleItem(icon: "language", text: "Language"),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Apptheme.white),
                  ),
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: Apptheme.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),

                      offset: Offset(0, -2),
                    ),
                    iconStyleData: IconStyleData(
                      iconSize: 40,
                      iconEnabledColor: Apptheme.white,
                    ),
                    underline: SizedBox(),

                    value: getLanguage[0].code,
                    items: getLanguage
                        .map(
                          (Lang) => DropdownMenuItem<String>(
                            value: Lang.code,
                            child: Text(
                              Lang.lang,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Language {
  String code;
  String lang;
  Language({required this.code, required this.lang});
}
