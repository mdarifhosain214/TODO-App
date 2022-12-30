import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/pages/homePage.dart';
import 'package:todo/pages/sign_up_page.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool circuler = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              buttonItem(
                  buttonName: 'Continue with google',
                  imagePath: 'images/google.svg',
                  buttonSize: 25),
              const SizedBox(
                height: 15,
              ),
              buttonItem(
                  buttonName: 'Continue with Phone',
                  imagePath: 'images/phone.svg',
                  buttonSize: 25),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'or',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              textItem(labelText: 'Email...',
                  controller: _emailController,
                  obscureText: false
              ),
              const SizedBox(
                height: 15,
              ),
              textItem(labelText: 'Password',
                  controller: _passwordController,
                  obscureText: true),
              const SizedBox(
                height: 30,
              ),
              colorButton(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignUpPage()), (route) => false);
                    },
                    child: const Text(
                      'SingUp',
                      style: TextStyle(fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Forgot password?',
                style: TextStyle(fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: ()async{
          setState((){
            circuler =true;
          });
        try{
          firebase_auth.UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
          setState((){
            circuler =false;
          });
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);

        }catch(e){
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState((){
            circuler =false;
          });
        }
      },
      child: Container(
        height: 60,
        width: MediaQuery
            .of(context)
            .size
            .width - 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c),
            ])),
        child:  Center(
            child:circuler?const CircularProgressIndicator(): const Text(
              'Sign In',
              style: TextStyle(
                  color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  Widget buttonItem({required String imagePath,
    required String buttonName,
    required double buttonSize}) {
    return Container(
      height: 60,
      width: MediaQuery
          .of(context)
          .size
          .width - 60,
      child: Card(
        color: Colors.black,
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(width: 1, color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              height: buttonSize,
              width: buttonSize,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              buttonName,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }

  Widget textItem(
      {required String labelText, required TextEditingController controller, required bool obscureText}) {
    return Container(
      height: 55,
      width: MediaQuery
          .of(context)
          .size
          .width - 70,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white, fontSize: 17),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 1.5, color: Colors.amber)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 1, color: Colors.grey)),
        ),
      ),
    );
  }
}
