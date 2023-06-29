import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register_screen";

  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
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
          duration: const Duration(seconds: 3),
          shape: const StadiumBorder(),
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
        title: Image.asset("images/planningku-logo-nobg-black.png", width: 80,),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                    color: const Color.fromRGBO(68, 68, 68, 0.05),
                    boxShadow:  const [
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
                        const Align(
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
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            helperText: " ",
                          ),
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 8.0,),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          decoration:  InputDecoration(
                              labelText: "Password",
                              border: const OutlineInputBorder(),
                              helperText: " ",
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _obscureText=!_obscureText;
                                    });
                                  },
                                  icon: Icon(_obscureText?Icons.remove_red_eye_outlined:Icons.remove_red_eye_rounded)
                              )
                          ),
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 8.0,),
                        MaterialButton(
                          color: Colors.blueGrey,
                          height: 50,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          onPressed: _register,
                          child: const Text('Register',style: TextStyle(color:Colors.white),),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? "),
                            TextButton(
                              onPressed: () {
                                // Navigate to the register page
                                Navigator.pop(context);
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                _isLoading?const SizedBox(height: 54,child: Center(child: CircularProgressIndicator()),):SizedBox(height: 54,child: Container(),),
                const SizedBox(height: 12),
                Image.asset("images/planningku-logo-nobg-black.png",height: 80,width: 80,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
