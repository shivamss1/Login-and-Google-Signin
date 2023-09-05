import 'package:exam/contact.dart';
import 'package:flutter/material.dart';

class order extends StatefulWidget {
  const order({super.key});

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  List<Contact> contacts = List.empty(growable: true);
  TextEditingController namecontrol = TextEditingController();
  TextEditingController numbercontrol = TextEditingController();

  int SelectIndex = -1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        height: size.height * 0.6,
        width: size.width * 0.9,
        child: Column(
          children: [
            TextField(
                keyboardType: TextInputType.text,
                controller: namecontrol,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: " Enter Name",
                  prefixIcon: const Icon(Icons.person),
                )),
            const SizedBox(
              height: 12,
            ),
            TextField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: numbercontrol,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Enter Number",
                  prefixIcon: const Icon(Icons.numbers),
                )),
            Container(
              margin: EdgeInsets.only(left: size.width * 0.27),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        String name = namecontrol.text.trim();
                        String number = numbercontrol.text.trim();
                        if (name.isNotEmpty && number.isNotEmpty) {
                          setState(() {
                            namecontrol.clear();
                            numbercontrol.clear();
                            contacts.add(Contact(name: name, contact: number));
                          });
                        }
                      },
                      child: const Text("Save")),
                  const SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String name = namecontrol.text.trim();
                        String number = numbercontrol.text.trim();
                        if (name.isNotEmpty && number.isNotEmpty) {
                          setState(() {
                            namecontrol.clear();
                            numbercontrol.clear();
                            contacts[SelectIndex].name = name;
                            contacts[SelectIndex].contact = number;
                            SelectIndex = -1;
                          });
                        }
                      },
                      child: const Text("Update"))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            contacts.isEmpty
                ? const Text("No Contact yets")
                : Expanded(
                    child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) => getRow(index)),
                  )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.blueAccent,
          foregroundColor: Colors.white,
          child: Text(contacts[index].name[0]),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact)
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: (() {
                    namecontrol.text = contacts[index].name;
                    numbercontrol.text = contacts[index].contact;
                    setState(() {
                      SelectIndex = index;
                    });
                  }),
                  child: const Icon(Icons.edit)),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                  onTap: (() {
                    setState(() {
                      contacts.removeAt(index);
                    });
                  }),
                  child: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
