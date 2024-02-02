import 'package:ecom/services/auth.dart';
import 'package:ecom/users/home_screen.dart';
import 'package:ecom/users/signup_sreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final isPassshow = true.obs;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> submitSignIn({
    email,
    password,
  }) async {
    final res = await Authentication().signIn(email, password);
    // print(res);
    if (res["errorCode"] == 1003) {
      Get.dialog(
        AlertDialog(
          content: Text(res['message']),
        ),
      );
    }
    if (res["errorCode"] == 1001) {
      Get.dialog(
        AlertDialog(
          content: Text(res['message']),
        ),
      );
    }

    prefs.setString('token', res['token']);
    Get.to(HomeScreen(token: res['token']));
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
                      'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
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
                                    submitSignIn(
                                        email: emailController.text,
                                        password: passController.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                child: const Text(
                                  'Sing In',
                                  style: TextStyle(color: Colors.white),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have a Accout?"),
                                TextButton(
                                    onPressed: () {
                                      Get.to(const SignupScreen());
                                    },
                                    child: const Text("Join Now"))
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
