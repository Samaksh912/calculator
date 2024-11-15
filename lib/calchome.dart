//todo: add functionalities such calculating currency length volume area etc.
//todo: add sin cos tan etc functions as well
//todo: try to add a function to make it a floating window
//todo: add a history function aswell


import 'package:expressions/expressions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Calchome extends StatefulWidget {
  const Calchome({super.key});

  @override
  State<Calchome> createState() => _CalchomeState();
}

class _CalchomeState extends State<Calchome> {

  String equation = "";
  String result = "";

  //button press handling method

  void buttonpressed(String buttontext){
    setState(() {
      if (buttontext == "AC"){
        equation = "";
        result = "";
      }
      else if (buttontext == "=") {
        try {
          result = evaluateExpression(equation).toString();
        } catch (e) {
          result = "error";
        }
      }
      else if (buttontext == "%") {
        // Handle percentage calculation
        if (equation.isNotEmpty && !equation.endsWith("%")) {
          equation += "/100"; // Convert the percentage to a decimal form
        }
      }

        else if(buttontext == "⌫" ){
          equation = equation.length > 1 ? equation.substring(0,equation.length-1) : "";


      }
        else{
          equation += buttontext;
      }


    });
  }

// This method evaluates the mathematical expression using the expressions package
  String evaluateExpression(String expression) {
    try {
      // Print the equation for debugging purposes
      if (kDebugMode) {
        print("Evaluating expression: $expression");
      }

      // Check if the expression is valid and non-empty
      if (expression.isEmpty) return "0";

      final expr = Expression.parse(expression);  // Parse the expression string
      const evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expr, {});  // Evaluate the expression

      // If the result is a valid number, return it as a string
      if (result is double || result is int) {
        return result.toString();
      } else {
        return "Error";  // Handle any unexpected result type
      }
    } catch (e) {
      // Log any errors for debugging
      if (kDebugMode) {
        print("Error evaluating expression: $e");
      }
      return "Error";  // Return an error message if evaluation fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,



        title: const Text(
          "CALCULATOR",
          style: TextStyle(color: Colors.orangeAccent),

        ),
        centerTitle: true,

      ),
      body: SafeArea(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 60.0,bottom: 0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(result,
                            style:
                                const TextStyle(color: Colors.white, fontSize: 48)),
                        Text(equation,
                            style: const TextStyle(
                                color: Colors.white38, fontSize: 30)),
                      ],
                    ))),
            const SizedBox(height: 20,),
            Expanded(
              child: GridView.builder(
                itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                  Color buttoncolor = Colors.white;
                  String buttontext = "0";
                  IconData? buttonicon;
                  switch(index) {
                    case 0:
                      buttontext = "AC";
                      buttoncolor = Colors.white12;
                      break;
                    case 1:
                      buttontext = "%";
                      buttoncolor = Colors.white12;
                      buttonicon = CupertinoIcons.percent;
                      break;
                    case 2:
                      buttontext = "⌫";
                      buttoncolor = Colors.white12;
                      buttonicon = CupertinoIcons.delete_left;
                      break;
                    case 3:
                      buttontext = "/";
                      buttoncolor = Colors.white12;
                      buttonicon = CupertinoIcons.divide;
                      break;
                    case 4:
                      buttontext = "7";
                      buttoncolor = Colors.white30;
                      break;
                    case 5:
                      buttontext = "8";
                      buttoncolor = Colors.white30;
                      break;
                    case 6:
                      buttontext = "9";
                      buttoncolor = Colors.white30;
                      break;
                    case 7:
                      buttontext = "*";
                      buttoncolor = Colors.white12;
                      buttonicon = CupertinoIcons.multiply;
                      break;
                    case 8:
                      buttontext = "4";
                      buttoncolor = Colors.white30;
                      break;
                    case 9:
                      buttontext = "5";
                      buttoncolor = Colors.white30;
                      break;
                      case 10:
                    buttontext = "6";
                    buttoncolor = Colors.white30;
                    break;
                    case 11:
                      buttontext = "-";
                      buttoncolor = Colors.white12;
                      buttonicon = CupertinoIcons.minus;
                      break;
                    case 12:
                      buttontext = "1";
                      buttoncolor = Colors.white30;

                      break;
                    case 13:
                      buttontext = "2";
                      buttoncolor = Colors.white30;
                      break;
                    case 14:
                      buttontext = "3";
                      buttoncolor = Colors.white30;
                      break;
                    case 15:
                      buttontext = "+";
                      buttoncolor = Colors.white12;
                      buttonicon = CupertinoIcons.plus;
                      break;
                    case 16:
                      buttontext = "00";
                      buttoncolor = Colors.white30;
                      break;
                    case 17:
                      buttontext = "0";
                      buttoncolor = Colors.white30;
                      break;
                    case 18:
                      buttontext = ".";
                      buttoncolor = Colors.white30;

                      break;
                    case 19:
                      buttontext = "=";
                      buttoncolor = Colors.orange;
                      buttonicon = CupertinoIcons.equal;
                      break;






                  }

                    return GestureDetector(
                      onTap: () => buttonpressed(buttontext),
                      child: Container(
                        margin: const EdgeInsets.all(6), decoration: BoxDecoration(
                        color: buttoncolor,
                        shape: BoxShape.circle,

                      ),
                        child: Center(

                          child:buttonicon == null? Text(buttontext,style: const TextStyle(color: Colors.white,fontSize: 25),
                          )
                          : Icon(buttonicon,color: Colors.white,size: 25,)
                        ),
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
