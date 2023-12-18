import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidermenu_and_dashboard/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = false;
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideTransitionAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(animationController);
    slideTransitionAnimation =
        Tween(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(parent: animationController, curve: Curves.decelerate),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.dashboardBackground,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          Icon(Icons.home),
          Icon(Icons.person),
          Icon(Icons.notifications_active),
          Icon(Icons.login_sharp)
        ],
        height: 50,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            menuWidget(),
            dashboardWidget(),
          ],
        ),
      ),
    );
  }

  menuWidget() {
    return SlideTransition(
      position: slideTransitionAnimation,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 240),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 150,
                height: 150,
                child: ClipOval(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                ),
              ),
              Text('Noah Mitchell', style: Constants.nameSurnameTextStyle),
              Text('Winchester, Hants', style: Constants.regionTextStyle),
              const SizedBox(height: 15),
              buildMenuItem('Dashboard', 'assets/icons/dashboard-icon.png'),
              buildMenuItem('Messages', 'assets/icons/message-icon.png'),
              buildMenuItem('Utility Bills', 'assets/icons/bills-icon.png'),
              buildMenuItem('Fon Transfer', 'assets/icons/transfer-icon.png'),
              buildMenuItem('Branches', 'assets/icons/bank-icon.png'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(String title, String icon) {
    return ListTile(
      selectedTileColor: Colors.white,
      contentPadding: const EdgeInsets.all(0),
      leading: Image.asset(icon, width: 25, height: 25),
      title: Text(title, style: Constants.menuTextStyle),
      horizontalTitleGap: 8,
      onTap: () {},
    );
  }

  dashboardWidget() {
    return AnimatedPositioned(
      left: isMenuOpen ? 0.5 * Constants.getScreenWidth(context) : 0,
      top: 0,
      right: isMenuOpen ? -0.3 * Constants.getScreenWidth(context) : 0,
      bottom: 0,
      duration: const Duration(milliseconds: 500),
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                isMenuOpen ? BorderRadius.circular(25) : BorderRadius.zero,
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: isMenuOpen ? 50 : 0,
                  spreadRadius: -10),
            ],
            color: Constants.dashboardBackground,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isMenuOpen) {
                            animationController.reverse();
                          } else {
                            animationController.forward();
                          }
                          isMenuOpen = !isMenuOpen;
                        });
                      },
                      child: const Icon(Icons.menu, color: Colors.amber),
                    ),
                    Text('My Cards', style: Constants.appBarTextStyle),
                    const Icon(Icons.add_circle_outline_outlined,
                        color: Colors.amber),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CarouselSlider.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Colors.white.withOpacity(0.2),
                      elevation: 5,
                      color: Colors.transparent,
                      child: Image.asset(
                        imageList[index],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  enlargeCenterPage: true,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 15, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Transactions',
                                style: GoogleFonts.aBeeZee(fontSize: 20)),
                            const Icon(
                              Icons.filter_list,
                              color: Constants.iconColor,
                            )
                          ],
                        ),
                        const Text('Today',
                            style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 10),
                        buildMaterial(
                            'Purchase',
                            'Starbucks',
                            'assets/icons/starbucks.png',
                            '-55 \$',
                            const Color.fromARGB(255, 202, 114, 108)),
                        const SizedBox(height: 8),
                        buildMaterial(
                            'Purchase',
                            'Apple',
                            'assets/icons/apple.png',
                            '-2555 \$',
                            const Color.fromARGB(255, 202, 114, 108)),
                        const SizedBox(height: 8),
                        buildMaterial(
                            'Outgoing Transfer',
                            'Jeff Bezos',
                            'assets/icons/transfer.png',
                            '-1255 \$',
                            const Color.fromARGB(255, 202, 114, 108)),
                        const SizedBox(height: 8),
                        const Text(
                          'Yesterday',
                          style: TextStyle(color: Colors.grey),
                        ),
                        buildMaterial(
                            'Incoming Transfer',
                            'Upwork',
                            'assets/icons/transfer.png',
                            '+875 \$',
                            Colors.green),
                        const SizedBox(height: 8),
                        buildMaterial(
                            'Outgoing Transfer',
                            'Warren Buffet',
                            'assets/icons/transfer.png',
                            '-8754 \$',
                            const Color.fromARGB(255, 202, 114, 108)),
                        const SizedBox(height: 8),
                        buildMaterial(
                            'Purchase',
                            'Google',
                            'assets/icons/google.png',
                            '+1255 \$',
                            Colors.green),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMaterial(String title, String subtitle, String imagePath,
      String trailingText, Color amountColor) {
    return Material(
      color: Constants.dashboardBackground.withOpacity(0.8),
      shadowColor: Colors.white.withOpacity(0.2),
      elevation: 3,
      borderRadius: BorderRadius.circular(12),
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 30,
          height: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
        trailing: Text(
          trailingText,
          style: TextStyle(color: amountColor, fontSize: 15),
        ),
      ),
    );
  }

  final List imageList = [
    'assets/images/card1.png',
    'assets/images/card2.png',
    'assets/images/card3.png'
  ];
}
