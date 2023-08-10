import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreen();
  }
}

class _RegistrationScreen extends State<RegistrationScreen> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController firstInput = TextEditingController();
  TextEditingController lastInput = TextEditingController();
  TextEditingController genderInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstInput;
    dateInput;
    lastInput;
    genderInput;
    passwordInput;
  }

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      setState(() {
        dateInput.text = formattedDate; //set output date to TextField value.
      });
    } else {}
  }

  void _submitData() async {
    final formValues = _formKey.currentState!.validate();
    if (formValues) {
     showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('User Information'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('First Name: ${firstInput.text}'),
                          Text('Last Name: ${lastInput.text}'),
                          Text('Gender: ${genderInput.text}'),
                          Text('Date of Birth: ${dateInput.text}'),
                          Text('Password: ${passwordInput.text}'),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
             

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registration",
          style: TextStyle(
              color: Colors.yellow, fontWeight: FontWeight.w700, fontSize: 24),
        ),
        backgroundColor:
            const Color.fromARGB(255, 8, 36, 122), //background color of app bar
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                 
                  controller: firstInput,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hoverColor: const Color.fromARGB(255, 8, 36, 122),
                      focusColor: const Color.fromARGB(255, 8, 36, 122),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "First Name"),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: lastInput,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hoverColor: const Color.fromARGB(255, 8, 36, 122),
                      focusColor: const Color.fromARGB(255, 8, 36, 122),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "Last Name"),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: genderInput,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your gender';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hoverColor: const Color.fromARGB(255, 8, 36, 122),
                      focusColor: const Color.fromARGB(255, 8, 36, 122),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "Gender"),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: dateInput,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your DOB';
                    }
                    return null;
                  },
                   readOnly: true,
                  onTap: _pickDate,
                  decoration: InputDecoration(
                      hoverColor: const Color.fromARGB(255, 8, 36, 122),
                      focusColor: const Color.fromARGB(255, 8, 36, 122),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "Date of Birth"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: passwordInput,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "password to weak";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hoverColor: const Color.fromARGB(255, 8, 36, 122),
                      focusColor: const Color.fromARGB(255, 8, 36, 122),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "Password"),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 8, 36, 122),
                      minimumSize: Size(300, 60)),
                  onPressed: _submitData,
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ))
            ],
          )),
    );
  }
}
