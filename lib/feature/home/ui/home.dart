import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timer_app/constant/color_constant.dart';
import 'package:timer_app/constant/image_constant.dart';
import 'package:timer_app/constant/string_constant.dart';
import 'package:timer_app/feature/home/ui/break_widget.dart';
import 'package:timer_app/feature/home/view_model/home_view_model.dart';
import 'package:timer_app/widget/app_background.dart';
import 'package:timer_app/widget/app_text.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      requiredSafeArea: false,
      child: Stack(
        children: [
          Image.asset(
            ImageConstant.headerImage,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 56,
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(ImageConstant.menuImage),
                        Row(
                          spacing: 24,
                          children: [
                            Container(
                              height: 36,
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: HexColor(
                                    ColorConstant.greyBorderColor,
                                  ),
                                ),
                              ),
                              child: Row(
                                spacing: 8,
                                children: [
                                  Image.asset(ImageConstant.phoneImage),
                                  AppText(
                                    text: 'Help',
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 36,
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: HexColor(
                                    ColorConstant.greyBorderColor,
                                  ),
                                ),
                              ),
                              child: Image.asset(ImageConstant.cupImage),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      var name = ref.watch(nameProvider);
                      return name.when(
                        data: (name) => AppText(
                          text: 'Hi, $name!',
                          color: HexColor(ColorConstant.whiteColor),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        loading: () => Container(),
                        error: (error, stack) => AppText(
                          text: 'Hi!',
                          color: HexColor(ColorConstant.whiteColor),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),

                  AppText(
                    text: StringConstant.youAreOnBreakText,
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  BreakWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
