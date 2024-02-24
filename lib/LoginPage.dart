
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'RegisterPage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final maxWidth = deviceWidth > 600 ? 600.0 : deviceWidth * 0.95; // Define a maximum width for the content

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Faculty Reviews',
            style: TextStyle(
              color: const Color(0xff700f1a),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontFamily: GoogleFonts.spaceMono().fontFamily,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                width: maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.asset(
                        'assets/images/ibalogo.png',
                        width: deviceWidth > 600 ? 600 : deviceWidth * 0.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Erp or Email",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff700f1a), width: 5,),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.spaceMono().fontFamily,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: "Enter your Password",
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff700f1a), width: 5,),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.spaceMono().fontFamily,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff700f1a),
                                padding: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton (onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },

                      child: const Text
                        ('Register?', style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),),

                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Dev by: Zohaib Mughal',
                style: TextStyle(
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xffffffff),
    );
  }
}
