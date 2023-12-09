import 'package:e_commerce/providers/favorites_provider.dart';
import 'package:e_commerce/screens/favorites_screen.dart';

import 'package:e_commerce/screens/myorders_screen.dart';
import 'package:e_commerce/screens/myprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(children: [
                    Text(
                      'Shopping Store',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.store,
                      color: Theme.of(context).colorScheme.background,
                      size: 25,
                    )
                  ])
                ]),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Home Page',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyProfile(),
              ));
            },
            leading: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'My account',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyOrdersScreen(),
              ));
            },
            leading: Icon(
              Icons.shopping_basket,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'My orders',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FavoriteScreen(),
              ));
            },
            leading: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'favorites',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.question_mark_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'About',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
