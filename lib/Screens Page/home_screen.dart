import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger_app/Screens%20Page/profile_screen.dart';
import 'package:messenger_app/api/apis.dart';
import 'package:messenger_app/main.dart';
import 'package:messenger_app/model/user_chat.dart';
import 'package:messenger_app/widgets/user_chat_cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //For store data
  List<ChatUser> _list = [];
  bool isLoading = true;
  //For searching

  final List<ChatUser> _SearchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _initializeUser();
    Apis.getSelfInfo();
  }

  Future<void> _initializeUser() async {
    await Apis.getSelfInfo();
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (Apis.auth.currentUser != null) {
        //active or online
        if (message.toString().contains('resume')) {
          Apis.updateActiveStatus(true);
        }
        //innactive or offline
        if (message.toString().contains('pause')) {
          Apis.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      //for seach button to back
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFE8F5E9),
          appBar: AppBar(
            leading: const Icon(CupertinoIcons.home),
            title: _isSearching
                ? TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name, Email...',
                        hintStyle: TextStyle(fontSize: 17, letterSpacing: 0.5)),
                    //For seaching
                    onChanged: (val) {
                      _SearchList.clear();
                      for (var i in _list) {
                        if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                            i.email.toLowerCase().contains(val.toLowerCase())) {
                          _SearchList.add(i);
                        }
                        setState(() {
                          _SearchList;
                        });
                      }
                    },
                    autofocus: true,
                  )
                : Text("Chat of Duty"),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
                icon: Icon(_isSearching
                    ? CupertinoIcons.clear_circled_solid
                    : Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(
                        user: Apis.me,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              onPressed: () async {
                await Apis.auth.signOut();
                await GoogleSignIn().signOut();
              },
              child: const Icon(Icons.add_comment_rounded),
            ),
          ),
          body: StreamBuilder(
            stream: Apis.getAllUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  _list =
                      data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                          [];

                  if (_list.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.only(top: mq.height * 0.02),
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          _isSearching ? _SearchList.length : _list.length,
                      itemBuilder: (context, index) {
                        return UserChatCart(
                            user: _isSearching
                                ? _SearchList[index]
                                : _list[index]);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "No Users Found",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
