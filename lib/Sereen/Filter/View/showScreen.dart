import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Ulits/data_helper.dart';
import '../Controller/showController.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryController controller = Get.put(HistoryController());
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtnote = TextEditingController();
  TextEditingController txtpaytype = TextEditingController();
  TextEditingController txtstatus = TextEditingController();
  TextEditingController txtdate = TextEditingController(
      text:
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
  TextEditingController txttime = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  HistoryController h1 = Get.put(HistoryController());

  @override
  void initState() {
    super.initState();
    controller.readtransection();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('All Transaction',
              style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
          centerTitle: true,
          actions: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  h1.date.value = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2030)))!;
                                },
                                child: Obx(
                                      () => Text(
                                    "From :  🗓️ ${h1.date.value.day}/${h1.date.value.month}/${h1.date.value.year}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.deepPurple,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  h1.Date.value = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2030)))!;
                                },
                                child: Obx(
                                      () => Text(
                                    "To :   🗓️ ${h1.Date.value.day}/${h1.Date.value.month}/${h1.Date.value.year}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.deepPurple,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.filter_alt_rounded))
                            ],
                          ));
                    },
                    child: Text("")),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      h1.readtransection();
                                      Get.back();
                                    },
                                    child: Text('View All',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      h1.readIncomeExpense(1);
                                      Get.back();
                                    },
                                    child: Text('Income',
                                        style: TextStyle(
                                          color: Colors.amberAccent,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      h1.readIncomeExpense(0);
                                      Get.back();
                                    },
                                    child: Text('Expense',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: 'Filter',
                        );
                      },
                      child: Icon(
                        Icons.filter_list_alt,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ],
        ),
        body: Obx(
              () => ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => transactionBox(
              controller.transectionlist[index]['id'],
              controller.transectionlist[index]['category'],
              controller.transectionlist[index]['notes'],
              controller.transectionlist[index]['amount'],
              controller.transectionlist[index]['status'],
              index,
            ),
            itemCount: controller.transectionlist.length,
          ),
        ),
      ),
    );
  }

  Widget transactionBox(int id, String category, String notes, String amount,
      String status, int index) {
    int s1 = int.parse(status);
    return Container(
      height: 75,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: s1 == 1
            ? Border.all(color: Colors.amberAccent, width: 1)
            : Border.all(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('${id}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 17)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$category',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16)),
              SizedBox(
                height: 2,
              ),
              Text('$notes',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 13)),
            ],
          ),
          s1 == 1
              ? Text('\$ $amount',
              style: TextStyle(
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 17))
              : Text('\$ $amount',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 17)),
          InkWell(
              onTap: () {
                txtcate = TextEditingController(
                    text: '${controller.transectionlist[index]['category']}');
                txtamount = TextEditingController(
                    text: '${controller.transectionlist[index]['amount']}');
                txtdate = TextEditingController(
                    text: '${controller.transectionlist[index]['date']}');
                txttime = TextEditingController(
                    text: '${controller.transectionlist[index]['time']}');
                txtpaytype = TextEditingController(
                    text: '${controller.transectionlist[index]['paytype']}');
                txtnote = TextEditingController(
                    text: '${controller.transectionlist[index]['notes']}');
                Get.defaultDialog(
                  title: 'Update',
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                              () => Container(
                            height: 60,
                            width: 270,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                items: h1.category
                                    .map(
                                      (element) => DropdownMenuItem(
                                      child: Text(element), value: element),
                                )
                                    .toList(),
                                onChanged: (value) {
                                  h1.selectcategory.value = value!;
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 110),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                                value: h1.selectcategory.value,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: txtamount,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Amount"),
                              fillColor: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                              () => Container(
                            height: 60,
                            width: 270,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                items: h1.paytype
                                    .map(
                                      (element) => DropdownMenuItem(
                                      child: Text(element), value: element),
                                )
                                    .toList(),
                                onChanged: (value) {
                                  h1.selectpay.value = value!;
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 150),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                                value: h1.selectpay.value,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: txtdate,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Date"),
                              fillColor: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: txttime,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Time"),
                              fillColor: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: txtnote,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Note"),
                              fillColor: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Dbhelper dbhelper = Dbhelper();
                                    int status = 1;
                                    String cate = txtcate.text;
                                    String amt = txtamount.text;
                                    String note = txtnote.text;
                                    String date = txtdate.text;
                                    String time = txttime.text;
                                    String paytype = txtpaytype.text;
                                    controller.updatetransaction(cate, amt,
                                        status, note, date, time, paytype, id);
                                    controller.readtransection();
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.amberAccent,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text('Income',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Dbhelper dbhelper = Dbhelper();
                                    int status = 0;
                                    String cate = txtcate.text;
                                    String amt = txtamount.text;
                                    String note = txtnote.text;
                                    String date = txtdate.text;
                                    String time = txttime.text;
                                    String paytype = txtpaytype.text;
                                    controller.updatetransaction(cate, amt,
                                        status, note, date, time, paytype, id);
                                    controller.readtransection();
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text('Expanse',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              child: Icon(Icons.edit, color: Colors.black)),
          InkWell(
              onTap: () {
                int id = controller.transectionlist[index]['id'];
                controller.deletetransaction(id);
                controller.readtransection();
              },
              child: Icon(Icons.delete, color: Colors.red),),
        ],
      ),
    );
  }
}

List filterList = [
  'Expense',
  'Income',
  'View all',

];