import 'dart:io';

import 'package:chat/widgets/auth/text_form_field_style.dart';
import 'package:flutter/material.dart';

import '../../themes.dart';
import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,File? image,
      bool isLoading, BuildContext ctx) submitAuthForm;
  final bool _isLoadingBotton;

  AuthForm(this.submitAuthForm,this._isLoadingBotton);

  @override
  State<AuthForm> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthForm> {
  final _keyForm = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String userName = '';
  bool _isLoading = false;
  bool isVisbility = true;
  File? currentPickedImage;

  void _pickedImage(File image){
   currentPickedImage=image;
  }

  void _submit() {
    final isValidate = _keyForm.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(_isLoading==true&&currentPickedImage==null){
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('please pick an image'),
        backgroundColor: Colors.red,
      )
      );
    }
    if (isValidate) {
      _keyForm.currentState!.save();
      widget.submitAuthForm(
          email.trim(), password.trim(), userName.trim(),currentPickedImage, _isLoading, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: drunkenColor,
      body:
          Center(
          child: Card(
            elevation: 10,
            color: Colors.white,
            margin:const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                  ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: _keyForm,

                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  if(_isLoading)
                                    ImagePickerUser(_pickedImage,),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  if(!_isLoading)
                                    Image.asset('images/account.png'),
                                  const SizedBox(height: 10,),
                                  StyleTextFormField(

                                    obscure: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Email';
                                      } else if (!value.contains('@')) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                    textInputType: TextInputType.emailAddress,
                                    hintText: 'Enter Email',
                                    icon: const Icon(
                                      Icons.email_outlined,
                                      color: bronColor,
                                    ),
                                    onSaved: (val) {
                                      email = val;
                                    },
                                    key: const ValueKey('email'),
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    textCapitalization: TextCapitalization.none,

                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  if (_isLoading)
                                    StyleTextFormField(
                                      obscure: false,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter Username';
                                        } else if (value.length < 2) {
                                          return 'Please enter at least 4 letters';
                                        }
                                        return null;
                                      },
                                      textInputType: TextInputType.text,
                                      hintText: 'Enter Username',
                                      icon: const Icon(
                                        Icons.person_2_outlined,
                                        color: bronColor,
                                      ),
                                      onSaved: (val) {
                                        userName = val;
                                      },
                                      key: const ValueKey('username'),
                                      autocorrect: true,
                                      enableSuggestions: true,
                                      textCapitalization: TextCapitalization.words,
                                    ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  StyleTextFormField(
                                    obscure: isVisbility,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Password';
                                      } else if (value.length < 5) {
                                        return 'Please, the password must contain six characters';
                                      }
                                      return null;
                                    },
                                    textInputType: TextInputType.visiblePassword,
                                    hintText: 'Enter Password',
                                    icon: IconButton(
                                      icon: Icon(
                                        isVisbility
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: bronColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isVisbility = !isVisbility;
                                        });
                                      },
                                    ),
                                    onSaved: (val) {
                                      password = val;
                                    },
                                    key: const ValueKey('password'),
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    textCapitalization: TextCapitalization.words,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  if(widget._isLoadingBotton)
                                    const CircularProgressIndicator(color: blueBlackColor,),
                                  if(!widget._isLoadingBotton)
                                  SizedBox(
                                    height: 50,
                                    width: 150,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(
                                            blueBlackColor,
                                          ),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          )),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.all(13)),
                                        ),
                                        onPressed: _submit,
                                        child: Text(
                                          _isLoading ? "SingUp" : "SingIn",
                                          style: const TextStyle(fontSize: 19),
                                        )),
                                  ),
                                  if(!widget._isLoadingBotton)
                                  TextButton(
                                      style: ButtonStyle(
                                          textStyle: MaterialStateProperty.all(
                                        const TextStyle(color: bronColor, fontSize: 15),
                                      )),
                                      onPressed: () {
                                        setState(() {
                                          _isLoading = !_isLoading;
                                        });
                                      },
                                      child: Text(
                                        _isLoading
                                            ? 'I already have an account '
                                            : 'Create new account ',
                                        style: const TextStyle(
                                            color: bronColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      )),

    ]),
                            ),
                          ),
                        )
                      ),
                    ),
                  




      );
  }
}
