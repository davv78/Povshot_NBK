import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/button_primary.dart';
import '../widget/widget_ilustration.dart';
import 'general_logo_splash.dart';
import 'user_page.dart';
import 'login_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // checkLoginStatus(); // Memeriksa status login saat SplashScreen ditampilkan
  }

  // Future<void> checkLoginStatus() async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // String? token = prefs.getString('token');

  //   if (token != null) {
  //     // Pengguna telah masuk sebelumnya, arahkan ke halaman beranda
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomePage()),
  //     );
  //   } else {
  //     // Pengguna belum masuk, arahkan ke halaman login
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => LoginPages()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: generalLogoSpace(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            WidgetIlustration(
              image: 'assets/logo.png',
              child: ButtonPrimary(
                text: "GET STARTED",
                OnTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPages(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
