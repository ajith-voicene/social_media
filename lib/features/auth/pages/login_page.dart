import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/features/auth/bloc/social%20login/social_login_cubit.dart';
import 'package:social_media/features/Timeline/pages/timeline.dart';
import 'package:social_media/utils/alerts.dart';
import 'package:social_media/utils/constants.dart';

import '../../../CustomAppBar.dart';

class LoginPage extends StatefulWidget {
  @override
  _State createState() {
    return new _State();
  }
}

class _State extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isLoggedIn = false;
  bool isLoading = false;
  Map fbUser;
  String provider = " ", deviceName = " ", tokenss = " ";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: PreferredSize(
            child: ClipPath(
              clipper: CustomAppBar(),
              child: Container(
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Builder(
                      builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Social Media',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight + 50)),
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocProvider<SocialLoginCubit>(
              create: (context) => SocialLoginCubit(),
              child: Builder(
                builder: (context) =>
                    BlocConsumer<SocialLoginCubit, SocialLoginState>(
                  listener: (context, state) {
                    if (state is SocialLoginSuccess) {
                      if (state.success) {
                        Alerts.showToast("Succesfully logged In");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TimeLine(),
                            ));
                      } else {
                        Alerts.showErrorToast("Login Failed, Try again");
                      }
                    }
                    if (state is SocialLoginError) {
                      Alerts.showErrorToast("Login Failed, Try again");
                    }
                  },
                  builder: (context, state) {
                    if (state is SocialLoginLoading)
                      return CommonFullProgressIndicator();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          onTap: () async {
                            final LoginResult result =
                                await FacebookAuth.instance.login(permissions: [
                              'public_profile',
                              'email',
                            ]).then((value) async {
                              if (value != null)
                                fbUser =
                                    await FacebookAuth.instance.getUserData();
                              return value;
                            });

                            switch (result.status) {
                              case LoginStatus.failed:
                                break;

                              case LoginStatus.success:
                                Constant.name = fbUser['name'];
                                Constant.email = fbUser['email'];
                                Constant.photoUrl =
                                    fbUser['picture']['data']['url'];
                                Constant.provider = "facebook";
                                context
                                    .read<SocialLoginCubit>()
                                    .login(result.accessToken.token);

                                break;
                              case LoginStatus.cancelled:
                                break;
                              case LoginStatus.operationInProgress:
                                break;
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          leading: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Image.asset(
                              'images/agro_fb.jpg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          tileColor: Colors.blueAccent,
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Text(
                              "Connect with Facebook",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          onTap: () async {
                            GoogleSignInAuthentication
                                googleSignInAuthentication;
                            GoogleSignInAccount googleSignInAccount;
                            try {
                              googleSignInAccount = await googleSignIn.signIn();
                            } catch (error) {
                              print(error);
                            }
                            if (googleSignInAccount != null) {
                              googleSignInAuthentication =
                                  await googleSignInAccount.authentication;

                              Constant.name = googleSignInAccount.displayName;
                              Constant.email = googleSignInAccount.email;
                              Constant.photoUrl = googleSignInAccount.photoUrl;
                              Constant.provider = "google";
                              context.read<SocialLoginCubit>().login(
                                  googleSignInAuthentication.accessToken);
                            }
                          },
                          tileColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          leading: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Image.asset(
                              'images/google.jpg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Text(
                              "Connect with Google",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // CommonButton(label: "signout",onPressed: ()async{
                        //   signOutGoogle();
                        //   // fbLogin.logOut();
                        //    await FacebookAuth.instance.logOut().then((value) {

                        //      Alerts.showToast("logot");} );
                        // },),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    );
                  },
                ),
              ),
            )));
  }
}
