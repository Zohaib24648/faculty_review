import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Include this for URL launching

class SupportTheAuthorPage extends StatelessWidget {
  const SupportTheAuthorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap your Column with a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/images/profile_Picture.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Zohaib Ali Mughal',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Age: 21',
                                  style: TextStyle(
                                      fontSize: 18, fontStyle: FontStyle.italic),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "BS-CS  IBA'25",
                                  style: TextStyle(
                                      fontSize: 18, fontStyle: FontStyle.italic),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Web & App Developer',
                                  style: TextStyle(
                                      fontSize: 18, fontStyle: FontStyle.italic),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Single',
                                  style: TextStyle(
                                      fontSize: 18, fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image.asset('assets/images/mai-garib-hu.gif', fit: BoxFit.cover),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          const Text('Buy Me: ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          const SizedBox(height: 16),
                          Row(children: [
                            SupportButton(
                              title: 'Coffee',
                              icon: Icons.local_cafe,
                              onPressed: () {
                                // Add your logic here
                              },
                            ),
                            SupportButton(
                              title: 'Pizza',
                              icon: Icons.local_pizza,
                              onPressed: () {
                                // Add your logic here
                              },
                            ),
                            SupportButton(
                              title: 'Burger',
                              icon: Icons.fastfood,
                              onPressed: () {
                                // Add your logic here
                              },
                            ),
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Follow me on Social Media:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                children: [
                  IconButton(
                    icon: Icon(EvaIcons.linkedin, size: 35,color: Color.fromARGB(255, 0, 119, 181),),
                    onPressed: () => launchURL('https://www.linkedin.com/in/zohaibmughal24648/'),
                  ),
                  IconButton(
                    icon: Icon(EvaIcons.facebook, size: 35,color: Color.fromARGB(255, 24, 119, 242),),
                    onPressed: () => launchURL('https://www.facebook.com/zohaibmughal2002/'),
                  ),
                  IconButton(
                    icon: Icon(EvaIcons.twitter, size: 35, color: Color.fromARGB(255, 29, 161, 242),),
                    onPressed: () => launchURL('https://www.instagram.com/zohaib.rar/'),
                  ),
                  IconButton(
                    icon: Icon(EvaIcons.github, size: 35,color: Color.fromARGB(255, 0, 0, 0)),
                    onPressed: () => launchURL('https://github.com/Zohaib24648'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void launchURL(String url) async {
    try {
      bool launched = await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView);
      if (!launched) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      // Log or handle the error more gracefully here
      print('Failed to launch URL: $e');
    }
  }
}

class SupportButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  SupportButton({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          onPressed: onPressed,
          child: Icon(icon, size: 25),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
