import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/widgets/backbutton.dart';
import 'package:waste_management/presentation/widgets/message_bubble_admin.dart';
import 'package:waste_management/presentation/widgets/message_bubble_user.dart';

class ChatSupport extends StatefulWidget {
  ChatSupport({super.key});

  @override
  State<ChatSupport> createState() => _ChatSupportState();
}

class _ChatSupportState extends State<ChatSupport> {
  List<Messages> messages = [
    Messages(
        text:
            "Thsi has been a great pleasuer how may i helop uo tjshdfwepojfsigjaorhjdogahf!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "Yes sure!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "Yes sure!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "Yes sure!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "Yes sure!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "Yes sure!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "Yes sure!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "Yes sure!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "Yes sure!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "Yes sure!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "Yes sure!",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "hello",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "wassup",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: true),
    Messages(
        text: "hello",
        dateTime: DateTime.now().subtract(Duration(days: 2, minutes: 10)),
        isSentByMe: false),
    Messages(
        text: "this is not it",
        dateTime: DateTime.now().subtract(Duration(days: 2, minutes: 4)),
        isSentByMe: true),
    Messages(
        text: "hello",
        dateTime: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Messages(
        text: "i need it now pls hand it over",
        dateTime: DateTime.now().subtract(Duration(days: 3, minutes: 9)),
        isSentByMe: true),
    Messages(
        text: "now way this is happpening",
        dateTime: DateTime.now().subtract(Duration(days: 3, minutes: 6)),
        isSentByMe: false),
    Messages(
        text: "get out house",
        dateTime: DateTime.now().subtract(Duration(days: 3, minutes: 4)),
        isSentByMe: true),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffB2E6B5),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
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
        child: Column(
          children: [
            Expanded(
                child: GroupedListView<Messages, DateTime>(
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages,
              groupBy: (element) {
                return DateTime(element.dateTime.year, element.dateTime.month,
                    element.dateTime.day);
              },
              groupHeaderBuilder: (Messages element) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat.yMMMEd().format(element.dateTime),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                );
              },
              itemBuilder: (context, element) {
                return element.isSentByMe
                    ? MessageBubbleUser(message: element.text)
                    : MessageBubbleAdmin(message: element.text);
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .8,
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(100)),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 4, top: 5),
                            child: Icon(
                              Icons.emoji_emotions_outlined,
                              color: Color(0xff8C8C8C),
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                          hintText: "Send a message",
                          hintStyle: primaryfont()),
                      onSubmitted: (text) {
                        if (text.isEmpty) {
                          return;
                        }
                        final message = Messages(
                            text: text,
                            dateTime: DateTime.now(),
                            isSentByMe: true);
                        setState(() {
                          messages.add(message);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color(0xff547981),
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Icon(
                        Icons.send_rounded,
                        color: white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Messages {
  String text;
  DateTime dateTime;
  bool isSentByMe;
  Messages({
    required this.text,
    required this.dateTime,
    required this.isSentByMe,
  });
}
