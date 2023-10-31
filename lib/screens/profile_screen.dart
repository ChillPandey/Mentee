import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mento/api/apis.dart';

import 'package:mento/helpers/dialogs.dart';
import 'package:mento/main.dart';
import 'package:mento/models/chat_user.dart';
import 'package:mento/screens/auth/login_page.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile Screen"),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              Dialogs.showProgressNar(context);
              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginPage()));
                });
              });
            },
            icon: const Icon(Icons.logout),
            label: const Text('Log Out'),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  width: mq.width,
                  height: mq.height * .03,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .1),
                      child: CachedNetworkImage(
                        width: mq.height * .2,
                        height: mq.height * .2,
                        fit: BoxFit.fill,
                        imageUrl: widget.user.image,
                        errorWidget: (context, url, error) =>
                            const Icon(CupertinoIcons.person),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: MaterialButton(
                        elevation: 1,
                        onPressed: () {},
                        shape: const CircleBorder(),
                        color: Colors.white,
                        child: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: mq.height * .03),
                Text(
                  widget.user.email,
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                ),
                SizedBox(height: mq.height * .05),
                TextFormField(
                  initialValue: widget.user.name,
                  onSaved: (val) => APIs.me.name = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'eg: Happy Singh',
                      label: const Text("Name")),
                ),
                SizedBox(height: mq.height * .02),
                TextFormField(
                  initialValue: widget.user.about,
                  onSaved: (val) => APIs.me.about = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'eg: Feeling awesome',
                      label: const Text("About")),
                ),
                SizedBox(height: mq.height * .05),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: Size(mq.width * .4, mq.height * .055)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(context, "Updated");
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.login,
                      size: 23,
                    ),
                    label: const Text(
                      'Update',
                      style: TextStyle(fontSize: 16),
                    ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
