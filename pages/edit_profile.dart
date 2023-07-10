// ignore_for_file: unused_import, prefer_const_constructors, unused_local_variable

import 'dart:ffi';

import 'package:chatapp/components/items.dart';
import 'package:chatapp/pages/hello_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final int currentProfilePicId;
  const EditPage({super.key, required this.currentProfilePicId});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String name = "";
  final TextEditingController usernameController = TextEditingController();

  int? profilePicIndexEdited;

  Widget pictureByIndex(int index) {
    return GestureDetector(
      onTap: () {
        debugPrint("index is $index");
        setState(() {
          profilePicIndexEdited = index;
        });
        Navigator.of(context).pop();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.33,
        height: MediaQuery.of(context).size.width * 0.33,
        decoration: BoxDecoration(
          // profile pic
          image: DecorationImage(
            image: AssetImage(
              "assets/pic/$index.png",
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
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
                            SizedBox(width: 10),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.arrow_back,
                                    color: Colors.white, size: 30)),
                            SizedBox(width: 10),
                            Text(
                              "Edit Your Profile",
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
                                    GestureDetector(
                                      onTap: () {
                                        debugPrint("yoo");
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ListView.builder(
                                                itemCount: 11,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Center(
                                                    child: Row(
                                                      children: [
                                                        pictureByIndex(
                                                            index * 3),
                                                        pictureByIndex(
                                                            index * 3 + 1),
                                                        pictureByIndex(
                                                            index * 3 + 2),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            });
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              // profile pic
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/pic/${profilePicIndexEdited ?? widget.currentProfilePicId}.png",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(80),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 10,
                                              right: 10,
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Icon(
                                                      Icons.photo_camera))),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: MyTextField(
                                          controller: usernameController,
                                          hintText: "New Username",
                                          obscureText: false,
                                          backgroundColor: Colors.grey.shade200,
                                          radius: 4,
                                          prefixIcon: Icon(Icons.person)),
                                    ),
                                    SizedBox(height: 100),
                                    Container(
                                      height: 60,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (profilePicIndexEdited != null) {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(auth.currentUser!.uid)
                                                .update({
                                              "profile_pic_id":
                                                  profilePicIndexEdited
                                            });
                                            // Navigator.of(context).pop();
                                          }
                                          if (usernameController
                                              .text.isNotEmpty) {
                                            debugPrint(usernameController.text);
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(auth.currentUser!.uid)
                                                .update({
                                              "username":
                                                  usernameController.text
                                            });
                                            // Navigator.of(context).pop();
                                          }
                                          Navigator.of(context).pop();
                                          // FirebaseFirestore.instance
                                          //     .collection('users')
                                          //     .doc(auth.currentUser!.uid)
                                          //     .update({"username": "huj"});
                                        },
                                        child: Center(
                                          child: Text(
                                            "Save",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                              // child: StreamBuilder<DocumentSnapshot>(
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
                              //     Map<String, dynamic> data = snapshot.data!
                              //         .data() as Map<String, dynamic>;
                              //     int profilePicId = data["profile_pic_id"] ?? 6;
                              //     String email = data['email'] ?? "email";
                              //     String username =
                              //         data['username'] ?? "username";
                              //     int messagesSent = data['messages_sent'];

                              //     return Center(
                              //       child: Column(
                              //         children: [
                              //           SizedBox(height: 60),
                              //           GestureDetector(
                              //             onTap: () {
                              //               debugPrint("yoo");
                              //               showDialog(
                              //                   context: context,
                              //                   builder: (context) {
                              //                     return ListView.builder(
                              //                       itemCount: 11,
                              //                       itemBuilder:
                              //                           (BuildContext context,
                              //                               int index) {
                              //                         return Center(
                              //                           child: Row(
                              //                             children: [
                              //                               pictureByIndex(
                              //                                   index * 3),
                              //                               pictureByIndex(
                              //                                   index * 3 + 1),
                              //                               pictureByIndex(
                              //                                   index * 3 + 2),
                              //                             ],
                              //                           ),
                              //                         );
                              //                       },
                              //                     );
                              //                   });
                              //             },
                              //             child: Stack(
                              //               children: [
                              //                 Container(
                              //                   width: 150,
                              //                   height: 150,
                              //                   decoration: BoxDecoration(
                              //                     // profile pic
                              //                     image: DecorationImage(
                              //                       image: AssetImage(
                              //                         "assets/pic/${profilePicIndexEdited ?? profilePicId}.png",
                              //                       ),
                              //                       fit: BoxFit.cover,
                              //                     ),
                              //                     borderRadius: BorderRadius.all(
                              //                       Radius.circular(80),
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 Positioned(
                              //                     bottom: 10,
                              //                     right: 10,
                              //                     child: Container(
                              //                         height: 30,
                              //                         width: 30,
                              //                         decoration: BoxDecoration(
                              //                             color: Colors.white,
                              //                             borderRadius:
                              //                                 BorderRadius.all(
                              //                                     Radius.circular(
                              //                                         20))),
                              //                         child: Icon(
                              //                             Icons.photo_camera))),
                              //               ],
                              //             ),
                              //           ),
                              //           SizedBox(height: 40),
                              //           Padding(
                              //             padding: const EdgeInsets.symmetric(
                              //                 horizontal: 25),
                              //             child: MyTextField(
                              //                 controller: usernameController,
                              //                 hintText: "New Username",
                              //                 obscureText: false,
                              //                 backgroundColor:
                              //                     Colors.grey.shade200,
                              //                 radius: 4,
                              //                 prefixIcon: Icon(Icons.person)),
                              //           ),
                              //           SizedBox(height: 100),
                              //           Container(
                              //             height: 60,
                              //             width: 180,
                              //             decoration: BoxDecoration(
                              //                 color:
                              //                     Theme.of(context).primaryColor,
                              //                 borderRadius: BorderRadius.all(
                              //                     Radius.circular(10))),
                              //             child: GestureDetector(
                              //               onTap: () {
                              //                 if (profilePicIndexEdited != null) {
                              //                   FirebaseFirestore.instance
                              //                       .collection('users')
                              //                       .doc(auth.currentUser!.uid)
                              //                       .update({
                              //                     "profile_pic_id":
                              //                         profilePicIndexEdited
                              //                   });
                              //                   // Navigator.of(context).pop();
                              //                 }
                              //                 if (usernameController
                              //                     .text.isNotEmpty) {
                              //                   debugPrint(
                              //                       usernameController.text);
                              //                   FirebaseFirestore.instance
                              //                       .collection('users')
                              //                       .doc(auth.currentUser!.uid)
                              //                       .update({
                              //                     "username":
                              //                         usernameController.text
                              //                   });
                              //                   // Navigator.of(context).pop();
                              //                 }
                              //                 Navigator.of(context).pop();
                              //                 // FirebaseFirestore.instance
                              //                 //     .collection('users')
                              //                 //     .doc(auth.currentUser!.uid)
                              //                 //     .update({"username": "huj"});
                              //               },
                              //               child: Center(
                              //                 child: Text(
                              //                   "Save",
                              //                   style: TextStyle(
                              //                       fontSize: 30,
                              //                       fontWeight: FontWeight.bold,
                              //                       color: Colors.white),
                              //                 ),
                              //               ),
                              //             ),
                              //           )
                              //         ],
                              //       ),
                              //     );
                              //   },
                              // ),
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

// Widget profilePageContent = CustomScrollView(
//   slivers: [
//     SliverFillRemaining(
//       hasScrollBody: false,
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 120,
//             child: Row(
//               children: [
//                 SizedBox(width: 30),
//                 Text(
//                   "Profile",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 30,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(30),
//                 topRight: Radius.circular(30),
//               ),
//               child: Container(
//                 // height: double.infinity,
//                 // width: double.infinity,
//                 color: Colors.grey.shade100,
//                 child: Center(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 60),
//                       Container(
//                         width: 150,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           // profile pic
//                           image: DecorationImage(
//                             image: AssetImage(
//                               "assets/pic/${2}.png",
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(80),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         "Robert",
//                         // "$name",
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 40),
//                       ElevatedButton(onPressed: () {}, child: Text("yoo"))
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ],
// );
