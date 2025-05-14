import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Blood extends StatefulWidget {
  const Blood({super.key});

  @override
  State<Blood> createState() => _BloodState();
}

class _BloodState extends State<Blood> {
  
  final CollectionReference donor = 
  FirebaseFirestore.instance.collection('donor');

  void deleteDonor(docId){
    donor.doc(docId).delete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.red[900],
        title: Text("Blood Donation",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/Details');
        },
      backgroundColor: Colors.white70,
      child: Icon(Icons.add,
      color: Colors.red[900],
      size: 30,
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

      body: StreamBuilder(
        stream: donor.orderBy('name').snapshots(), 
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                final DocumentSnapshot donorsnap = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 194, 193, 193),
                          blurRadius: 10,
                          spreadRadius: 15,
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.red[900],
                              radius: 30,
                              child: Text(donorsnap['group'],
                              style: TextStyle(fontSize: 20,color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(donorsnap['name'],
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                            ),
                            Text(donorsnap['phone'].toString(),
                            style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              Navigator.pushNamed(context, '/Update',
                              arguments: {
                                'name':donorsnap['name'],
                                'phone':donorsnap['phone'].toString(),
                                'group':donorsnap['group'],
                                'id':donorsnap.id,
                              }
                              );
                            }, icon: Icon(Icons.edit),
                            iconSize: 30,
                            color: Colors.blue,
                            ),
                             IconButton(onPressed: (){
                              deleteDonor(donorsnap.id);
                             }, icon: Icon(Icons.delete),
                             iconSize: 30,
                             color: Colors.red,
                             )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
          }
          return Container();
        }
        ),
    );
  }
}