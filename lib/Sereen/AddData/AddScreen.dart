import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_exapnce/Ulits/data_helper.dart';

import '../Filter/Controller/showController.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  HistoryController historyController = Get.put(HistoryController());

  TextEditingController txtcate = TextEditingController();
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtnote = TextEditingController();
  TextEditingController txtpaytype = TextEditingController();
  TextEditingController txtstatus = TextEditingController();
  TextEditingController txtdate = TextEditingController();
  TextEditingController txttime = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");

  @override
  void initState() {
    Dbhelper dbhelper = Dbhelper();
    dbhelper.checkdb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    txtdate = TextEditingController(
        text:
        '${historyController.current.value.day}/${historyController.current.value.month}/${historyController.current.value.year}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Add Income/Expance"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                Obx(
                      () => Container(
                    height: 60,
                    width: 393,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButton(
                        items: historyController.category.map((element) => DropdownMenuItem(
                              child: Text(element), value: element),).toList(),
                        onChanged: (value) {
                          historyController.selectcategory.value = value!;
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                        ),
                        value: historyController.selectcategory.value,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txtamount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Amount"),
                      fillColor: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                      () => Container(
                    height: 60,
                    width: 393,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        items: historyController.paytype
                            .map(
                              (element) => DropdownMenuItem(
                              child: Text(element), value: element),
                        )
                            .toList(),
                        onChanged: (value) {
                          historyController.selectpay.value = value!;
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                        ),
                        value: historyController.selectpay.value,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 393,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                              () => Text(
                              "${historyController.current.value.day}/${historyController.current.value.month}/${historyController.current.value.year}"),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            historyController.current.value =
                            (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2030)))!;
                          },
                          icon: Icon(Icons.calendar_month))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txttime,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: DateTime.now().hour,
                                    minute: DateTime.now().minute));
                          },
                          icon: Icon(Icons.access_time_rounded)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      fillColor: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txtnote,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Note"),
                      fillColor: Colors.black),
                ),
                SizedBox(
                  height: 130,
                ),
                Align(alignment: Alignment.bottomCenter, child: addButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addButton() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                var cat = historyController.selectcategory.value;
                Dbhelper dbhelper = Dbhelper();
                dbhelper.insertdata(
                    category: cat,
                    amount: txtamount.text,
                    status: '1',
                    notes: txtnote.text,
                    date: txtdate.text,
                    time: txttime.text,
                    paytype: txtpaytype.text);

                sum();

                Get.back();
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text('Income',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                var a = historyController.selectcategory.value;
                Dbhelper dbhelper = Dbhelper();
                dbhelper.insertdata(
                    category: a,
                    amount: txtamount.text,
                    status: '0',
                    notes: txtnote.text,
                    date: txtdate.text,
                    time: txttime.text,
                    paytype: txtpaytype.text);
                int i = 0;
                for (i = 0; i < historyController.transectionlist.length; i++) {
                  int status =
                  int.parse(historyController.transectionlist[i]['status']);
                  if (status == 0) {
                    int amount = int.parse(
                        historyController.transectionlist[i]['amount']);
                    historyController.total.value =
                        historyController.total.value - amount;
                    historyController.expense.value =
                        historyController.expense.value + amount;
                  }
                }
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text('Expanse',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sum() {
    for (int i = 0; i < historyController.transectionlist.length; i++) {
      int status = int.parse(historyController.transectionlist[i]['status']);
      if (status == 1) {
        int amount = int.parse(historyController.transectionlist[i]['amount']);
        historyController.total.value = historyController.total.value + amount;
        historyController.income.value =
            historyController.income.value + amount;

      }
    }
  }
}