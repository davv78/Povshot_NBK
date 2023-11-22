
// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
// import 'package:povshotnbk/pages/general_logo_splash.dart';

// import '../network/api/url_api.dart';
// import '../theme.dart';
// import '../widget/button_primary.dart';
// import 'login_pages.dart';


// class RegisterPage extends StatefulWidget {
//   const RegisterPage({Key? key}) : super(key: key);

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   bool _obscureText = true;

//   void showHide() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   Future<void> registerSubmit() async {
//     var registerUrl = Uri.parse(BASEURL.apiRegister);
//     final response = await http.post(registerUrl, body: {
//       'fullname': fullNameController.text,
//       'email': emailController.text,
//       'phone': phoneController.text,
//       'address': addressController.text,
//       'password': passwordController.text,
//     });
//     final data = jsonDecode(response.body);
//     int value = data['value'];
//     String message = data['message'];
//     if (value == 1) {
//       await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Information",style: regularTextStyle,),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPages()),
//                   (route) => false,
//                 );
//               },
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//     } else {
//       await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Information"),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//     }
//     setState(() {});
//   }

//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           Container(
//             child: generalLogoSpace(
//               child: Container(),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             padding: EdgeInsets.all(24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'REGISTER',
//                   style: regularTextStyle.copyWith(fontSize: 25),
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Text(
//                   'Register your new account first',
//                   style: regularTextStyle.copyWith(
//                       fontSize: 15, color: greyLightColor),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 // NOTE: TEXTFIELD
//                 Container(
//                   padding: EdgeInsets.only(left: 16),
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Color(0x40000000),
//                           blurRadius: 4,
//                           offset: Offset(0, 1),
//                           spreadRadius: 0),
//                     ],
//                     color: whiteColor,
//                   ),
//                   width: MediaQuery.of(context).size.width,
//                   child: TextField(
//                     controller: fullNameController,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Full Name',
//                       hintStyle: lightTextStyle.copyWith(
//                           fontSize: 15, color: greyLightColor),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 16),
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Color(0x40000000),
//                           blurRadius: 4,
//                           offset: Offset(0, 1),
//                           spreadRadius: 0),
//                     ],
//                     color: whiteColor,
//                   ),
//                   width: MediaQuery.of(context).size.width,
//                   child: TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Email Address',
//                       hintStyle: lightTextStyle.copyWith(
//                           fontSize: 15, color: greyLightColor),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 16),
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Color(0x40000000),
//                           blurRadius: 4,
//                           offset: Offset(0, 1),
//                           spreadRadius: 0),
//                     ],
//                     color: whiteColor,
//                   ),
//                   width: MediaQuery.of(context).size.width,
//                   child: TextField(
//                     controller: phoneController,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Phone Number',
//                       hintStyle: lightTextStyle.copyWith(
//                           fontSize: 15, color: greyLightColor),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 16),
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Color(0x40000000),
//                           blurRadius: 4,
//                           offset: Offset(0, 1),
//                           spreadRadius: 0),
//                     ],
//                     color: whiteColor,
//                   ),
//                   width: MediaQuery.of(context).size.width,
//                   child: TextField(
//                     controller: addressController,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Home Address',
//                       hintStyle: lightTextStyle.copyWith(
//                           fontSize: 15, color: greyLightColor),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 16),
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0x40000000),
//                         blurRadius: 4,
//                         offset: Offset(0, 1),
//                         spreadRadius: 0,
//                       ),
//                     ],
//                     color: whiteColor,
//                   ),
//                   width: MediaQuery.of(context).size.width,
//                   child: TextField(
//                     controller: passwordController,
//                     obscureText: _obscureText,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Password',
//                       hintStyle: lightTextStyle.copyWith(
//                         fontSize: 15,
//                         color: greyLightColor,
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscureText
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: greyLightColor,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscureText = !_obscureText;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: ButtonPrimary(
//                     text: 'REGISTER',
//                     OnTap: () {
//                       if (fullNameController.text.isEmpty ||
//                           emailController.text.isEmpty ||
//                           phoneController.text.isEmpty ||
//                           addressController.text.isEmpty ||
//                           passwordController.text.isEmpty) {
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: Text("Warning!"),
//                             content:
//                                 Text("Harap isi semua form terlebih dahulu!"),
//                             actions: [
//                               TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text("OK"))
//                             ],
//                           ),
//                         );
//                       } else {
//                         registerSubmit();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Already Have Account ? ',
//                 style: lightTextStyle.copyWith(
//                   color: greyLightColor,
//                   fontSize: 15,
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPages()),
//                       ((route) => false));
//                 },
//                 child: Text(
//                   'Login Now!',
//                   style:
//                       boldTextStyle.copyWith(color: blackColor, fontSize: 15),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
