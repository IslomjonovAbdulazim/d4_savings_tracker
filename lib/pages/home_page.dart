import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> amounts = [];
  List<DateTime> dateTimes = [];
  List<String> currency = [];
  int total = 0;
  int uzsTotal = 0;
  int usdTotal = 0;

  final key = GlobalKey<FormState>();
  final focus = FocusNode();
  final controller = TextEditingController();
  String currentCurrency = "UZS";

  void calculate() {
    for (var i = 0; i < amounts.length; i++) {
      if (currency[i] == "UZS") {
        total += amounts[i];
        uzsTotal += amounts[i];
      } else if (currency[i] == "USD") {
        total += (amounts[i] * 12900);
        usdTotal += amounts[i];
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: key,
            child: Column(
              children: [
                // Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${NumberFormat.decimalPattern().format(total)} UZS",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${NumberFormat.decimalPattern().format(usdTotal)} USD",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "  ●  ",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "${NumberFormat.decimalPattern().format(uzsTotal)} UZS",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // History
                SizedBox(height: 20),
                Expanded(
                  child: SizedBox(),
                ),
                SizedBox(height: 20),

                // New Sum
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        focusNode: focus,
                        keyboardType: TextInputType.number,
                        onTapOutside: (value) => focus.unfocus(),
                        onChanged: (value) => key.currentState!.validate(),
                        decoration: InputDecoration(
                          hintText: "Summa...",
                        ),
                        validator: (value) {
                          int? sum = int.tryParse(value ?? "");

                          if (value?.isEmpty == true) {
                            return null;
                          }

                          if (sum == null) {
                            return "Noto'g'ri Formatdagi Summa";
                          }

                          if (currentCurrency == "UZS") {
                            if ((sum >= 5000 && sum <= 10000000) == false) {
                              return "Min 5K UZS, Max 10M UZS";
                            }
                          }

                          if (currentCurrency == "USD") {
                            if ((sum >= 5 && sum <= 1000) == false) {
                              return "Min 5 USD, Max 1000 USD";
                            }
                          }
                        },
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (currentCurrency == "UZS") {
                          currentCurrency = "USD";
                        } else if (currentCurrency == "USD") {
                          currentCurrency = "UZS";
                        }
                        key.currentState!.validate();
                        setState(() {});
                      },
                      child: Text(currentCurrency),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
