import 'package:dicoding/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register_screen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

  void _register() async {
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
        await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        navigator.pop();
      } on Exception catch (e) {
        // TODO
        final snackbar = SnackBar(
          content: Text(
            e.toString()
          ),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 3),
          shape: StadiumBorder(),
          // margin: EdgeInsets.symmetric(vertical: 16,horizontal: 12),
          elevation: 0,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
        title: Text('Register Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                          'Register',
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
                        onPressed: _register,
                        child: Text('Register',style: TextStyle(color:Colors.white),),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              // Navigate to the register page
                              Navigator.pop(context);
                            },
                            child: Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12,),
              _isLoading?SizedBox(child: const Center(child: CircularProgressIndicator()),height: 54,):SizedBox(child: Container(),height: 54,),
              const SizedBox(height: 12),
              Image.asset("images/planningku-logo-nobg-black.png",height: 80,width: 80,),
            ],
          ),
        ),
      ),
    );
  }
}
