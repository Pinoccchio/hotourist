import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/app_bar/custom_text_form_field.dart' as AppBarCustomTextFormField;
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:dialog_flowtter/src/models/query_input/text_input.dart' as DialogFlowTextInput;
import 'package:intl/intl.dart';

import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;

  const Message({
    required this.text,
    required this.date,
    required this.isSentByMe,
  });
}

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [];
  late TextEditingController _messageController;
  DialogFlowtter? dialogFlowtter;
  bool isBotTyping = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    initializeFirebaseApp();
    _messageController = TextEditingController();
    loadDialogFlowtterConfig();
  }

  @override
  void dispose() {
    _messageController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Future<void> initializeFirebaseApp() async {
    await Firebase.initializeApp();
  }

  Future<void> loadDialogFlowtterConfig() async {
    try {
      print("Goods ra!");
      dialogFlowtter = DialogFlowtter(
        jsonPath: "assets/dialog_flow_auth.json",
      );
    } catch (e, stackTrace) {
      print('Error initializing DialogFlowtter: $e\n$stackTrace');
    }
  }

  Future<void> sendMessageToBot() async {
    try {
      if (dialogFlowtter == null) {
        await loadDialogFlowtterConfig();
      }

      final userMessage = _messageController.text;

      setState(() {
        isBotTyping = true;
      });

      final response = await dialogFlowtter!.detectIntent(
        queryInput: QueryInput(
          text: DialogFlowTextInput.TextInput(
            text: userMessage,
            languageCode: 'en',
          ),
        ),
      );

      final String botMessage = response.message?.text?.text?.first ?? '';

      setState(() {
        messages.add(Message(
          text: userMessage,
          date: DateTime.now(),
          isSentByMe: true,
        ));
        messages.add(Message(
          text: botMessage,
          date: DateTime.now(),
          isSentByMe: false,
        ));
        isBotTyping = false;
      });

      _messageController.clear(); // Clear the text field

      print('Bot Response: $botMessage'); // Print the bot's response
    } catch (e, stackTrace) {
      setState(() {
        isBotTyping = false;
      });
      print('Error sending message to bot: $e\n$stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: _buildAppBar(context),
    body: Column(
      children: [
        Expanded(
          child: messages.isEmpty
              ? Center(
            child: Text(
              'No saved conversations; cleared upon exit.',
              style: TextStyle(color: Colors.white),
            ),
          )
              : GroupedListView<Message, DateTime>(
            padding: const EdgeInsets.all(8),
            reverse: true,
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            elements: messages,
            groupBy: (message) => DateTime(
              message.date.year,
              message.date.month,
              message.date.day,
            ),
            groupHeaderBuilder: (Message message) => SizedBox(
              height: 40,
              child: Center(
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      DateFormat.yMMM().format(message.date),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            itemBuilder: (context, Message message) => Align(
              alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                elevation: 8,
                color: message.isSentByMe
                    ? Color(0xFF31343B)
                    : Color(0xFF1AADB6),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isSentByMe
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isBotTyping)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'HTBot is typing...',
              style: TextStyle(color: Colors.white),
            ),
          ),
        Container(
          color: Color(0xFF31343B),
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              hintText: 'Type your message here...',
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white),
            onSubmitted: (text) {
              sendMessageToBot();
            },
          ),
        ),
      ],
    ),
  );

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 52.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 16.v),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: AppbarTitle(text: "HTBot", margin: EdgeInsets.only(left: 16.h)),
    );
  }
}