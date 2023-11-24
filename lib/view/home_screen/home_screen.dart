import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_with_adapter_class/model/notes_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var box = Hive.box<NotesModel>('notes');
  @override
  void initState() {
    keysList = box.keys.toList();
    super.initState();
  }

  List keysList = [];
  SizedBox height10 = SizedBox(height: 10);
  List<Color> colorList = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.purple,
  ];
  List<Color?> darkColorList = [
    Colors.blue[700],
    Colors.green[700],
    Colors.yellow[700],
    Colors.red[700],
    Colors.purple[700],
  ];
  int? colorindex;

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        centerTitle: true,
        title: Text(
          "NOTES",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: keysList.length == 0
          ? Center(
              child: Text(
                "No notes yet!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
            )
          : ListView.builder(
              itemCount: keysList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8),
                // container
                child: Container(
                  decoration: BoxDecoration(
                      color: colorList[box.get(keysList[index])?.color ?? 0],
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .5,
                            child: Text(
                              box.get(keysList[index])?.title ?? "",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  bottomSheetMethod(context);
                                  titleController.text =
                                      (box.get(keysList[index])?.title)!;
                                  desController.text =
                                      (box.get(keysList[index])?.des)!;
                                  catController.text =
                                      (box.get(keysList[index])?.cat)!;
                                  dateController.text =
                                      (box.get(keysList[index])?.date)!;
                                  colorindex = box.get(keysList[index])?.color;
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  box.delete(keysList[index]);
                                  keysList = box.keys.toList();
                                  setState(() {});
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          )
                        ],
                      ),
                      height10,
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .90,
                        child: Text(
                          box.get(keysList[index])?.des ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      height10,
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .50,
                        child: Text(
                          box.get(keysList[index])?.cat ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            box.get(keysList[index])?.date ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[600],
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: () {
          bottomSheetMethod(context);
          titleController.clear();
          desController.clear();
          catController.clear();
          dateController.clear();
          colorindex = null;
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> bottomSheetMethod(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, insetState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: Colors.grey[500],
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // title
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey[600]!,
                          width: 5,
                        )),
                        // focusColor: Colors.grey[900],
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: "Title"),
                  ),
                ),
                // description
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: desController,

                    // keyboardType: TextInputType.multiline,
                    // textInputAction: TextInputAction.next,
                    maxLines: null,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: "Description"),
                  ),
                ),
                // date
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: dateController,

                    readOnly: true,
                    onTap: () async {
                      DateTime selectedDate = DateTime.now();

                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2040),
                      );

                      if (picked != null && picked != selectedDate) {
                        selectedDate = picked;
                        setState(() {});
                      }

                      dateController.text =
                          DateFormat('EE, MMM dd, yyyy').format(selectedDate);
                    },

                    // keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: 40, horizontal: 10),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: "Date"),
                  ),
                ),
                // category
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: catController,
                    decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: 40, horizontal: 10),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: "Category"),
                  ),
                ),
                // color
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    colorList.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          colorindex = index;
                          insetState(() {});
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: colorList[index],
                            borderRadius: BorderRadius.circular(20),
                            // shape: BoxShape.circle,
                            border: colorindex == index
                                ? Border.all(
                                    width: 7,
                                    color: darkColorList[index]!,
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                height10,
                // button
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.grey[300],
                    ),
                  ),
                  onPressed: () {
                    box.add(
                      NotesModel(
                          title: titleController.text,
                          des: desController.text,
                          date: dateController.text,
                          cat: catController.text,
                          color: colorindex!),
                    );
                    keysList = box.keys.toList();

                    setState(() {});
                    insetState(() {});

                    titleController.clear();
                    desController.clear();
                    catController.clear();
                    dateController.clear();
                    colorindex = null;
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Add Notes",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                height10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
