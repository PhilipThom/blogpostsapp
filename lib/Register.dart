import 'package:flutter/material.dart';
import 'package:blogposts/LoginRegister.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override

  bool _toggleVisibility=true;
  bool _toggleConfirmVisibility=true;

  Widget _buildEmailTextField(){
    return TextFormField(

      decoration: InputDecoration(
        hintText: "Email",

        hintStyle: TextStyle(
          color: Color(0xFFBDC2BC),
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _buildUsernameTextField(){
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Username",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2BC),
          fontSize: 18.0,
        ),
      ),
    );
  }


  Widget _buildPssTextField(){
    return TextFormField(
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
    );
  }


  Widget _buildConfirmPssTextField(){
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Confirm Password",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2BC),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed:(){
            setState(() {
              _toggleConfirmVisibility=!_toggleConfirmVisibility;
            });
          },
          icon:  _toggleConfirmVisibility?  Icon(Icons.visibility_off):Icon(Icons.visibility),

        ),

      ),
      obscureText: _toggleConfirmVisibility,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Register", style: TextStyle(
              fontSize: 45, fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 70.0,),


            //SizedBox(height: 10.0,),
            Card(
              elevation: 6.5,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    _buildUsernameTextField(),
                    SizedBox(height: 20.0,),
                    _buildEmailTextField(),
                    SizedBox(height: 20.0,),
                    _buildPssTextField(),
                    SizedBox(height: 20.0,),
                    _buildConfirmPssTextField()


                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            Container(
              
              height: 50.0,
              decoration: BoxDecoration(

                color: Colors.green[0xFF399063],
                borderRadius: BorderRadius.circular(25.0),

              ),
              child: Center(
                child: RaisedButton(
                  child: Text("Register", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),),
                ),
              ),

            ),
            Divider(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Already have an account?", style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),),
                SizedBox(width: 10.0,),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Login()));
                  },
                  child: Text("Log In", style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
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
