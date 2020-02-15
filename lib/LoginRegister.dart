import 'package:flutter/material.dart';
import 'package:blogposts/Register.dart';
import 'Authenticate.dart';
import 'package:blogposts/Dialog.dart';

class Login extends StatefulWidget {
  Login({this.auth,this.onSignedIn});
  final AuthenticateImplementation auth;
  final VoidCallback onSignedIn;

  @override
  _LoginState createState() => _LoginState();




}

enum FormType{
  login,register
}

class _LoginState extends State<Login> {
  DialogBox dialogBox=new DialogBox();
  final formKey=new GlobalKey<FormState>();
  FormType _formType=FormType.login;
  String _email="";
  String _password="";
  bool _toggleVisibility=true;

  //Validation Methods
  bool  validateAndSave(){
    final form =formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }

  }
  void ValidateAndSend()async{
    if(validateAndSave()){
      try{
        String userId= await widget.auth.SignIn(_email,_password);
        //dialogBox.information(context, "Hello thre", "Successfulll LoggedIn");
        print("User id"+ userId);
        widget.onSignedIn();

      }catch (e){
        dialogBox.information(context,"Error" , e.toString());
        print("Error = "+ e.toString());
      }

    }

  }
  void moveToRegister(){
    formKey.currentState.reset();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>Register()));
    setState(() {
      _formType=FormType.register;
    });

  }

//  Widget _buildEmailTextField(){
//    return Form(
//        child:TextFormField(
//              // The validator receives the text that the user has entered.
//              validator: (value) {
//                if (value.isEmpty) {
//                  return 'Please enter some text';
//                }
//                return null;
//              },
//
//
////      key: formKey,
////      validator: (value){
////        return value.isEmpty ? 'Email is required' :null;
////      },
//      onSaved: (value){
//
//        return _email=value;
//      },
//      decoration: InputDecoration(
//        hintText: "Email or username",
//        hintStyle: TextStyle(
//          color: Color(0xFFBDC2BC),
//          fontSize: 18.0,
//        ),
//      ),
//        )
//    );
//  }
//  Widget _buildPssTextField(){
//    return Form(
//      child: TextFormField(
//        validator: (value) {
//          if (value.isEmpty) {
//            return 'Please enter some text';
//          }
//          return null;
//        },
//////      key: formKey,
////        validator: (value){
////          return value.isEmpty ? 'Password is required' :null;
////        },
//        onSaved: (value){
//          return _password=value;
//        },
//        decoration: InputDecoration(
//          hintText: "Password",
//          hintStyle: TextStyle(
//            color: Color(0xFFBDC2BC),
//            fontSize: 18.0,
//          ),
//          suffixIcon: IconButton(
//            onPressed:(){
//              setState(() {
//                _toggleVisibility=!_toggleVisibility;
//              });
//            },
//            icon:_toggleVisibility ?  Icon(Icons.visibility_off):Icon(Icons.visibility),
//
//          ),
//
//        ),
//        obscureText: _toggleVisibility,
//      ),
//    );
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Login In",style: TextStyle(
              fontSize: 45,fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 100.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                Text("Forgott Password",style: TextStyle(
                  fontSize: 18.0,color: Colors.deepOrange,fontWeight: FontWeight.bold,
                ),),
              ],
            ),
            SizedBox(height: 10.0,),

               Form(
                 key: formKey,
                 child: Card(

                  elevation: 9.0,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        //_buildEmailTextField(),

                        TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },


//      key: formKey,
//      validator: (value){
//        return value.isEmpty ? 'Email is required' :null;
//      },
                          onSaved: (value){

                            return _email=value;
                          },
                          decoration: InputDecoration(
                            hintText: "Email or username",
                            hintStyle: TextStyle(
                              color: Color(0xFFBDC2BC),
                              fontSize: 18.0,
                            ),
                          ),
                        ),



                        SizedBox(height: 20.0,),

                         TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
////      key: formKey,
//        validator: (value){
//          return value.isEmpty ? 'Password is required' :null;
//        },
                          onSaved: (value){
                            return _password=value;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Color(0xFFBDC2BC),
                              fontSize: 18.0,
                            ),
                            suffixIcon: IconButton(
                              onPressed:(){
                                setState(() {
                                  _toggleVisibility=!_toggleVisibility;
                                });
                              },
                              icon:_toggleVisibility ?  Icon(Icons.visibility_off):Icon(Icons.visibility),

                            ),

                          ),
                          obscureText: _toggleVisibility,
                        ),

                        SizedBox(height: 30.0,),
                        Container(

                          height: 50.0,
                          decoration: BoxDecoration(

                            color: Colors.green[0xFF399063],
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Center(
                            child: RaisedButton(child: Text("Log In",style: TextStyle(color: Colors.grey,fontSize: 18.0,fontWeight: FontWeight.bold),), onPressed: () {ValidateAndSend();},),
                          ),

                        ),


                        //_buildPssTextField(),


                      ],
                    ),
                  ),
              ),
               ),

//            SizedBox(height: 30.0,),
//            Container(
//
//              height: 50.0,
//              decoration: BoxDecoration(
//
//                color: Colors.green[0xFF399063],
//                borderRadius: BorderRadius.circular(25.0),
//              ),
//              child: Center(
//                child: RaisedButton(child: Text("Log In",style: TextStyle(color: Colors.grey,fontSize: 18.0,fontWeight: FontWeight.bold),), onPressed: () {validateAndSave();},),
//              ),
//
//            ),
            Divider(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account?",style: TextStyle(
                    color: Colors.grey,fontSize: 18.0,fontWeight: FontWeight.bold),),
                SizedBox(width: 10.0,),
                InkWell(
                  onTap: (){
                    moveToRegister();
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>Register()));

                  },
                  child: Text("Register",style: TextStyle(
                      color: Colors.deepOrange,fontSize: 18.0,fontWeight: FontWeight.bold
                  ),),

                ),
              ],
            ),
          ],

        ),
      ),
    );
  }
}



