import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/data_utils/validators.dart';
import 'package:food_ecommerce/features/auth/presentation/login_screen.dart';
import 'package:food_ecommerce/features/auth/presentation/state/auth_cubit.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:food_ecommerce/reusables/input_field.dart';
import 'package:food_ecommerce/reusables/loader_view.dart';
import 'package:food_ecommerce/reusables/my_toast.dart';
import 'package:food_ecommerce/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signUp-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    MyFormValidator.emailErr = null;
    MyFormValidator.passwordErr = null;
    MyFormValidator.nameErr = null;
    MyFormValidator.phoneErr = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final storeCubit = context.read<StoreCubit>();
    return LoaderLayout(
      loading: storeCubit.state.isLoading,
      overlay: true,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Food E-commerce"),
        // ),

        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 170,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/food_tray.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.only(left: 15, bottom: 20),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Flexible(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      children: [
                        InputField(
                          hintText: "Username",
                          controller: _nameController,
                          errorText: MyFormValidator.nameErr,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputField(
                          errorText: MyFormValidator.emailErr,
                          hintText: "Email Address",
                          controller: _emailController,
                          validator: MyFormValidator.validateEmail,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputField(
                          errorText: MyFormValidator.phoneErr,
                          hintText: "Phone Number",
                          controller: _phoneController,
                          validator: MyFormValidator.validatePhonenumber,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputField(
                          errorText: MyFormValidator.passwordErr,
                          hintText: "Password",
                          controller: _passwordController,
                          validator: MyFormValidator.validatePassword,
                          isPassword: true,
                          hidePass: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.brown[300],
                          ),
                          child: TextButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                await authCubit.register(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                                await authCubit.saveUserToDB(
                                  email: _emailController.text.trim(),
                                  phoneNumber: _phoneController.text.trim(),
                                  userName: _nameController.text.trim(),
                                  imageUrl: null,
                                );
                                await authCubit.getUserData();
                                if (authCubit.state.error == null) {
                                  MyToast.show(
                                    context: context,
                                    text:
                                        'Welcome Onboard, ${authCubit.userData?.userName ?? ""}',
                                  );
                                  await storeCubit.getProducts();

                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.routeName);
                                } else {
                                  MyToast.show(
                                    context: context,
                                    text: authCubit.state.error?.message ??
                                        "An Error Occured",
                                    isError: true,
                                  );
                                }
                              } else {
                                setState(() {});
                                return;
                              }
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            children: [
                              const TextSpan(
                                text: "Already registered? ",
                              ),
                              TextSpan(
                                text: "Sign In ",
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushNamed(
                                      LoginScreen.routeName,
                                    );
                                  },
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
          ],
        ),
      ),
    );
  }
}
