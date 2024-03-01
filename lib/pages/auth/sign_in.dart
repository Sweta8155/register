import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:registration/pages/auth/registration_screen.dart';
import 'package:registration/pages/auth/components/password_validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile_page.dart';
import 'components/forgot_password.dart';

  class SignInScreen extends StatefulWidget {
    const SignInScreen({super.key});
  
    @override
    State<SignInScreen> createState() => _SignInScreenState();
  
  }
  
  class _SignInScreenState extends State<SignInScreen> {
    final _formKey = GlobalKey<FormState>();
  
    bool isValidEmail(String email) {
      return EmailValidator.validate(email);
    }
  
    bool passwordVisible = true;
    bool showError = false;
  
    Map<String, String> userInfo = {};
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
  
    Future<void> saveEmail() async{
      final userInfo = await SharedPreferences.getInstance();
      userInfo.setString('email', emailController.text);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  heightFactor: 1,
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 30),
                  ),
                ),

                //Text2
                const Align(
                  alignment: Alignment.topLeft,
                  heightFactor: 2,
                  child: Text(
                      'Enter your email address to sign in. Enjoy your food :)',
                      style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
                ),

                //Email
                TextFormField(
                  key: const Key('email'),
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (input) => isValidEmail(input!)
                      ? null
                      : 'Please enter a valid email',
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 245, 244, 244),
                    hintText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),

                //Password
                Padding(
                  key: const Key('password'),
                  padding: const EdgeInsets.only(top: 15),
                  child: TextFormField(
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        PasswordValidation.passwordValidation(value!),
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 245, 244, 244),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    style: const TextStyle(fontSize: 18),
                    onChanged: (value) {
                      setState(() {
                        showError = true;
                      });
                    },
                  ),
                ),

                //Forgot Password
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 15),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ));
                      },
                      child: const Text('Forgot Password?',
                          style:
                              TextStyle(fontSize: 18, color: Colors.blueGrey)),
                    ),
                  ),
                ),

                //Signing button
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      fixedSize: MaterialStatePropertyAll(
                        Size(500, 50),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          userInfo['email'] = emailController.text;
                          userInfo['password'] = passwordController.text.trim();
                          saveEmail();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()),
                          );
                        });
                        print(userInfo);
                      } else {}
                    },
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),

                //Navigate to signup screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Don't have account?",
                      style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Create new account.',
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      ),
                    ),
                  ],
                ),

                //Or
                const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    'Or',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),

                //Facebook button
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 6, 6, 84)),
                      fixedSize: MaterialStatePropertyAll(Size(500, 50)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                    onPressed: () {},
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Image.asset('assets/images/facebook_icon.png',
                          height: 30, width: 30),
                    ),
                    label: const Text(
                      'CONNECT WITH FACEBOOK',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),

                //Google button
                ElevatedButton.icon(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    fixedSize: MaterialStatePropertyAll(Size(500, 50)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  onPressed: () {},
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Image.asset('assets/images/google_icon.png',
                        height: 31, width: 31),
                  ),
                  label: const Text(
                    'CONNECT WITH GOOGLE',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
