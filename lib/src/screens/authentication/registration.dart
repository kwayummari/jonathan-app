import 'package:daladala_smart/src/utils/app_const.dart';
import 'package:daladala_smart/src/utils/routes/route-names.dart';
import 'package:daladala_smart/src/widgets/socialMedia.dart';
import 'package:flutter/material.dart';
import 'package:daladala_smart/src/service/registration-services.dart';
import 'package:daladala_smart/src/widgets/app_base_screen.dart';
import 'package:daladala_smart/src/widgets/app_button.dart';
import 'package:daladala_smart/src/widgets/app_input_text.dart';
import 'package:daladala_smart/src/widgets/app_text.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final registrationService _apiService = registrationService();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rpassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool dont_show_password = true;
  bool obscure = true;
  bool obscure1 = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              AppText(txt: 'Create an account', size: 30, color: AppConst.white, weight: FontWeight.w900,),
              SizedBox(
                height: 10,
              ),
              AppText(txt: 'Sign up to get started', size: 15, color: AppConst.white, weight: FontWeight.bold,),
              SizedBox(height: 20,),
              Column(
                children: [
                  AppInputText(
                    textsColor: AppConst.black,
                    isemail: false,
                    textfieldcontroller: fullname,
                    ispassword: false,
                    fillcolor: AppConst.white,
                    label: 'Fullname',
                    obscure: false,
                    icon: Icon(
                      Icons.person,
                      color: AppConst.black,
                    ),
                  ),
                  AppInputText(
                    textsColor: AppConst.black,
                    isemail: false,
                    isPhone: true,
                    textfieldcontroller: phone,
                    ispassword: false,
                    fillcolor: AppConst.white,
                    label: 'Phone number',
                    obscure: false,
                    icon: Icon(
                      Icons.phone,
                      color: AppConst.black,
                    ),
                  ),
                  AppInputText(
                      textsColor: AppConst.black,
                      isemail: true,
                      textfieldcontroller: email,
                      ispassword: false,
                      fillcolor: AppConst.white,
                      label: 'Email',
                      obscure: false),
                  AppInputText(
                    textsColor: AppConst.black,
                    isemail: false,
                    suffixicon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: obscure == true
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    textfieldcontroller: password,
                    ispassword: true,
                    fillcolor: AppConst.white,
                    label: 'Password',
                    obscure: obscure,
                    icon: Icon(
                      Icons.lock,
                      color: AppConst.black,
                    ),
                  ),
                  AppInputText(
                    textsColor: AppConst.black,
                    isemail: false,
                    suffixicon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure1 = !obscure1;
                          });
                        },
                        icon: obscure1 == true
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    textfieldcontroller: rpassword,
                    ispassword: false,
                    fillcolor: AppConst.white,
                    label: 'Password',
                    obscure: obscure1,
                    icon: Icon(
                      Icons.lock,
                      color: AppConst.black,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 350,
                    height: 49,
                    child: AppButton(
                      onPress: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        registrationService().registration(
                            context,
                            email.text,
                            password.text,
                            rpassword.text,
                            fullname.text,phone.text);
                      },
                      label: 'SIGN UP',
                      borderRadius: 20,
                      textColor: AppConst.white,
                      bcolor: AppConst.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: AppText(txt: 'By continuing you accept ', size: 15, color: AppConst.white,)),
                        AppText(txt: 'terms and conditions and our privacy policy', size: 15, color: AppConst.primary,)
                      ],
                    ),
                  ),
                  socialMedia(),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.login),
                    child: Row(
                      children: [
                        Spacer(),
                        AppText(
                          txt: 'Already have an account?',
                          size: 15,
                          color: AppConst.white,
                          weight: FontWeight.w400,
                        ),
                        AppText(
                          txt: 'Sign In',
                          size: 15,
                          color: AppConst.primary,
                          weight: FontWeight.bold,
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
