import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class TCABSSKPage extends StatefulWidget {
  const TCABSSKPage({super.key});
  static final List<String> title = [
    "A. Biodata",
    "B. Medical/Surgical History",
    "C. Oral Health",
    "D. Dietary",
    "E. Physical Activity Assessment",
    "F. Sexual/Reproductive Health",
    "G. Comsumption of Substances",
    "H. Dangerous/High Risk Activities",
    "I. Spirituality",
    "J. Mental Health Assessment",
    "K. Abuse History",
  ];

  @override
  State<TCABSSKPage> createState() => _TCABSSKPageState();
}

class _TCABSSKPageState extends State<TCABSSKPage> {
  final user = FirebaseAuth.instance.currentUser!;

  int section = 0;
  ScrollController listScrollController = ScrollController();

  Map<String, dynamic> values = {
    'a1': 'u',
    'a2': 'u',
    'a3': 'u',
    'a4': 'u',
    'a5': 'u', //a5 == "Others" => check a5ii
    'a5ii': 'u',
    'a6': 'u',
    'a7': 'u',
    'a8': 'u', //a8 == "working" => check a8i elif (a8 == "school") check a8ii
    'a8i': 'u',
    'a8ii': 'u',
    'a9':
        'u', //a9 =="married" => check a9i elif (a9 == "widow/widower") check a9ii
    'a9i': 'u',
    'a9ii': 'u',
    'a10': 'u',
    'a11a': 'u',
    'a11b': 'u',
    'a12': 'u',
    'a13': 'u',
    'b1ai': 'n',
    'b1aii': 'n',
    'b1bi': 'n',
    'b1bii': 'n',
    'b1ci': 'n',
    'b1cii': 'n',
    'b1di': 'n',
    'b1dii': 'n',
    'b1ei': 'n',
    'b1eii': 'n',
    'b1fi': 'n',
    'b1fii': 'n',
    'b2': 'u',
    'b3a': 'u',

    'b3b': 'u',
    'b3bi': 'u', // if b3b yes
    'b4': 'u',
    'b4i': 'u', //if b4 yes
    'c1': 'u',
    'd1a': 'u',
    'd1b': 'u',
    'd1c': 'u',
    'd2a': 'u',
    'd2b': 'u',
    'd2c': 'u',
    'd2d': 'u',
    'd2e': 'u',
    'd3': 'u',
    'e1': 'u',
    'e2': 'u',
    'f1a': 'u',
    'f1b': 'u',
    'f1c': 'u',
    'f1d': 'u',
    'f1di': 'u', // if f1d yes
    'f2a': 'u',
    'f2b': 'u',
    'f3': 'u',
    'f4': 'u',
    'f5': 'u',
    'f6': 'u',
    'f7a': 'u',
    'f7b': 'u',
    'f7c': 'u',
    'f8': 'u',
    'f9': 'u',
    'f10': 'u',
    'f11': 'u',
    'f12': 'u',
    'g1a': 'u',
    'g1b': 'u',
    'g1c': 'u',
    'g1d': 'u',
    'g1di': 'u', //if g1d yes
    'h1a': 'u',
    'h1b': 'u',
    'h1c': 'u',
    'h1d': 'u',
    'h2a': 'u',
    'h2b': 'u',
    'h2c': 'u',
    'h2d': 'u',
    'h2e': 'u',
    'h2f': 'u',
    'i1': 'u',
    'j1a': 'u',
    'j1b': 'u',
    'j1c': 'u',
    'j1d': 'u',
    'j1e': 'u',
    'j1f': 'u',
    'j1g': 'u',
    'j1h': 'u',
    'j2': 'u',
    'j3a': 'u',
    'j3b': 'u',
    'j3c': 'u',
    'j3d': 'u',
    'j3e': 'u',
    'j3f': 'u',
    'j3g': 'u',
    'k1': 'u',
  };

  changeValues(name, value) {
    values[name] = value;
  }

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<Set<Map<String, dynamic>>> questions = [
      {
        {
          "text": "Full Name",
          "child": MyTextField(name: 'a1', callback: changeValues)
        },
        {
          "text": "Gender",
          "child": FormBuilderRadioGroup(
              onChanged: (value) {
                changeValues("a2", value);
              },
              validator: (value) {
                if (value != 'Male' && value != 'Female') {
                  return 'Required';
                }
              },
              name: "a2",
              wrapAlignment: WrapAlignment.start,
              wrapSpacing: 50,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                  value: 'Male',
                ),
                FormBuilderFieldOption(
                  value: 'Female',
                )
              ]),
        },
        {
          "text": "Date of Birth",
          "child": MyTextField(
            name: 'a3',
            callback: changeValues,
            hinttext: 'DD/MM/YYYY',
          )
        },
        {
          "text": "IC / Passport Number",
          "child": MyTextField(
            name: 'a4',
            callback: changeValues,
          )
        },
        {
          "text": "Citizenship",
          "child": Column(
            children: [
              FormBuilderRadioGroup(
                  onChanged: (value) {
                    changeValues("a5", value);
                  },
                  validator: (value) {
                    if (values['a5'] == "u") {
                      return 'Required';
                    }
                  },
                  name: "a5",
                  wrapAlignment: WrapAlignment.start,
                  wrapSpacing: 100,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  options: <FormBuilderFieldOption>[
                    FormBuilderFieldOption(
                      value: 'Malaysia',
                    ),
                    FormBuilderFieldOption(
                      value: 'Other',
                      child: SizedBox(
                        width: 200,
                        child: FormBuilderTextField(
                          onChanged: (value) {
                            changeValues("a5ii", value);
                          },
                          validator: (value) {
                            if (values['a5'] == 'Other' &&
                                (values['a5ii'] == 'u' ||
                                    values['a5ii'] == '')) {
                              return 'Required';
                            }
                          },
                          style: TextStyle(fontSize: 14),
                          name: '',
                          decoration: InputDecoration(
                            hintText: "Others (Please state)",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                          ),
                        ),
                      ),
                    )
                  ]),
            ],
          )
        },
        {
          "text": "Race",
          "child": FormBuilderRadioGroup(
              onChanged: (value) {
                changeValues("a6", value);
              },
              validator: (value) {
                if (value == null) {
                  return 'Required';
                }
              },
              name: "a6",
              wrapAlignment: WrapAlignment.start,
              wrapSpacing: 100,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                  value: 'Malay',
                ),
                FormBuilderFieldOption(
                  value: 'Native Sabah',
                ),
                FormBuilderFieldOption(
                  value: 'Chinese',
                ),
                FormBuilderFieldOption(
                  value: 'Native Sarawak',
                ),
                FormBuilderFieldOption(
                  value: 'Indian',
                ),
                FormBuilderFieldOption(
                  value: 'Orang Asli',
                ),
                FormBuilderFieldOption(
                  value: 'Others',
                ),
              ]),
        },
        {
          "text": "Level of Education",
          "child": FormBuilderRadioGroup(
              validator: (value) {
                if (value == null) {
                  return 'Required';
                }
              },
              onChanged: (value) {
                changeValues("a7", value);
              },
              name: "a7",
              wrapAlignment: WrapAlignment.start,
              wrapSpacing: 100,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                  value: 'Primary',
                ),
                FormBuilderFieldOption(
                  value: 'Secondary',
                ),
                FormBuilderFieldOption(
                  value: 'Tertiary',
                ),
                FormBuilderFieldOption(
                  value: 'No proper education',
                ),
              ]),
        },
        {
          "text": "Employment",
          "child": FormBuilderRadioGroup(
              onChanged: (value) {
                changeValues("a8", value);
              },
              validator: (value) {
                if (values['a8'] == 'u') {
                  return 'Required';
                }
              },
              name: "a8",
              wrapAlignment: WrapAlignment.start,
              wrapRunAlignment: WrapAlignment.start,
              wrapSpacing: 300,
              wrapRunSpacing: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                    value: 'working',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Working, at: "),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 150,
                          child: FormBuilderTextField(
                            validator: (value) {
                              if (values['a8'] == 'working' &&
                                  (values['a8i'] == 'u' ||
                                      values['a8i'] == '')) {
                                return 'Required';
                              }
                            },
                            onChanged: (value) {
                              changeValues("a8i", value);
                            },
                            style: TextStyle(fontSize: 14),
                            name: '',
                            decoration: InputDecoration(
                              hintText: "Your workplace",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    )),
                FormBuilderFieldOption(
                    value: 'studying',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Still studying, at: "),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 150,
                          child: FormBuilderTextField(
                            onChanged: (value) {
                              changeValues("a8ii", value);
                            },
                            validator: (value) {
                              if (values['a8'] == 'studying' &&
                                  (values['a8ii'] == 'u' ||
                                      values['a8ii'] == '')) {
                                return 'Required';
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            name: '',
                            decoration: InputDecoration(
                              hintText: "Your school",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    )),
                FormBuilderFieldOption(
                  value: 'Not working',
                ),
              ]),
        },
        {
          "text": "Marriage Status",
          "child": FormBuilderRadioGroup(
              onChanged: (value) {
                changeValues("a9", value);
              },
              name: "a9",
              wrapAlignment: WrapAlignment.start,
              wrapRunAlignment: WrapAlignment.start,
              wrapSpacing: 300,
              wrapRunSpacing: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                  value: 'Single',
                ),
                FormBuilderFieldOption(
                    value: 'married',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Married, no. of children: "),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 150,
                          child: FormBuilderTextField(
                            validator: (value) {
                              if (values['a9'] == 'married' &&
                                  (values['a9i'] == 'u' ||
                                      values['a9i'] == '')) {
                                return 'Required';
                              }
                            },
                            onChanged: (value) {
                              changeValues("a9i", value);
                            },
                            style: TextStyle(fontSize: 14),
                            name: '',
                            decoration: InputDecoration(
                              hintText: "No. of children",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    )),
                FormBuilderFieldOption(
                    value: 'widow',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Widow/widower, no. of children: "),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 150,
                          child: FormBuilderTextField(
                            validator: (value) {
                              if (values['a9'] == 'widow' &&
                                  (values['a9ii'] == 'u' ||
                                      values['a9ii'] == '')) {
                                return 'Required';
                              }
                            },
                            onChanged: (value) {
                              changeValues("a9ii", value);
                            },
                            style: TextStyle(fontSize: 14),
                            name: '',
                            decoration: InputDecoration(
                              hintText: "No. of children",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
        },
        {
          "text": "Home address",
          "child": MyTextField(
            name: 'a10',
            callback: changeValues,
          )
        },
        {
          "text": "Phone number",
          "child": Row(
            children: [
              Expanded(
                  flex: 8,
                  child: MyTextField(
                    name: 'a11a',
                    callback: changeValues,
                    hinttext: 'Home',
                  )),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                  flex: 8,
                  child: MyTextField(
                    name: 'a11b',
                    callback: changeValues,
                    hinttext: 'Mobile',
                  )),
            ],
          )
        },
        {
          "text": "Email",
          "child": MyTextField(
            name: 'a12',
            callback: changeValues,
            hinttext: 'e.g. johndoe@gmail.com',
          )
        },
        {
          "text": "Last Normal Menstrual Period (Female only)",
          "child": FormBuilderTextField(
            name: 'a13',
            validator: (value) {
              if (value == null && values['a2'] == "Female") {
                return 'Required';
              }
            },
            onSaved: (value) {
              setState(() {
                changeValues('a13', value);
              });
            },
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'DD/MM/YYYY',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10),
            ),
          )
        },
      }.toSet(),
      {
        {
          "text":
              "Do you or a family member suffer from the following diseases:",
          "child": Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 12,
                    child: SizedBox(),
                  ),
                  Expanded(
                      flex: 7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Yourself",
                            style: TextStyle(fontSize: 10),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              "Family",
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text("a."),
                    ),
                    Expanded(flex: 11, child: Text("Hypertension")),
                    Expanded(
                      flex: 7,
                      child: FormBuilderCheckboxGroup(
                          onChanged: (value) {
                            String first = "b1ai";
                            String second = "b1aii";
                            if (value!.contains(first)) {
                              changeValues(first, "y");
                            } else {
                              changeValues(first, "n");
                            }
                            if (value.contains(second)) {
                              changeValues(second, "y");
                            } else {
                              changeValues(second, "n");
                            }
                          },
                          name: "s",
                          wrapAlignment: WrapAlignment.spaceAround,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          options: <FormBuilderFieldOption>[
                            FormBuilderFieldOption(
                              value: 'b1ai',
                              child: SizedBox(),
                            ),
                            FormBuilderFieldOption(
                              value: 'b1aii',
                              child: SizedBox(),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFededeb),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: Text("b."),
                      ),
                      Expanded(flex: 11, child: Text("Diabetes")),
                      Expanded(
                        flex: 7,
                        child: FormBuilderCheckboxGroup(
                            onChanged: (value) {
                              String first = "b1bi";
                              String second = "b1bii";
                              if (value!.contains(first)) {
                                changeValues(first, "y");
                              } else {
                                changeValues(first, "n");
                              }
                              if (value.contains(second)) {
                                changeValues(second, "y");
                              } else {
                                changeValues(second, "n");
                              }
                            },
                            name: "s",
                            wrapAlignment: WrapAlignment.spaceAround,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            options: <FormBuilderFieldOption>[
                              FormBuilderFieldOption(
                                value: 'b1bi',
                                child: SizedBox(),
                              ),
                              FormBuilderFieldOption(
                                value: 'b1bii',
                                child: SizedBox(),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text("c."),
                    ),
                    Expanded(flex: 11, child: Text("Heart Disease")),
                    Expanded(
                      flex: 7,
                      child: FormBuilderCheckboxGroup(
                          onChanged: (value) {
                            String first = "b1ci";
                            String second = "b1cii";
                            if (value!.contains(first)) {
                              changeValues(first, "y");
                            } else {
                              changeValues(first, "n");
                            }
                            if (value.contains(second)) {
                              changeValues(second, "y");
                            } else {
                              changeValues(second, "n");
                            }
                          },
                          name: "s",
                          wrapAlignment: WrapAlignment.spaceAround,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          options: <FormBuilderFieldOption>[
                            FormBuilderFieldOption(
                              value: 'b1ci',
                              child: SizedBox(),
                            ),
                            FormBuilderFieldOption(
                              value: 'b1cii',
                              child: SizedBox(),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFededeb),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: Text("d."),
                      ),
                      Expanded(flex: 11, child: Text("Asthma")),
                      Expanded(
                        flex: 7,
                        child: FormBuilderCheckboxGroup(
                            onChanged: (value) {
                              String first = "b1di";
                              String second = "b1dii";
                              if (value!.contains(first)) {
                                changeValues(first, "y");
                              } else {
                                changeValues(first, "n");
                              }
                              if (value.contains(second)) {
                                changeValues(second, "y");
                              } else {
                                changeValues(second, "n");
                              }
                            },
                            name: "s",
                            wrapAlignment: WrapAlignment.spaceAround,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            options: <FormBuilderFieldOption>[
                              FormBuilderFieldOption(
                                value: 'b1di',
                                child: SizedBox(),
                              ),
                              FormBuilderFieldOption(
                                value: 'b1dii',
                                child: SizedBox(),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text("e."),
                    ),
                    Expanded(
                        flex: 11,
                        child: Text("Hereditary Disease (e.g. Thalassemia)")),
                    Expanded(
                      flex: 7,
                      child: FormBuilderCheckboxGroup(
                          onChanged: (value) {
                            String first = "b1ei";
                            String second = "b1eii";
                            if (value!.contains(first)) {
                              changeValues(first, "y");
                            } else {
                              changeValues(first, "n");
                            }
                            if (value.contains(second)) {
                              changeValues(second, "y");
                            } else {
                              changeValues(second, "n");
                            }
                          },
                          name: "s",
                          wrapAlignment: WrapAlignment.spaceAround,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          options: <FormBuilderFieldOption>[
                            FormBuilderFieldOption(
                              value: 'b1ei',
                              child: SizedBox(),
                            ),
                            FormBuilderFieldOption(
                              value: 'b1eii',
                              child: SizedBox(),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFededeb),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: Text("f."),
                      ),
                      Expanded(
                          flex: 11,
                          child:
                              Text("Contagious Disease (e.g. TB, Hepatitis)")),
                      Expanded(
                        flex: 7,
                        child: FormBuilderCheckboxGroup(
                            onChanged: (value) {
                              String first = "b1fi";
                              String second = "b1fii";
                              if (value!.contains(first)) {
                                changeValues(first, "y");
                              } else {
                                changeValues(first, "n");
                              }
                              if (value.contains(second)) {
                                changeValues(second, "y");
                              } else {
                                changeValues(second, "n");
                              }
                            },
                            name: "s",
                            wrapAlignment: WrapAlignment.spaceAround,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            options: <FormBuilderFieldOption>[
                              FormBuilderFieldOption(
                                value: 'b1fi',
                                child: SizedBox(),
                              ),
                              FormBuilderFieldOption(
                                value: 'b1fii',
                                child: SizedBox(),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        },
        {
          "text":
              "Do you have a family member who died suddenly? (Male before 45 years, Female before 50 years)",
          "child": singleyesorno(name: "b2", callback: changeValues)
        },
        {
          "text": "Have you ever...",
          "child": Column(children: [
            const yesno(),
            ListQuestion(
                index: 1,
                text: "...experienced a severe drug allergy?",
                name: "b3a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "...gone through any form of surgery?",
                name: "b3b",
                callback: changeValues),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    child: FormBuilderTextField(
                      onChanged: (value) {
                        changeValues("b3bi", value);
                      },
                      validator: (value) {
                        if (values['b3b'] != 'n') {
                          return 'Required';
                        }
                      },
                      style: TextStyle(fontSize: 14),
                      name: '',
                      decoration: InputDecoration(
                          hintText: "If yes, please state...",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ])
        },
        {
          "text": "Are you suffering from any other diseases?",
          "child": Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              singleyesorno(name: "b4", callback: changeValues),
              SizedBox(
                width: 200,
                height: 30,
                child: FormBuilderTextField(
                  onChanged: (value) {
                    changeValues("b4i", value);
                  },
                  style: TextStyle(fontSize: 14),
                  name: '',
                  decoration: InputDecoration(
                      hintText: "If yes, please state...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 10)),
                ),
              ),
            ],
          )
        },
      }.toSet(),
      {
        {
          "text": "I have oral health problems (e.g. teeth, gum) ?",
          "child": singleyesorno(name: "c1", callback: changeValues)
        },
      }.toSet(),
      {
        {
          "text":
              "I eat according to the set eating time period below every day:",
          "child": Column(children: [
            const yesno(),
            ListQuestion(
                index: 1,
                text: "Breakfast",
                name: "d1a",
                callback: changeValues),
            ListQuestion(
                index: 2, text: "Lunch", name: "d1b", callback: changeValues),
            ListQuestion(
                index: 3, text: "Dinner", name: "d1c", callback: changeValues),
          ])
        },
        {
          "text": "Do you consume all kinds of food including:",
          "child": Column(children: [
            const yesno(),
            ListQuestion(
                index: 1,
                text: "Grain food (e.g. rice, noodles or bread)",
                name: "d2a",
                callback: changeValues),
            ListQuestion(
                index: 2, text: "Fruits", name: "d2b", callback: changeValues),
            ListQuestion(
                index: 3,
                text: "Vegetable",
                name: "d2c",
                callback: changeValues),
            ListQuestion(
                index: 4,
                text: "Milk and dairy products (e.g. cheese, yoghurt)",
                name: "d2d",
                callback: changeValues),
            ListQuestion(
                index: 5,
                text: "Beef / chicken / eggs / fish / seafood or nuts",
                name: "d2e",
                callback: changeValues),
          ])
        },
        {
          "text": "I think that I am skinny, normal or fat?",
          "child": Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: 250,
                  child: FormBuilderRadioGroup(
                      onChanged: (value) {
                        changeValues("d3", value);
                      },
                      validator: (value) {
                        if (value == "u") {
                          return 'Required';
                        }
                      },
                      name: "s",
                      wrapAlignment: WrapAlignment.start,
                      wrapSpacing: 50,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      options: <FormBuilderFieldOption>[
                        FormBuilderFieldOption(
                          value: 'Skinny',
                        ),
                        FormBuilderFieldOption(
                          value: 'Normal',
                        ),
                        FormBuilderFieldOption(
                          value: 'Fat',
                        ),
                      ]),
                ),
              )
            ],
          )
        },
      }.toSet(),
      {
        {
          "text": "I practise physical activities and exercises?",
          "child": singleyesorno(name: "e1", callback: changeValues)
        },
        {
          "text":
              "I exercise at least 150 minutes every week (e.g. speedwalking 30 minutes for at least 5 times a week)",
          "child": singleyesorno(name: "e2", callback: changeValues)
        },
      }.toSet(),
      {
        {
          "text": "I had experienced problems as below:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "Pus or odour smell from private parts",
                name: "f1a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "Itchiness or scadies on private parts",
                name: "f1b",
                callback: changeValues),
            ListQuestion(
                index: 3,
                text:
                    "Painfulness on pubic hair or private parts when urinating",
                name: "f1c",
                callback: changeValues),
            ListQuestion(
                index: 4,
                text: "Other problems on private parts",
                name: "f1d",
                callback: changeValues),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    height: 30,
                    child: FormBuilderTextField(
                      onChanged: (value) {
                        changeValues("f1di", value);
                      },
                      style: TextStyle(fontSize: 14),
                      name: '',
                      decoration: InputDecoration(
                          hintText: "If yes, please state...",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ])
        },
        {
          "text": "I have done the following:",
          "child": Column(children: [
            const yesno(),
            ListQuestion(
                index: 1,
                text: "Consumed pornographic material",
                name: "f2a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "Masturbate (Sexually stimulated myself)",
                name: "f2b",
                callback: changeValues),
          ])
        },
        {
          "text": "I have the desire to change sex?",
          "child": singleyesorno(name: "f3", callback: changeValues)
        },
        {
          "text": "I have the desire to have sex with the same gender?",
          "child": singleyesorno(name: "f4", callback: changeValues)
        },
        {
          "text": "I have a lover or partner?",
          "child": singleyesorno(name: "f5", callback: changeValues)
        },
        {
          "text": "I had sex? (If no, skip to next section)",
          "child": singleyesorno(name: "f6", callback: changeValues)
        },
        {
          "text": "I:",
          "child": Column(children: [
            const yesno(),
            ListQuestion(
                index: 1,
                text: "Constantly change partners",
                name: "f7a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "Have sex with the same gender",
                name: "f7b",
                callback: changeValues),
            ListQuestion(
                index: 3,
                text: 'Have "unnatural" sex',
                name: "f7c",
                callback: changeValues),
          ])
        },
        {
          "text": "I/My partner uses condom when having sex.",
          "child": singleyesorno(
            name: "f8",
            callback: changeValues,
          )
        },
        {
          "text": "I/My partner uses pregnancy prevention methods.",
          "child": singleyesorno(
            name: "f9",
            callback: changeValues,
          )
        },
        {
          "text": "I feel that my belly is getting bigger.",
          "child": singleyesorno(
            name: "f10",
            callback: changeValues,
          )
        },
        {
          "text": "I have experienced miscarriage.",
          "child": singleyesorno(
            name: "f11",
            callback: changeValues,
          )
        },
        {
          "text": "Menarche (Period for the first time)",
          "child": SizedBox(
            height: 40,
            child: FormBuilderTextField(
              name: 'menarche',
              onChanged: (value) {
                changeValues("f12", value);
              },
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: "Date / Year",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
          )
        },
      }.toSet(),
      {
        {
          "text": "Do you consume any of the substances below:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "Cigarettes / Tobacco / Vape",
                name: "g1a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "Prohibited drugs",
                name: "g1b",
                callback: changeValues),
            ListQuestion(
                index: 3, text: "Alcohol", name: "g1c", callback: changeValues),
            ListQuestion(
                index: 4,
                text: "Other substances or medicine",
                name: "g1d",
                callback: changeValues),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    height: 30,
                    child: FormBuilderTextField(
                      onChanged: (value) {
                        changeValues("g1di", value);
                      },
                      style: TextStyle(fontSize: 14),
                      name: '',
                      decoration: InputDecoration(
                          hintText: "If yes, please state...",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ])
        },
      }.toSet(),
      {
        {
          "text":
              "Parents/teachers are worried about my behaviour because they assume that I:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: " am irritable",
                name: "h1a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "am a coward",
                name: "h1b",
                callback: changeValues),
            ListQuestion(
                index: 3,
                text: "am prone to worrying",
                name: "h1c",
                callback: changeValues),
            ListQuestion(
                index: 4,
                text: "don't make friends and like to be alone",
                name: "h1d",
                callback: changeValues),
          ])
        },
        {
          "text": "At often times, I am involved in the activities below:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "Bullying",
                name: "h2a",
                callback: changeValues),
            ListQuestion(
                index: 2, text: "Fights", name: "h2b", callback: changeValues),
            ListQuestion(
                index: 3,
                text: "Skip school",
                name: "h2c",
                callback: changeValues),
            ListQuestion(
                index: 4,
                text: "Destroy or mutilate public property",
                name: "h2d",
                callback: changeValues),
            ListQuestion(
                index: 5,
                text: "Drive/ride dangerously",
                name: "h2e",
                callback: changeValues),
            ListQuestion(
                index: 6,
                text: "Ride on a motorcycle without wearing a safety helmet",
                name: "h2f",
                callback: changeValues),
          ])
        },
      }.toSet(),
      {
        {
          "text": "Religion is important in my life.",
          "child": singleyesorno(name: "i1", callback: changeValues),
        },
      }.toSet(),
      {
        {
          "text": "If I have any personal problems I always report to",
          "child": Row(
            children: [
              Expanded(
                child: FormBuilderCheckboxGroup(
                    onChanged: (value) {
                      List list = [
                        "j1a",
                        "j1b",
                        "j1c",
                        "j1d",
                        "j1e",
                        "j1f",
                        "j1g",
                        "j1h"
                      ];
                      for (String item in list) {
                        if (value!.contains(item)) {
                          changeValues(item, "y");
                        } else {
                          changeValues(item, "n");
                        }
                      }
                    },
                    name: "j1",
                    decoration: InputDecoration(border: InputBorder.none),
                    options: [
                      FormBuilderFieldOption(
                        value: "j1a",
                        child: Text("Mother"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1b",
                        child: Text("Father"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1c",
                        child: Text("Siblings"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1d",
                        child: Text("Friends"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1e",
                        child: Text("Teacher"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1f",
                        child: Text("Counsellor"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1g",
                        child: Text("Partner"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1h",
                        child: Text("Others"),
                      ),
                    ]),
              )
            ],
          ),
        },
        {
          "text": "I am a good person myself.",
          "child": singleyesorno(name: "j2", callback: changeValues),
        },
        {
          "text": "I have the problems below:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text:
                    "Prone to worrying/depression for extended periods for more than 2 weeks",
                name: "j3a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "Insomnia",
                name: "j3b",
                callback: changeValues),
            ListQuestion(
                index: 3,
                text: "Having no appetite",
                name: "j3c",
                callback: changeValues),
            ListQuestion(
                index: 4,
                text: "Thinks that life is meaningless",
                name: "j3d",
                callback: changeValues),
            ListQuestion(
                index: 5,
                text: "Hard to calm down",
                name: "j3e",
                callback: changeValues),
            ListQuestion(
                index: 6,
                text: "Always anxious and worried",
                name: "j3f",
                callback: changeValues),
            ListQuestion(
                index: 7,
                text: "Had the thought to end life",
                name: "j3g",
                callback: changeValues),
          ])
        },
      }.toSet(),
      {
        {
          "text":
              "Have you ever get bullied or abused, whether emotionally, physically or sexually?",
          "child": singleyesorno(name: "k1", callback: changeValues),
        },
      }.toSet(),
    ];
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd \n h:mm:ss a').format(now);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          toolbarHeight: 0,
          bottom: MyTabBar(
            child: TabBar(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.15,
                  0,
                  MediaQuery.of(context).size.width * 0.15,
                  0),
              tabs: [
                Tab(text: "TCA"),
                Tab(text: "BSSK"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            const Placeholder(),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: section < TCABSSKPage.title.length
                  ? Form(
                      key: _formKey,
                      child: ListView(
                        controller: listScrollController,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontFamily: "LeagueSpartan",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "This form consists of 11 sections "),
                                        TextSpan(
                                            text: "(A - K).",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ]),
                                ),
                                Text(
                                  "Please fill in your information in each section accordingly.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "LeagueSpartan",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02,
                                    right: MediaQuery.of(context).size.width *
                                        0.02),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 4, right: 4),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color(0xffd9d9d9),
                                                  width: 3)),
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 30, left: 10, right: 20),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    questions[section].length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 24,
                                                            child: Text(
                                                                "${index + 1})"),
                                                          ),
                                                          Expanded(
                                                            child: Text(questions[
                                                                        section]
                                                                    .elementAt(
                                                                        index)[
                                                                'text']),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                        child: questions[
                                                                section]
                                                            .elementAt(
                                                                index)['child'],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          )),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFededeb),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(TCABSSKPage.title[section]),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20,
                                    left:
                                        MediaQuery.of(context).size.width * 0.1,
                                    right: MediaQuery.of(context).size.width *
                                        0.1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 120,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        fit: StackFit.expand,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              onTap: () {
                                                if (listScrollController
                                                    .hasClients) {
                                                  final position =
                                                      listScrollController
                                                          .position
                                                          .minScrollExtent;
                                                  listScrollController
                                                      .animateTo(
                                                    position,
                                                    duration:
                                                        Duration(seconds: 1),
                                                    curve: Curves.easeInOut,
                                                  );
                                                }
                                                if (!_formKey.currentState!
                                                    .validate()) {
                                                  return;
                                                }

                                                _formKey.currentState!.save();
                                                setState(() {
                                                  section += 1;

                                                  if (section == 11) {
                                                    final bsskRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(user.uid);
                                                    bsskRef.update({
                                                      'BSSK': values,
                                                    });
                                                  }
                                                });
                                              },
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        section == 10
                                                            ? "Submit"
                                                            : "Next",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "LeagueSpartan",
                                                            fontSize: 16,
                                                            color: Colors.grey),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 10.0,
                                                        color: Color.fromARGB(
                                                            255, 150, 111, 214),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0, color: Color(0xffd9d9d9)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "lib/assets/images/thumbsup.png",
                                  width: 200,
                                  height: 200,
                                ),
                                Text(
                                  "Your response on",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "LeagueSpartan",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                    formattedDate,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Poppins",
                                        fontSize: 20,
                                        color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "has been recorded.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "LeagueSpartan",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Thanks for filling up the form!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "LeagueSpartan",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: 150,
                                child: Stack(
                                  alignment: Alignment.center,
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Color(0xff966fd6),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(40),
                                        onTap: () {
                                          if (listScrollController.hasClients) {
                                            final position =
                                                listScrollController
                                                    .position.minScrollExtent;
                                            listScrollController.animateTo(
                                              position,
                                              duration: Duration(seconds: 1),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                          ;
                                          setState(() {
                                            section = 0;
                                          });
                                        },
                                        child: const Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Start again",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "LeagueSpartan",
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class yesno extends StatelessWidget {
  const yesno({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: SizedBox(),
        ),
        Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text("Yes"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text("No"),
                )
              ],
            ))
      ],
    );
  }
}