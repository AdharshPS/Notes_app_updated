import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_with_adapter_class/model/notes_model.dart';
import 'package:hive_with_adapter_class/utils/color_constant/color_constant.dart';
import 'package:hive_with_adapter_class/view/detailes_screen/details_screen.dart';
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
    Color(0xFFA77979),
    Color(0xFF526D82),
    Color(0xFFD49B54),
    Color(0xFF624F82),
  ];
  List<Color?> darkColorList = [
    Color(0xFF845656),
    Color(0xFF354A5A),
    Color(0xFFA57233),
    Color(0xFF4C3671),
  ];
  int? colorindex;

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool isEditing = false;
  int? keyIndex;

  String dropDownValue = 'Home';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: ColorConstant.bottomSheet,
        appBar: AppBar(
          backgroundColor: ColorConstant.bottomSheet,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "NOTES",
            style: TextStyle(
              color: ColorConstant.titleColor,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          // bottom: TabBar(
          //   unselectedLabelColor: ColorConstant.titleColor,
          //   labelColor: ColorConstant.titleColor,
          //   isScrollable: true,
          //   indicatorColor: ColorConstant.bottomSheet,
          //   indicator: BoxDecoration(
          //     color: ColorConstant.backgroundColor,
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          //   tabs: [
          //     Tab(
          //       text: "All",
          //     ),
          //     Tab(
          //       text: "Home",
          //     ),
          //     Tab(
          //       text: "Class",
          //     ),
          //     Tab(
          //       text: "Work",
          //     ),
          //     Tab(
          //       text: "GK",
          //     ),
          //     Tab(
          //       text: "Personal",
          //     ),
          //   ],
          // ),
        ),
        body: keysList.length == 0
            ? Center(
                child: Text(
                  "No notes yet!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.splash,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: keysList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            bgColor: colorList[box.get(keysList[index])!.color],
                            title: box.get(keysList[index])!.title,
                            des: box.get(keysList[index])!.des,
                          ),
                        ));
                    print("Button");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    // container
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colorList[box.get(keysList[index])!.color],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              height10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .5,
                                    child: Text(
                                      box.get(keysList[index])?.title ?? "",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstant.titleColor,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          isEditing = true;
                                          keyIndex = index;
                                          bottomSheetMethod(context);
                                          titleController.text = (box
                                              .get(keysList[index])
                                              ?.title)!;
                                          desController.text =
                                              (box.get(keysList[index])?.des)!;
                                          dropDownValue =
                                              (box.get(keysList[index])?.cat)!;
                                          dateController.text =
                                              (box.get(keysList[index])?.date)!;
                                          colorindex =
                                              box.get(keysList[index])?.color;
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: ColorConstant.titleColor,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          box.delete(keysList[index]);
                                          keysList = box.keys.toList();
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: ColorConstant.titleColor,
                                        ),
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
                                    color: ColorConstant.titleColor,
                                  ),
                                ),
                              ),
                              height10,
                              height10,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    box.get(keysList[index])?.date ?? "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.titleColor,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 15,
                          child: Container(
                            width: 100,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorConstant.bottomSheet,
                            ),
                            child: Text(
                              box.get(keysList[index])?.cat ?? "",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorConstant.titleColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstant.splash,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: () {
            isEditing = false;
            bottomSheetMethod(context);
            titleController.clear();
            desController.clear();
            dropDownValue == 'Home';
            dateController.clear();
            colorindex = null;
          },
          child: Icon(Icons.add),
        ),
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
          color: ColorConstant.bottomSheet,
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
                          // borderSide: BorderSide(
                          //   color: Colors.black,
                          // ),
                          ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[600]!,
                          width: 5,
                        ),
                      ),
                      // focusColor: Colors.grey[900],
                      filled: true,
                      fillColor: ColorConstant.bottomSheet,
                      hintText: "Title",
                      hintStyle: TextStyle(
                        color: ColorConstant.titleColor,
                      ),
                    ),
                    style: TextStyle(
                      color: ColorConstant.titleColor,
                    ),
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
                      fillColor: ColorConstant.bottomSheet,
                      hintText: "Description",
                      hintStyle: TextStyle(
                        color: ColorConstant.titleColor,
                      ),
                    ),
                    style: TextStyle(
                      color: ColorConstant.titleColor,
                    ),
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
                      fillColor: ColorConstant.bottomSheet,
                      hintText: "Date",
                      hintStyle: TextStyle(
                        color: ColorConstant.titleColor,
                      ),
                    ),
                    style: TextStyle(
                      color: ColorConstant.titleColor,
                    ),
                  ),
                ),
                // category
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: DropdownButton(
                      focusColor: ColorConstant.bottomSheet,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 3),
                      value: dropDownValue,
                      items: <String>['Home', 'Class', 'Work', 'GK', 'Personal']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          alignment: Alignment.center,
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        insetState(() {});
                        dropDownValue = newValue!;
                      },
                    )
                    // TextFormField(
                    //   controller: catController,
                    //   decoration: InputDecoration(
                    //       // contentPadding: EdgeInsets.symmetric(
                    //       //     vertical: 40, horizontal: 10),
                    //       border: OutlineInputBorder(),
                    //       filled: true,
                    //       fillColor: Colors.grey[300],
                    //       hintText: "Category"),
                    // ),
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
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.splash,
                    ),
                  ),
                  onPressed: () {
                    isEditing == true
                        ? box.put(
                            keysList[keyIndex!],
                            NotesModel(
                                title: titleController.text,
                                des: desController.text,
                                date: dateController.text,
                                cat: dropDownValue,
                                color: colorindex!),
                          )
                        : box.add(
                            NotesModel(
                                title: titleController.text,
                                des: desController.text,
                                date: dateController.text,
                                cat: dropDownValue,
                                color: colorindex!),
                          );
                    keysList = box.keys.toList();

                    titleController.clear();
                    desController.clear();
                    dropDownValue = 'Home';
                    dateController.clear();
                    colorindex = null;

                    setState(() {});
                    insetState(() {});

                    Navigator.pop(context);
                  },
                  child: Text(
                    isEditing == true ? "Update" : "Add Notes",
                    style: TextStyle(
                      color: ColorConstant.backgroundColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
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
