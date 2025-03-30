import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Icon(
              FontAwesomeIcons.moneyBillTransfer,
              color: context.colors.primarygreen,
              size: 38,
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Icon(
          FontAwesomeIcons.bars,
          color: context.colors.primarygreen,
          size: 38,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      backgroundColor: context.colors.light,
      actions: const [
        SizedBox(width: 64),
        // IconButton(
        //   icon: Icon(
        //     FontAwesomeIcons.circleUser,
        //     color: context.colors.primarygreen,
        //     size: 38,
        //   ),
        //   onPressed: () {},
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
