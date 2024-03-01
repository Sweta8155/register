import 'package:flutter/material.dart';
import 'package:registration/pages/auth/sign_in.dart';
import 'package:registration/pages/auth/components/password_validation.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = true;
  bool showError = false;

  Map<String, String> newPassword = {};

  // Declare controllers for the text fields
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
          title: const Text('Forgot Password'),
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
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  heightFactor: 1.5,
                  child: Wrap(
                    children: [
                      const Text(
                        'Enter your new password and confirm password.',
                        style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'For login click here',
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: newPasswordController,
                  // The validator receives the text that the user has entered.
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      PasswordValidation.passwordValidation(value),
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 245, 244, 244),
                    hintText: 'New Password',
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
                  child: TextFormField(
                    controller: confirmPasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value != newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 245, 244, 244),
                      hintText: 'Confirm Password',
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



                ElevatedButton(
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
                    if (_formKey.currentState!.validate()) {
                      newPassword['newPassword'] = newPasswordController.text;
                      newPassword['confirmPassword'] =
                          confirmPasswordController.text;
                      print(newPassword);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Reset password successfully')),
                      );
                    } else {}
                  },
                  child: const Text(
                    'CONFIRM PASSWORD',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
