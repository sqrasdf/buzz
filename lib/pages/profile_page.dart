// ignore_for_file: unused_import, prefer_const_constructors, unused_local_variable, non_constant_identifier_names

import 'package:chatapp/components/items.dart';
import 'package:chatapp/pages/edit_profile.dart';
import 'package:chatapp/pages/hello_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String name = "";

  int current_profile_id = 0;

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();

    String uid = auth.currentUser!.uid;
    final doc = FirebaseFirestore.instance.collection("users").doc(uid);
    doc.get().then((doc) {
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        current_profile_id = data['profile_pic_id'];
      });
    });
  }

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const HelloPage(),
      ),
    );
  }

  void read() {
    String uid = auth.currentUser!.uid;
    final doc = FirebaseFirestore.instance.collection("users").doc(uid);
    doc.get().then((doc) {
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        name = data['email'];
      });
    });
    // Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // doc.get("email")
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              // height: double.infinity,
              // width: double.infinity,
              decoration: BoxDecoration(
                // color: Colors.blueAccent,
                color: Theme.of(context).primaryColor,
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 120,
                        child: Row(
                          children: [
                            SizedBox(width: 30),
                            Text(
                              "Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                              icon: Icon(Icons.edit,
                                  size: 28, color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditPage(
                                        currentProfilePicId:
                                            current_profile_id)));
                              },
                            ),
                            SizedBox(width: 25),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Container(
                            // height: double.infinity,
                            // width: double.infinity,
                            color: Colors.grey.shade100,
                            child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(auth.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Error!");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                int profilePicId = data["profile_pic_id"] ?? 6;
                                String email = data['email'] ?? "email";
                                String username =
                                    data['username'] ?? "username";
                                int messagesSent = data['messages_sent'];
                                // setState(() {

                                // });
                                current_profile_id = data["profile_pic_id"];

                                return Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 60),
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          // profile pic
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/pic/$profilePicId.png",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(80),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 40),
                                      Text(
                                        // "Robert",
                                        username,
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 60),
                                      Text(
                                        // "Robert",
                                        "messages sent: ${messagesSent.toString()}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      ElevatedButton(
                                          onPressed: signOut,
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                            textStyle:
                                                MaterialStateProperty.all(
                                                    TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )),
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    const Size(200, 40)),
                                          ),
                                          child: Text("Sign Out")),
                                      SizedBox(height: 40),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      // StreamBuilder<DocumentSnapshot>(
                      //   stream: FirebaseFirestore.instance
                      //       .collection('users')
                      //       .doc(auth.currentUser!.uid)
                      //       .snapshots(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasError) {
                      //       return const Text("Error!");
                      //     }
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return const Center(
                      //           child: CircularProgressIndicator());
                      //     }
                      //     return Center(
                      //       child: Column(
                      //         children: [
                      //           SizedBox(height: 60),
                      //           Container(
                      //             width: 150,
                      //             height: 150,
                      //             decoration: BoxDecoration(
                      //               // profile pic
                      //               image: DecorationImage(
                      //                 image: AssetImage(
                      //                   "assets/pic/${2}.png",
                      //                 ),
                      //                 fit: BoxFit.cover,
                      //               ),
                      //               borderRadius: BorderRadius.all(
                      //                 Radius.circular(80),
                      //               ),
                      //             ),
                      //           ),
                      //           SizedBox(height: 40),
                      //           Text(
                      //             // "Robert",
                      //             name,
                      //             style: TextStyle(
                      //               fontSize: 28,
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                      //           SizedBox(height: 40),
                      //           ElevatedButton(
                      //               onPressed: read, child: Text("yoo"))
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

Widget profilePageContent = CustomScrollView(
  slivers: [
    SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          const SizedBox(
            height: 120,
            child: Row(
              children: [
                SizedBox(width: 30),
                Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                // height: double.infinity,
                // width: double.infinity,
                color: Colors.grey.shade100,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          // profile pic
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/pic/${2}.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(80),
                          ),
                        ),
                      ),
                      Text(
                        "Robert",
                        // "$name",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(onPressed: () {}, child: Text("yoo"))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
);
