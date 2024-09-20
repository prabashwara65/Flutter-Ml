// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/widgets.dart';
// import '../auth.dart';

// class LoginPage extends StatefulWidget {

//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();

// }

// class _LoginPageState extends State<LoginPage>{
//   String? errorMessage = " ";
//   bool isLogin = true;

//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();

//   //this future for check email and password being signing 
//   Future<void> signInWithEmailAndPassword() async {
//     try{
//       await Auth().signInWithEmailAndPassword(
//         email: _controllerEmail.text, 
//         password: _controllerPassword.text,
//       );
//     }on FirebaseAuthException catch(e){
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   //This future using for create new user in firebase
//   Future<void> createUserWithEmailAndPassword() async {
//     try{
//        await Auth().createUserWithEmailAndPassword(
//         email: _controllerEmail.text, 
//         password: _controllerPassword.text,
//         );
//     } on FirebaseAuthException catch(e){
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   //this for title
//   Widget _title(){
//     return const Text('Firebase Auth');
//   }

//   Widget _entryField(
//     String title,
//     TextEditingController controller,
//   ){
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: title 
//         ),
//     );
//   }

//   //Error Messge
//   Widget _errorMsg(){
//     return Text(errorMessage == '' ? '' :  'Humm ? $errorMessage');
//   }

//   Widget _submitButton(){
//     return ElevatedButton(
//       onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword, 
//       child: Text(isLogin ? 'Login' : 'Register'),
//       );
//   }

//   Widget _loginOrRegisterButton(){
//     return TextButton(
//       onPressed: () {
//         setState(() {
//           isLogin = !isLogin;
//         });
//       }, 
//       child: Text(isLogin ? 'Register instead' : 'Login instead'),
//       );
//   }

//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: _title(),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _entryField('email', _controllerEmail),
//             _entryField('password', _controllerPassword),
//             _errorMsg(),
//             _submitButton(),
//             _loginOrRegisterButton(),
//           ],
//           ),
//         ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = "";
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text(
      'Firebase Auth',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(color: Colors.white70),
          fillColor: Colors.white.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        style: const TextStyle(color: Colors.white),
        obscureText: title == 'password', // Hide password
      ),
    );
  }

  Widget _errorMsg() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        errorMessage == '' ? '' : 'Humm ? $errorMessage',
        style: const TextStyle(color: Colors.red, fontSize: 14),
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal, // Use backgroundColor instead of primary
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      ),
      child: Text(
        isLogin ? 'Login' : 'Register',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white, // Use foregroundColor instead of primary
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: Text(
        isLogin ? 'Register instead' : 'Login instead',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: _title(),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _entryField('Email', _controllerEmail),
                _entryField('Password', _controllerPassword),
                _errorMsg(),
                const SizedBox(height: 20),
                _submitButton(),
                const SizedBox(height: 20),
                _loginOrRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
