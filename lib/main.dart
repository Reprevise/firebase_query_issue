import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Query Test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Query Test'),
        ),
        body: QueryTestView(),
      ),
    );
  }
}

class QueryTestView extends StatefulWidget {
  QueryTestView({Key? key}) : super(key: key);

  @override
  QueryTestViewState createState() => QueryTestViewState();
}

class QueryTestViewState extends State<QueryTestView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('test')
          .where('greatField', isNotEqualTo: null)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          itemCount: snapshot.data!.size,
          itemBuilder: (c, i) {
            return Container(
              child: Text(snapshot.data!.docs[i].data().toString()),
            );
          },
          separatorBuilder: (c, i) => Divider(),
        );
      },
    );
  }
}
