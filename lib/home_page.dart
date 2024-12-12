import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _ansController = TextEditingController();

  bool requiredFlag = false; //for validation of question
  bool editFlag = false;

  var questionList = [
    //hard coded list to show user some question on launching the app
    {
      "question": "C language developed by whom ?",
      "answer": "Dennis Ritche"
    }, //and the same list's object can be updated and deleted by user
    {"question": "Linux OS build by whom ?", "answer": "Linus Torwald"},
    {"question": "Flutter is founded by?", "answer": "Google"}
  ];

  editAndAdd({String? ques, String? ans, int? questionNo}) {
    //to edit question and answer and can add also in the list
    TextEditingController answer = TextEditingController();
    TextEditingController question = TextEditingController();

    if (editFlag) {
      answer.text = ans!;
      question.text = ques!;
    } else {
      _ansController.clear();
      _questionController.clear();
    }

    return showModalBottomSheet(
      //scrollable bottom sheet
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateTemp) {
          return DraggableScrollableSheet(
            expand: false,
            snap: true,
            builder: (_, controller) {
              return SingleChildScrollView(
                  controller: controller,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Divider(
                            color: Color.fromARGB(255, 128, 128, 128),
                            indent: 160,
                            endIndent: 160,
                            height: 0.1,
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 128, 128, 128),
                            indent: 160,
                            endIndent: 160,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        217, 217, 217, 0.4667),
                                    width: 0.5)),
                            child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: editFlag
                                    ? Row(
                                        children: [
                                          Text(
                                            "Edit Question And Answer",
                                            style: GoogleFonts.poppins(
                                                color: Colors.blueAccent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            "Add Question And Answer",
                                            style: GoogleFonts.poppins(
                                                color: Colors.blueAccent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                              controller:
                                  editFlag ? question : _questionController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                      color:
                                          Color.fromRGBO(217, 217, 217, 0.4667),
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        //color:requiredFlag ? Colors.red : const Color.fromRGBO(29, 70, 164, 1) ,
                                        color: Colors.blueAccent)),
                                labelText: "Question *",
                                labelStyle:
                                    const TextStyle(color: Colors.blueAccent),
                              )),
                          requiredFlag
                              ? const Text(
                                  "This field is required",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                              controller: editFlag ? answer : _ansController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(
                                            217, 217, 217, 0.4667))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent)),
                                labelText: "Answer *",
                                labelStyle:
                                    const TextStyle(color: Colors.blueAccent),
                              )),
                          requiredFlag
                              ? const Text(
                                  "This field is required",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          editFlag
                              ? Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              217, 217, 217, 0.4667),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("Close",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueAccent)),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      //update button
                                      onTap: () async {
                                        if (answer.text.isEmpty ||
                                            question.text.isEmpty) {
                                          setStateTemp(() {
                                            requiredFlag = true;
                                          });
                                        } else {
                                          setState(() {
                                            questionList[questionNo!] = {
                                              "question": question.text.trim(),
                                              "answer": answer.text.trim()
                                            };
                                            Navigator.of(context).pop();
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blueAccent),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Update",
                                            style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              217, 217, 217, 0.4667),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("Close",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueAccent)),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      //add product button
                                      onTap: () async {
                                        setState(() {
                                          if (_ansController.text
                                                  .isEmpty || //will validate the ques and ans
                                              _questionController
                                                  .text.isEmpty) {
                                            setStateTemp(() {
                                              requiredFlag = true;
                                            });
                                          } else {
                                            questionList.add({
                                              "question": _questionController
                                                  .text
                                                  .trim(),
                                              "answer":
                                                  _ansController.text.trim()
                                            });
                                            Navigator.of(context).pop();
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blueAccent),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("Submit",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ));
            },
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.blueAccent,
        title: Text(
          "FlashCards",
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: showQuestionList(), //will show the questions list
      floatingActionButton: FloatingActionButton(
        //button to add a new question
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          setState(() {
            editFlag = false;
            requiredFlag = false;
            editAndAdd();
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  showQuesAns({String? question, String? answer}) {
    //to show answer of selected flashcard
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Question: ${question!}",
          style: const TextStyle(fontSize: 20),
        ),
        content: Text(
          "Answer: ${answer!}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Close"),
            ),
          ),
        ],
      ),
    );
  }

  deleteQuesAns(int index) {
    //will delete the question from the list
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Do you want to delete the question?",
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("No"),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                questionList.removeAt(index);
              });
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Yes"),
            ),
          ),
        ],
      ),
    );
  }

  Widget showQuestionList() {
    //to show flashcards to user
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: questionList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showQuesAns(
                      question: questionList[index]["question"],
                      answer: questionList[index]["answer"]);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: Color.fromRGBO(0, 0, 0, 0.25))
                    ],
                    border: Border.all(
                        color: const Color.fromRGBO(217, 217, 217, 0.4667),
                        width: 0.5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${1 + index}) ${questionList[index]['question']!}",
                              style: GoogleFonts.poppins(
                                  color: const Color.fromRGBO(141, 141, 141, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _ansController.clear;
                                        _questionController.clear;
                                        editFlag = true;
                                        requiredFlag = false;
                                        editAndAdd(
                                            questionNo: index,
                                            ques: questionList[index]
                                                ["question"],
                                            ans: questionList[index]["answer"]);
                                      });
                                    },
                                    child: const Icon(Icons.edit)),
                              ),
                              const SizedBox(
                                height: 0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        deleteQuesAns(index);
                                      });
                                    },
                                    child: const Icon(Icons.delete)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
