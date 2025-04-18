import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/main.dart';
import 'package:rachadinha/ui/auth/viewmodels/auth_viewmodel.dart';
import 'package:routefly/routefly.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Rachadinha',
                    style: TextStyle(fontSize: 28, color: Colors.white)),
                Spacer(),
                Icon(
                  FontAwesomeIcons.bars,
                  color: Colors.white,
                  size: 38,
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white),
          ListTile(
            title: const Row(
              children: [
                Icon(
                  FontAwesomeIcons.clockRotateLeft,
                  size: 24,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  'Histórico',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Routefly.push(routePaths.history);
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            title: const Row(
              children: [
                Icon(
                  FontAwesomeIcons.qrcode,
                  size: 24,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  'QR Code',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Routefly.push(routePaths.qrcode);
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            title: const Row(
              children: [
                Icon(
                  FontAwesomeIcons.arrowRightFromBracket,
                  size: 24,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  'Logout',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            onTap: () async {
              await injector.get<AuthViewModel>().logout();
              Routefly.push(routePaths.auth.login);
            },
          ),
          const Divider(color: Colors.white),
        ],
      ),
    );
  }
}
