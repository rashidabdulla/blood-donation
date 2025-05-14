import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String ? selectedGroup;
  final CollectionReference donor = 
  FirebaseFirestore.instance.collection('donor');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorphone = TextEditingController();

  void addDonor(){
    final data = {'name': donorName.text, 'phone': donorphone.text, 'group': selectedGroup};
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red[900],
        title: Text(
          'Add Details',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Donor Name")
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorphone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Phone Number")
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  label: Text("Select Blood Group")
                ),
                items: bloodGroups.map((e) => DropdownMenuItem(
                child: Text(e),
                value: e,
                )).toList(), onChanged: (val){
                  selectedGroup = val;
                }),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                addDonor();
                Navigator.pop(context);
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(double.infinity,50)),
                backgroundColor: MaterialStateProperty.all(Colors.red[900])
              ),
               child: Text("Submit",style: TextStyle(fontSize: 20,color: Colors.white),))
          ],
        ),
      ),
    );
  }
}