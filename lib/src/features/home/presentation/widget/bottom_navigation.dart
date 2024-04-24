// importing required package
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// importing neccesary file
import 'package:volun_tek/src/constants/app_style.dart';
import 'package:volun_tek/src/constants/colors.dart';
import 'package:volun_tek/src/features/profile/presentation/widget/profile.dart';
import '../../../search/presentation/widget/search.dart';
import 'home.dart';

// Define a StateProvider to manage the index of the selected bottom navigation item
var indexProvider = StateProvider<int>((ref) => 0);

// Define a StatefulWidget for the bottom navigation
class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({super.key});

  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  int index = 0; // Initialize the index of the selected bottom navigation item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const Home(), // Display the Home widget when index is 0
        const Search(), // Display the Search widget when index is 1
        Center(
          child: Text('Coming soon',
              style: AppStyle
                  .kHeading1), // Display placeholder text when index is 2
        ),
        const Profile() // Display the Profile widget when index is 3
      ][index], // Select the widget to display based on the current index
      bottomNavigationBar: NavigationBarTheme(
        // Customize the bottom navigation bar theme
        data: const NavigationBarThemeData(
          backgroundColor: Colors
              .white, // Set the background color of the bottom navigation bar
          indicatorColor: Colors.blue,
        ),
        child: NavigationBar(
          // Define the bottom navigation bar
          height: 72,
          selectedIndex: index,
          onDestinationSelected: (int index) {
            // Define a callback for when a navigation item is selected
            setState(() => this.index = index);
          },
          destinations: const [
            // Define the navigation icons for the bottom navigation bar
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.manage_search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.forum),
              label: 'Community',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
