import 'package:blocstate/bloc/contact_bloc.dart';
import 'package:blocstate/models/contact.dart';
import 'package:blocstate/ui/chat_screen.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  final ContactBloc _contactBloc = ContactBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Select Contact",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  Text(
                    "5 Contacts",
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () => debugPrint("Search"),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () => debugPrint("More"),
          ),
        ],
      ),
      body: StreamBuilder<List<Contact>>(
          stream: _contactBloc.contactListStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("No Contacts available"));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            child: Image(
                              height: 50.0,
                              width: 50.0,
                              image: AssetImage(
                                  snapshot.data![index].contactImageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data![index].contactName,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                snapshot.data![index].contactStatus,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              )
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _contactBloc.deleteTapSink
                                  .add(snapshot.data![index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  @override
  void dispose() {
    _contactBloc.dispose();
    super.dispose();
  }
}
