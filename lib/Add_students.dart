import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:MyStudents/service/database.dart';
import 'package:random_string/random_string.dart';
import 'homepage.dart';

class addstudent extends StatefulWidget {
  const addstudent({super.key});

  @override
  State<addstudent> createState() => _addstudentState();
}

class _addstudentState extends State<addstudent> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Add Students",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const Homepage()));
            // Handle menu icon press
          },
        ),
      ),
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
                  topLeft: Radius.circular(80),
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(80),
                  topRight: Radius.circular(200))),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      maxLines: null,
                      controller: _namecontroller,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Name",
                          border: InputBorder.none),
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
                  items: _genders.map<DropdownMenuItem<String>>((String value) {
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
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      String Id = randomAlphaNumeric(10);
                      // Add functionality here
                      Map<String, dynamic> studentInfoMap = {
                        "Id": Id,
                        "name": _namecontroller.text,
                        "Date of birth": _dateController.text.toString(),
                        "gender": _genderController.text,
                      };
                      await DatabaseMethods()
                          .addStudentDetails(studentInfoMap, Id)
                          .then((value) {
                        Fluttertoast.showToast(
                            msg: "Student details has been added successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            // gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homepage()));
                    },
                    child: const Text(
                      'Add',
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
