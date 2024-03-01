import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:registration/pages/auth/sign_in.dart';
import 'package:registration/pages/auth/components/password_validation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  bool passwordVisible = true;
  bool showError = false;

  Map<String, String> userInfo = {  };

  // Declare controllers for the text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ));
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text('Create Account'),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                const Align(
                  heightFactor: 1,
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  heightFactor: 1.5,
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter your Name, Email and Password for Sign up. ',
                      style:
                          const TextStyle(fontSize: 18, color: Colors.blueGrey),
                      children: [
                        TextSpan(
                          text: 'Already have account.',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.green),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 245, 244, 244),
                    hintText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextFormField(
                    controller: emailController,
                    // The validator receives the text that the user has entered.
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
                ),
                TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      PasswordValidation.passwordValidation(value),
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
                      // Use the controllers to get the values of the text fields
                      // and store them in the map

                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snack bar. In the real world,
                        // you'd often call a server or save the information in a database.
                        userInfo['name'] = nameController.text.trim();
                        userInfo['email'] = emailController.text;
                        userInfo['password'] = passwordController.text.trim();
                        // Print the map to see the result
                        print(userInfo);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sign up successfully')),
                        );
                      } else {}
                    },
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'By Signing up you agree to our Terms Conditions & Privacy Policy.',
                    style: TextStyle(fontSize: 16, color: Colors.black38),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Center(
                  heightFactor: 2,
                  child: Text(
                    'Or',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton.icon(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color.fromARGB(255, 6, 6, 84)),
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
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ElevatedButton.icon(
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
