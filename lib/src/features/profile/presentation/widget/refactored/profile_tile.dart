import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants/app_style.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.imgUrl,
    required this.title,
    this.isCentered = true,
    this.onTap, h
  });

  final String imgUrl;
  final String title;
  final bool isCentered;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment:
            isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          SvgPicture.asset(imgUrl),
          const SizedBox(width: 4),
          Text(
            title,
            style: AppStyle.kRegular16Inter.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
