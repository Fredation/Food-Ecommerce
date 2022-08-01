import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/data_utils/validators.dart';
import 'package:food_ecommerce/core/size_config/config.dart';
import 'package:food_ecommerce/features/auth/presentation/sign_up_screen.dart';
import 'package:food_ecommerce/features/auth/presentation/state/auth_cubit.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:food_ecommerce/reusables/input_field.dart';
import 'package:food_ecommerce/reusables/loader_view.dart';
import 'package:food_ecommerce/reusables/my_toast.dart';
import 'package:food_ecommerce/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    MyFormValidator.emailErr = null;
    MyFormValidator.passwordErr = null;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final storeCubit = context.read<StoreCubit>();
    SizeConfig.init(context);
    return LoaderLayout(
      loading: storeCubit.state.isLoading,
      overlay: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/food_tray.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 15, bottom: 20),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
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
                        errorText: MyFormValidator.passwordErr,
                        hintText: "Password",
                        controller: _passwordController,
                        validator: MyFormValidator.validatePassword,
                      ),
                      const SizedBox(
                        height: 40,
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
                              await authCubit.login(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                              await authCubit.getUserData();
                              if (authCubit.state.error == null) {
                                MyToast.show(
                                  context: context,
                                  text:
                                      'Welcome Back, ${authCubit.userData?.userName ?? ""}',
                                  isError: false,
                                );
                                await storeCubit.getProducts();
                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.routeName);
                              } else {
                                MyToast.show(
                                    context: context,
                                    text: authCubit.state.error?.message ??
                                        "An Error Occured",
                                    isError: true);
                              }
                            } else {
                              setState(() {});
                              return;
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
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
                              text: "Not registered yet? ",
                            ),
                            TextSpan(
                              text: "Sign Up ",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushNamed(
                                    SignUpScreen.routeName,
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
        ),
      ),
    );
  }
}
