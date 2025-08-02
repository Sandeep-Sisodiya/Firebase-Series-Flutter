import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Showdata extends StatefulWidget {
  const Showdata({super.key});

  @override
  State<Showdata> createState() => _ShowdataState();
}

class _ShowdataState extends State<Showdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Show Data"), centerTitle: true),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  // just for debug
                  print(data);

                  return ListTile(
                    leading: CircleAvatar(child: Text("${index + 1}")),
                    // title: Text("${snapshot.data!.docs[index]["title"]}"),
                    // subtitle: Text(
                    //   "${snapshot.data!.docs[index]["description"]}",
                    // ),
                    //   if we use above code then it will through badState error that means there is a document in which your keys are not matching
                    title: Text(data["title"] ?? "No Title"),
                    subtitle: Text(data["description"] ?? "No Description"),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.hasError.toString()}"));
            } else {
              return Center(child: Text("No Data Found"));
            }
          }
          // Add this return for cases where connectionState is not active
          return Center(child: CircularProgressIndicator());
        },
      ),

    );
  }
}
