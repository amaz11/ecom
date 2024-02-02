import 'dart:convert';

import 'package:ecom/services/auth.dart';
import 'package:ecom/users/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final isPassshow = true.obs;
  Future<void> submitSignup({
    name,
    email,
    password,
  }) async {
    final res = await Authentication().signUp(name, email, password);
    if (res == null) return;
    if (res["ok"]) {
      Get.dialog(
        AlertDialog(
          content: Text(res['status']),
          actions: [
            TextButton(
                onPressed: () {
                  Get.to(const LoginScreen());
                },
                child: const Text('LogIn Now'))
          ],
        ),
      );
    } else {
      Get.dialog(
        AlertDialog(
          content: Text(res['status']),
          actions: [
            TextButton(
                onPressed: () {
                  Get.to(const LoginScreen());
                },
                child: const Text('LogIn Now'))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: cons.maxHeight),
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 285,
                  child: Image.network(
                      'https://plus.unsplash.com/premium_photo-1683133494951-95b3da46bbde?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  // decoration: const BoxDecoration(
                  //     color: Colors.white38,
                  //     borderRadius: BorderRadius.all(Radius.circular(60)),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           blurRadius: 1,
                  //           color: Colors.black12,
                  //           offset: Offset(0, -3))
                  //     ]),
                  child: Column(children: [
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60))),
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 20),
                                  hintText: 'Enter Your Name',
                                  suffixIcon: Icon(Icons.email)),
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Name can't be empty";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60))),
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 20),
                                  hintText: 'Enter Your Email',
                                  suffixIcon: Icon(Icons.email)),
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email can't be empty";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() => TextFormField(
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60))),
                                    contentPadding: const EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 20),
                                    hintText: 'Enter Your Password',
                                    suffixIcon: Obx(() => GestureDetector(
                                          onTap: () {
                                            isPassshow.value =
                                                !isPassshow.value;
                                          },
                                          child: Icon(isPassshow.value
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        )),
                                  ),
                                  obscureText: isPassshow.value,
                                  controller: passController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password can't be empty";
                                    }
                                    return null;
                                  },
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    submitSignup(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passController.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.white),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have a Accout?"),
                                TextButton(
                                    onPressed: () {
                                      Get.to(const LoginScreen());
                                    },
                                    child: const Text("Sign In Now"))
                              ],
                            )
                          ],
                        ))
                  ]),
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
