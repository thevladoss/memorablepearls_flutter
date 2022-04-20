
import 'package:flutter/material.dart';
import 'package:memorablepearls_flutter/utils/colors.dart';
import 'package:memorablepearls_flutter/utils/icons.dart';
import 'package:memorablepearls_flutter/utils/typography.dart';

class VKButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 100,
      child: SizedBox(
        height: 46.0,
        child: ElevatedButton.icon(
            onPressed: () {},
            style: ButtonStyle(
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(AppColors.vkColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )
            )
          ),
          label: Text('Авторизация через ВК', style: AppTextStyles.buttonStyle),
          icon: AppIcons.vk,
        ),
      ),
    );
  }

}