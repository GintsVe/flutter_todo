import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo/screens/taskpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String? dropDownValue;

  var languages = ["Latvian", "Russian", "English"];

  final usernameController = TextEditingController();

  bool isUsernameEmpty() {
    if(usernameController.text.trim() != "" && dropDownValue != null) {
      return false;
    }else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 150),
            Container(
              width: double.infinity,
              height: 70,
              color: Colors.blue,
              child: const Text(
                'Welcome!',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
              alignment: Alignment.center,
            ),
            const SizedBox(height: 50),
            TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(15)
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Username",
              ),
              style: const TextStyle(
                fontSize: 30
              ),
              textAlign: TextAlign.center,
              controller: usernameController,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropDownValue,
                style: const TextStyle(color: Colors.black, fontSize: 30),
                onChanged: (String? newValue){
                  setState(() {
                    dropDownValue = newValue!;
                  });
                  },
                alignment: Alignment.center,
                hint: const Text(
                  "Choose a language",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                items: languages.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(child: Text(value)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                !isUsernameEmpty() ? Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TasksPage()),
                ) : null;
                },
              child: const Text(
                  "Next"
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 40),
                primary: isUsernameEmpty() ? Colors.blueGrey[200] : Colors.blue,
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}