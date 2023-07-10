// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:chatapp/components/items.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/hello_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  // sign out
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const HelloPage(),
      ),
    );

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage("assets/bg2.jpg"),
                //   fit: BoxFit.fill,
                // ),
                color: Theme.of(context).primaryColor,
                // gradient: LinearGradient(
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                //   colors: [
                //     Colors.blue,
                //     Colors.red,
                //   ],
                // ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                    height: 120,
                    child: Row(children: [
                      const SizedBox(width: 30),
                      const Text("Chats",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                      Expanded(child: Container()),
                      IconButton(
                          onPressed: signOut,
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          )),
                      const SizedBox(width: 15)
                    ])),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Container(
                      // height: double.maxFinite,
                      // width: double.maxFinite,
                      // color: Colors.grey.shade100,
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: MyTextField(
                              controller: _controller,
                              hintText: "Find friends",
                              obscureText: false,
                              backgroundColor:
                                  const Color.fromARGB(255, 234, 244, 255),
                              radius: 10,
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
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
                                return ListView(
                                  children: snapshot.data!.docs
                                      .map<Widget>(
                                          (doc) => _buildUserListItem(doc))
                                      .toList(),
                                );
                              },
                            ),
                          ),

                          // Expanded(
                          //   child: ListView.builder(
                          //     itemCount: 25,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 15, vertical: 5),
                          //         child: Row(
                          //           children: [
                          //             // CircleAvatar(
                          //             //   backgroundImage: AssetImage(
                          //             //       "assets/pic/${index + 1}.png"),
                          //             //   radius: 32,
                          //             // ),
                          //             Container(
                          //               width: 64,
                          //               height: 64,
                          //               decoration: BoxDecoration(
                          //                 image: DecorationImage(
                          //                   image: AssetImage(
                          //                     // "assets/pic/${index + 1}.png",
                          //                     "assets/pic/${Random().nextInt(37) + 1}.png",
                          //                   ),
                          //                 ),
                          //                 borderRadius: BorderRadius.all(
                          //                   Radius.circular(32),
                          //                 ),
                          //                 // color: Colors.amber,
                          //                 // boxShadow: [
                          //                 //   Random().nextInt(3) % 3 == 0
                          //                 //       ? BoxShadow(
                          //                 //           color: Color.fromARGB(
                          //                 //               180, 0, 180, 0),
                          //                 //           spreadRadius: 2,
                          //                 //           blurRadius: 4,
                          //                 //           // offset: Offset(0, 3),
                          //                 //         )
                          //                 //       : BoxShadow(),
                          //                 // ],
                          //               ),
                          //             ),
                          //             SizedBox(width: 20),
                          //             Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 Text(
                          //                   "Robert Lewandowski",
                          //                   style: TextStyle(
                          //                       fontWeight: FontWeight.bold,
                          //                       fontSize: 17),
                          //                 ),
                          //                 SizedBox(height: 4),
                          //                 Text(
                          //                   "some message",
                          //                   style: TextStyle(fontSize: 15),
                          //                 ),
                          //               ],
                          //             )
                          //           ],
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // CustomScrollView(slivers: [
            //   SliverFillRemaining(
            //     hasScrollBody: false,
            //     child: Column(
            //       children: [
            //         const SizedBox(
            //           height: 120,
            //           child: Row(
            //             children: [
            //               SizedBox(width: 30),
            //               Text(
            //                 "Chats",
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 30,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Expanded(
            //           child: ClipRRect(
            //             borderRadius: const BorderRadius.only(
            //               topLeft: Radius.circular(50),
            //               topRight: Radius.circular(50),
            //             ),
            //             child: Container(
            //               color: Colors.grey.shade200,
            //               child: Expanded(child: _buildUserList()),
            //               // child: Expanded(
            //               //   child: Column(
            //               //     children: [
            //               //       Expanded(child: _buildUserList()),
            //               //     ],
            //               //   ),
            //               // ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ]),
          ],
        ),
      );

  // list of users except for the current one
  // Widget _buildUserList() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance.collection('users').snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return const Text("Error!");
  //       }
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const CircularProgressIndicator();
  //       }

  //       return ListView(
  //         children: snapshot.data!.docs
  //             .map<Widget>((doc) => _buildUserListItem(doc))
  //             .toList(),
  //       );
  //     },
  //   );
  // }

  // build user list items
  // Widget _buildUserListItem(DocumentSnapshot document) {
  //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

  //   // display all users except for the current one
  //   if (_auth.currentUser!.email != data["email"]) {
  //     return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: ListTile(
  //         tileColor: Colors.pink,
  //         focusColor: Colors.pink,
  //         leading: const CircleAvatar(
  //           backgroundColor: Colors.lightBlueAccent,
  //           radius: 30,
  //         ),
  //         title: Text(data["email"]),
  //         subtitle: const Text("some message"),
  //         onTap: () {
  //           // go to chat page
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: ((context) => ChatPage(
  //                       recieverUserEmail: data["email"],
  //                       recieverUserID: data["uid"]))));
  //         },
  //       ),
  //     );
  //   }
  //   // otherwise return empty container
  //   else {
  //     return Container();
  //   }
  // }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all users except for the current one
    if (_auth.currentUser!.email != data["email"]) {
      return GestureDetector(
        onTap: () {
          // go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ChatPage(
                      recieverUserEmail: data["email"],
                      recieverUserID: data["uid"],
                      receiverProfilePicId: data["profile_pic_id"],
                      receiverUsername: data["username"])))).whenComplete(() =>
              SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.immersiveSticky));
        },
        child: Container(
          height: 80,
          width: double.infinity,
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  // profile pic
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      // "assets/pic/${index + 1}.png",
                      // "assets/pic/${Random().nextInt(37) + 1}.png",
                      "assets/pic/${data["profile_pic_id"]}.png",
                    ),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(32),
                  ),
                  // color: Colors.amber,
                  // boxShadow: [
                  //   Random().nextInt(3) % 3 == 0
                  //       ? BoxShadow(
                  //           color: Color.fromARGB(180, 0, 180, 0),
                  //           spreadRadius: 2,
                  //           blurRadius: 4,
                  //           // offset: Offset(0, 3),
                  //         )
                  //       : BoxShadow(),
                  // ],
                ),
              ),
              SizedBox(width: 20),
              // name and message
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     // Expanded(
              //     //   child: Text(
              //     //     "${data["username"] ?? data["email"]}",
              //     //     style: TextStyle(
              //     //       fontWeight: FontWeight.bold,
              //     //       fontSize: 17,
              //     //       overflow: TextOverflow.ellipsis,
              //     //     ),
              //     //   ),
              //     // ),
              //     SizedBox(height: 4),

              //     // Text(
              //     //   // "some message",
              //     //   "yoo",
              //     //   style: TextStyle(fontSize: 15),
              //     // ),
              //   ],
              // ),
              Expanded(
                child: Text(
                  "${data["username"] ?? data["email"]}",
                  style: TextStyle(
                    overflow: TextOverflow.fade,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              // fill
              // Expanded(child: Container()),
              // time of the message
              Text(
                "11:34",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  // color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }
    // otherwise return empty container
    else {
      return Container();
    }
  }
}
