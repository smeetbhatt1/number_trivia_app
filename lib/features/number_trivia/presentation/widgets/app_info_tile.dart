import 'package:flutter/material.dart';
import 'package:number_trivia_app/core/constants/app_images.dart';
import 'package:number_trivia_app/core/constants/view_text.dart';
import 'package:number_trivia_app/theme/app_colors.dart';

class AppInfoTile extends StatelessWidget {
  const AppInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _appIcon,
      title: _titleText,
      subtitle: _versionText,
    );
  }

  Widget get _appIcon => Container(
        color: AppColors.white,
        child: Image.asset(AppImages.icApp),
      );

  Widget get _titleText => const Text(
        ViewText.numberTrivia,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 24,
        ),
      );

  Widget get _versionText => const Text(
        '1.0.0',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 16,
        ),
      );
}
