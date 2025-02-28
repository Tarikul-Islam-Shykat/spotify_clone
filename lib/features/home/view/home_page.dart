import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/colors/app_pallete.dart';
import 'package:spotify_clone/features/home/pages/library_page.dart';
import 'package:spotify_clone/features/home/pages/songs_page.dart';
import 'package:spotify_clone/features/home/view/upload_song_page.dart';
import 'package:spotify_clone/features/home/widget/music_slab.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedIndex = 0;
  final pages = const [SongPage(), LibraryPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: pages[selectedIndex]),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MusicSlab(),
          ),
              ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                label: "Home",
                icon: Image.asset(
                  selectedIndex == 0
                      ? 'assets/images/home_filled.png'
                      : 'assets/images/home_unfilled.png',
                  color: selectedIndex == 0
                      ? AppPallete.whiteColor
                      : AppPallete.greyColor,
                )),
            BottomNavigationBarItem(
              label: "Library",
              icon: Image.asset(
                'assets/images/library.png',
                color: selectedIndex == 1
                    ? AppPallete.whiteColor
                    : AppPallete.greyColor,
              ),
            )
          ]),
    );
  }
}

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2A2A72), // Dark blue background
//       body: Container(), // Your page content here
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24),
//             topRight: Radius.circular(24),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _NavItem(
//                 label: 'Events',
//                 icon: Icons.calendar_today,
//                 isSelected: true,
//                 onTap: () {
//                   MaterialPageRoute(
//                       builder: (context) => const UploadSongPage());
//                 },
//               ),
//               _NavItem(
//                 icon: Icons.search,
//                 onTap: () {
//                   MaterialPageRoute(
//                       builder: (context) => const UploadSongPage());
//                 },
//               ),
//               _NavItem(
//                 icon: Icons.flash_on,
//                 onTap: () {},
//               ),
//               _NavItem(
//                 icon: Icons.menu,
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _NavItem extends StatelessWidget {
//   final IconData icon;
//   final String? label;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const _NavItem({
//     required this.icon,
//     this.label,
//     this.isSelected = false,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             color: isSelected ? const Color(0xFF2A2A72) : Colors.grey,
//           ),
//           if (label != null) ...[
//             const SizedBox(height: 4),
//             Text(
//               label!,
//               style: TextStyle(
//                 color: isSelected ? const Color(0xFF2A2A72) : Colors.grey,
//                 fontSize: 12,
//               ),
//             ),
//           ],
//           const SizedBox(height: 4),
//           if (isSelected)
//             Container(
//               width: 4,
//               height: 4,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF2A2A72),
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
