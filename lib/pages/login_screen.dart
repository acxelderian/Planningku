import 'package:dicoding/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading=false;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    // Use a regular expression to validate email format
    // Here's a basic email format validation pattern, you can customize it as needed
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      String email = _emailController.text;
      String password = _passwordController.text;
      // Add your logic to validate and authenticate the user
      print('Email: $email');
      print('Password: $password');
      setState(() {
        _isLoading=true;
      });
      try {
        final navigator = Navigator.of(context);
        final email = _emailController.text;
        final password = _passwordController.text;
        await _auth.signInWithEmailAndPassword(
            email: email,
            password: password
        );
        // navigator.pushReplacementNamed(ToDoListPage.routeName);
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return HomeScreen();
        }));
      } on Exception catch (e) {
        // TODO
        final snackbar = SnackBar(
          content: AwesomeSnackbarContent(
            title: "Oh no!",
            message: e.toString().split(':').last.trim().split('(').first.trim(),
            contentType: ContentType.failure,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,

        );
        ScaffoldMessenger.of(context)..showSnackBar(snackbar);
      } finally{
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("images/planningku-logo-nobg-black.png",height: 80,width: 80,),
              SizedBox(height: 12,),
              _isLoading?SizedBox(child: const Center(child: CircularProgressIndicator()),height: 54,):SizedBox(child: Container(),height: 54,),
              const SizedBox(height: 12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                  color: Color.fromRGBO(68, 68, 68, 0.05),
                  boxShadow:  [
                    BoxShadow(
                      color: Color.fromRGBO(68, 68, 68, 0.05),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(4,4)
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top:16.0,bottom: 16.0,left: 32.0,right: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Login Into Account',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          helperText: " ",
                        ),
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 8.0,),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        decoration:  InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            helperText: " ",
                            suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _obscureText=!_obscureText;
                                  });
                                  print(_obscureText);
                                },
                                icon: Icon(_obscureText?Icons.remove_red_eye_outlined:Icons.remove_red_eye_rounded)
                            )
                        ),
                        validator: _validatePassword,
                      ),
                      SizedBox(height: 8.0,),
                      MaterialButton(
                        color:Theme.of(context).primaryColor,
                        height: 50,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        onPressed: _login,
                        child: Text('Login',style: TextStyle(color:Colors.white),),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? "),
                          TextButton(
                            onPressed: () {
                              // Navigate to the register page
                              Navigator.pushNamed(context, '/register_screen');
                            },
                            child: Text('Register'),
                          ),
                        ],
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
