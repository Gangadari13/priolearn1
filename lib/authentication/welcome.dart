import 'package:flutter/material.dart';
import 'package:group_13_priolearn/pages/login.dart';
import 'package:group_13_priolearn/pages/sign_up.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                textAlign: TextAlign.center,
                "Welcome to \nPrioLearn",
                style: TextStyle(color: Colors.black, fontSize:40 
                ),
              ),
              const SizedBox(height: 250,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.6,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text("Sign Up", style: TextStyle(fontSize: 20, color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.6,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> Login()));
                  },
                  child: Text("Log In",style: TextStyle(fontSize: 20, color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}