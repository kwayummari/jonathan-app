import 'package:daladala_smart/src/provider/login-provider.dart';
import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/utils/routes/route-names.dart';
import 'package:daladala_smart/src/widgets/app_button.dart';
import 'package:daladala_smart/src/widgets/app_input_text.dart';
import 'package:daladala_smart/src/widgets/socialMedia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:daladala_smart/src/service/login-services.dart';
import 'package:daladala_smart/src/widgets/app_base_screen.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginService _apiService = loginService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool marked = false;
  bool dont_show_password = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context);
    return AppBaseScreen(
      isvisible: true,
      backgroundImage: false,
      backgroundAuth: false,
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Image.asset('assets/logo1.png'),
              SizedBox(
                height: 30,
              ),
              AppText(
                txt: 'WELCOME BACK',
                size: 25,
                weight: FontWeight.w400,
                color: HexColor('#ffffff'),
              ),
              SizedBox(
                height: 15,
              ),
              AppText(
                txt: 'Login into your account',
                size: 15,
                weight: FontWeight.w400,
                color: HexColor('#ffffff'),
              ),
              SizedBox(
                height: 30,
              ),
              AppInputText(
                textsColor: AppConst.black,
                textfieldcontroller: email,
                ispassword: false,
                fillcolor: AppConst.white,
                label: 'Email',
                obscure: false,
                icon: Icon(
                  Icons.person,
                  color: AppConst.black,
                ),
                isemail: true,
              ),
              AppInputText(
                textsColor: AppConst.black,
                isemail: false,
                textfieldcontroller: password,
                ispassword: dont_show_password,
                fillcolor: AppConst.white,
                label: 'Password',
                obscure: dont_show_password,
                icon: Icon(
                  Icons.lock,
                  color: AppConst.black,
                ),
                suffixicon: IconButton(onPressed: () {
                  setState(() {
                    dont_show_password = !dont_show_password;
                  });
                }, icon: Icon(dont_show_password ? Icons.visibility_off : Icons.visibility)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppText(
                    txt: 'Forgot password?',
                    size: 15,
                    color: AppConst.primary,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              myProvider.myLoging == true
                  ? SpinKitCircle(
                      color: AppConst.primary,
                    )
                  : Container(
                      width: 350,
                      height: 55,
                      child: AppButton(
                        onPress: () => loginService()
                            .login(context, email.text, password.text),
                        label: 'LOGIN',
                        borderRadius: 20,
                        textColor: AppConst.white,
                        bcolor: AppConst.primary,
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              socialMedia(),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.registration),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: AppConst.white),
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          color: AppConst.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
