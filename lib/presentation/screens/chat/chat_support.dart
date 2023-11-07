import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/domain/entities/chat.dart';
import 'package:waste_management/presentation/widgets/backbutton.dart';
import 'package:waste_management/presentation/widgets/message_bubble_admin.dart';
import 'package:waste_management/presentation/widgets/message_bubble_user.dart';

class ChatSupport extends StatelessWidget {
  ChatSupport({super.key});

  final chatcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB2E6B5),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: BackButtonCustomMade(),
              ),
              sizedBoxW30,
              Text(
                "Chat Support",
                style: primaryfont(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff44ADA8), Color(0xffC3EFB7)],
            stops: [0.1, 0.9],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List<Message>>(
            future: allMessages(),
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Some Error Occured"),
                );
              }

              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                        child: !snapshot.data!.isEmpty
                            ? GroupedListView<Message, DateTime>(
                                reverse: true,
                                order: GroupedListOrder.DESC,
                                useStickyGroupSeparators: true,
                                floatingHeader: true,
                                elements: snapshot.data!,
                                groupBy: (element) {
                                  return DateTime(
                                      element.dateTime.year,
                                      element.dateTime.month,
                                      element.dateTime.day);
                                },
                                groupHeaderBuilder: (Message element) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      DateFormat.yMMMEd()
                                          .format(element.dateTime),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    ),
                                  );
                                },
                                itemBuilder: (context, element) {
                                  return element.isSentByMe
                                      ? MessageBubbleUser(
                                          message: element.text,
                                          date: element.dateTime,
                                        )
                                      : MessageBubbleAdmin(
                                          message: element.text,
                                          date: element.dateTime);
                                },
                              )
                            : Center(
                                child: Text(
                                "There are no messages",
                                style: primaryfont(color: white),
                              ))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .8,
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(100)),
                            child: TextField(
                              controller: chatcontroller,
                              decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(left: 4, top: 5),
                                    child: Icon(
                                      Icons.emoji_emotions_outlined,
                                      color: Color(0xff8C8C8C),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(12),
                                  hintText: "Send a message",
                                  hintStyle: primaryfont()),
                              onSubmitted: (value) {},
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (chatcontroller.text.isEmpty) {
                                return;
                              }
                              messageSentToDatabase(chatcontroller.text, true);
                              chatcontroller.clear();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xff547981),
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: Icon(
                                  Icons.send_rounded,
                                  color: white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }
            }),
      ),
    );
  }
}

messageSentToDatabase(String text, bool isSentByMe) async {
  String name = await getUserName();
  String gender = await getGender();
  final chat = await FirebaseFirestore.instance
      .collection('chat')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('all-message')
      .doc(DateTime.now().toString());

  await FirebaseFirestore.instance
      .collection('chat')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
    "userId": FirebaseAuth.instance.currentUser!.uid,
    "name": name,
    "gender": gender
  });

  await chat.set(Message(
          name: name,
          userId: FirebaseAuth.instance.currentUser!.uid,
          text: text,
          dateTime: DateTime.now(),
          isSentByMe: isSentByMe)
      .toMap());
}

Future<List<Message>> allMessages() async {
  List<Message> allChat = [];

  final snapshot = await FirebaseFirestore.instance
      .collection('chat')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('all-message')
      .get();

  if (snapshot.docs.isNotEmpty) {
    allChat = snapshot.docs.map((data) {
      final mapContent = data.data();
      return Message.fromMap(mapContent);
    }).toList();
  }

  return allChat;
}

getUserName() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  final username = snapshot.data();
  return username!['userName'];
}

getGender() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  final user = snapshot.data();
  return user!['gender'];
}
