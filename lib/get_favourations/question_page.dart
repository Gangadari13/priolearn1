import 'package:flutter/material.dart';
import 'package:group_13_priolearn/get_secondary_information/summary_page.dart';
import 'package:group_13_priolearn/models/question_model.dart';
import 'package:provider/provider.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final TextEditingController textController = TextEditingController();
  
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionModel = Provider.of<QuestionModel>(context);
    final question = questionModel.questions[questionModel.currentPage];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${questionModel.currentPage+1}'),
      ),
      body: Column(
        children: [
          Text(question.question),
          SizedBox(height: 30,),
          TextField(
            controller: textController,
            onChanged: (value){
              questionModel.updateAnswer(questionModel.currentPage, value);
            },
          ),
          LinearProgressIndicator(
            value: (questionModel.currentPage+1/questionModel.questions.length),
          ),
          ElevatedButton(
            onPressed:(){
              if (questionModel.currentPage < questionModel.questions.length) {
                questionModel.nextPage();
                textController.clear();
              } else {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context)=>SummaryPage()));
              }
            }, 
            child: Text("Next")
          )
        ],
      ),
    );
  }
}
