import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:MyStudents/Add_students.dart';
import 'profile.dart';
import 'service/database.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Stream? StudentStream;

  getontheload() async {
    StudentStream = await DatabaseMethods().getStudentDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  final TextEditingController _namecontroller = TextEditingController();
  //for date picking in calender
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  //for gender selection
  final List<String> _genders = ['Male', 'Female', 'Prefer not to say'];
  final TextEditingController _genderController = TextEditingController();

  Widget allStudentDetails() {
    return StreamBuilder(
        stream: StudentStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, top: 5, bottom: 5),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 250,
                                    child: Text(
                                      "Name:  " + ds["name"],
                                      style: const TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  Text(
                                    "Date Of Birth:  " + ds["Date of birth"],
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    "Gender:  " + ds["gender"],
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        _namecontroller.text = ds["name"];
                                        _genderController.text = ds["gender"];
                                        _dateController.text =
                                            ds["Date of birth"];
                                        EditStudentDetail(ds["Id"]);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        await DatabaseMethods()
                                            .deleteStudentDetail(ds["Id"]);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.red,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container(
                  child: const Center(child: Text("Add Student")),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "List of students ",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const profile()));
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              )),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Profile'),
                          onTap: () {
                            // Handle Profile option
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          onTap: () {
                            signOut();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.info),
                          title: const Text('About'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          //endpopup
        ],
      ),
      // body: Text("${user!.email}"),
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(500),
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(500),
                  topRight: Radius.circular(200))),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Expanded(child: allStudentDetails()),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //for the animation of slide transition
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const addstudent();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future EditStudentDetail(String Id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white70,
          content: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Edit Details",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  const Text("Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: _namecontroller,
                        decoration: const InputDecoration(
                          hintText: "Enter Your Name",
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Date of birth",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                            // labelText: 'Date of Birth',
                            hintText: 'Select your date of birth',
                            suffixIcon: Icon(Icons.calendar_today),
                            border: InputBorder.none),
                        readOnly: true,
                        onTap: () {
                          _selectDate(context);
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Gender",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    value: _genderController.text.isNotEmpty
                        ? _genderController.text
                        : null,
                    onChanged: (String? newValue) {
                      _genderController.text = newValue!;
                    },
                    items:
                        _genders.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Gender',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> updateInfo = {
                        "name": _namecontroller.text,
                        "Date of birth": _dateController.text,
                        "Id": Id,
                        "gender": _genderController.text
                      };
                      await DatabaseMethods()
                          .updateStudentDetail(Id, updateInfo)
                          .then((value) {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 8, // Adjust elevation here
                      shadowColor: Colors.blue.withOpacity(0.5), // Shadow color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          )));
}
