import 'package:flutter/material.dart';
import 'package:quickmart/utils/form_helper.dart';
import 'package:quickmart/utils/progressHUD.dart';
import 'package:quickmart/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  String? username;
  String? password;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  APIService? apiService;

  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => username = input,
                          validator: (input) => !input!.contains('@')
                              ? "Email id is not valid"
                              : null,
                          decoration: InputDecoration(
                              hintText: "Email Address",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).backgroundColor)),
                              prefixIcon: Icon(
                                Icons.email,
                                //color: Theme.of(context).accentColor,
                              )),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => password = input,
                            validator: (input) => input!.length < 3
                                ? "Password should be more than 3 charactor"
                                : null,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).backgroundColor)),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).backgroundColor,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  color: Theme.of(context)
                                      .backgroundColor
                                      .withOpacity(0.4),
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                            )),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).backgroundColor),
                                shape:
                                    MaterialStateProperty.all(StadiumBorder())),
                            onPressed: () {
                              if (validateAndSave()) {
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                apiService
                                    ?.loginCustomer(username, password)
                                    .then((ret) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  if (ret != null) {
                                    FormHelper.showMessage(
                                        context,
                                        "WooCommerce App",
                                        "Login Success",
                                        "Ok", () {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    setState(() {
                                      isApiCallProcess = false;
                                    });
                                    FormHelper.showMessage(
                                        context,
                                        "WooCommerce App",
                                        "Invalid Login",
                                        "Ok", () {
                                      Navigator.pop(context);
                                    });
                                  }
                                });
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 15)
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
