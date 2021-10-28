import 'package:flutter/material.dart';
import 'package:quickmart/api_service.dart';
import 'package:quickmart/models/customermodel.dart';
import 'package:quickmart/utils/form_helper.dart';
import 'package:quickmart/utils/progressHUD.dart';
import 'package:quickmart/utils/validator_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  APIService? apiService;
  CustomerModel? model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
    apiService = APIService();
    model = CustomerModel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: true,
        title: Text("Sign Up"),
      ),
      body: ProgressHUD(
        child: Form(
          key: globalKey,
          child: _formUI(),
        ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FormHelper.fieldLabel("First Name"),
                FormHelper.textInput(
                  context,
                  // edited type from object to string?
                  model?.firstName,
                  (value) => {
                    this.model?.firstName = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return "Please enter your First Name";
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Last Name"),
                FormHelper.textInput(
                  context,
                  // edited type from object to string?
                  model?.lastName,
                  (value) => {
                    this.model?.lastName = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return "Please enter your Last Name";
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Email"),
                FormHelper.textInput(
                  context,
                  // edited type from object to string?
                  model?.email,
                  (value) => {
                    this.model?.email = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty &&
                        !value.toString().isValidEmail()) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Password"),
                FormHelper.textInput(
                    context,
                    // edited type from object to string?
                    model?.password,
                    (value) => {
                          this.model?.password = value,
                        }, onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
                    obscureText: hidePassword,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility))),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FormHelper.saveButton("Register", () {
                    if (validateAndSave()) {
                      print(model?.toJson());
                      setState(() {
                        isApiCallProcess = true;
                      });
                      apiService!.createCustomer(model).then((ret) {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (ret) {
                          FormHelper.showMessage(context, "Woocommerce App",
                              "Registration Successfull", "Ok", () {
                            Navigator.of(context).pop();
                          });
                        } else {
                          FormHelper.showMessage(context, "Woocommerce App",
                              "Email is already registered", "Ok", () {
                            Navigator.of(context).pop();
                          });
                        }
                      });
                    }
                  }),
                )
              ],
            ),
          ),
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
