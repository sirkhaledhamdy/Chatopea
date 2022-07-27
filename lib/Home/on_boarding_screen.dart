import 'package:flutter/material.dart';

import '../constants/components/components.dart';
import '../modules/social_app/social_login/login_screen.dart';
import '../modules/social_app/social_register/register_screen.dart';
import '../styles/colors.dart';

class SocialOnBoardingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _validate = false;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: secDefaultColor,
          centerTitle: true,
        ),
        backgroundColor: secDefaultColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset(
                        'assets/images/logo1.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      'The Most Elegant Social Media Platform',
                      style: TextStyle(
                        fontFamily: 'Product',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    sideColor: defaultColor,
                    onPressed: () async {
                      final bool? result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SocialLoginScreen();
                          },
                        ),
                      );
                    },
                    text: 'LOGIN',
                    textColor: defaultColor,
                    color: secDefaultColor,
                  ),
                  SizedBox(height: 20,),
                  defaultButton(
                    sideColor: secDefaultColor,
                    color: defaultColor,
                    onPressed: () async {
                      final bool? result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SocialRegisterScreen();
                          },
                        ),
                      );
                    },
                    text: 'Create Account',
                    textColor: secDefaultColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'By Signing up, you agree to the',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                        ),
                        onPressed: () {

                        },
                        child: Text(
                          'Terms of use & privacy policy',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

