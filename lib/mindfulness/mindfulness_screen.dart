import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_13_priolearn/get_favourations/question_page.dart';
import 'package:group_13_priolearn/mindfulness/mood_check.dart';
import 'package:group_13_priolearn/models/question_model.dart';
import 'package:group_13_priolearn/utils/bottom_app_bar.dart';
import 'package:provider/provider.dart';

class MindfulnessScreen extends StatefulWidget {
  @override
  _MindfulnessScreenState createState() => _MindfulnessScreenState();
}

class _MindfulnessScreenState extends State<MindfulnessScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  String _quote = "";
  String _author = "";

  @override
  void initState() {
    super.initState();
    _fetchRandomQuote();
  }

  Future<void> _fetchRandomQuote() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('quotes').get();
      if (querySnapshot.docs.isNotEmpty) {
        var randomIndex = Random().nextInt(querySnapshot.docs.length);
        var randomDoc = querySnapshot.docs[randomIndex];
        setState(() {
          _quote = randomDoc['quote'];
          _author = randomDoc['author'];
        });
      }
    } catch (e) {
      setState(() {
        _quote =
            "Keep your face always toward the sunshine, and shadows will fall behind you.";
        _author = "Walt Whitman";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Mindfulness',
          style: TextStyle(color: Color(0xFF4169E1), fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Quote",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4169E1),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    _quote,
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _author,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView(
                children: [
                  OptionButton(
                    icon: Icons.sentiment_very_satisfied,
                    text: 'Make me happy',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => QuestionModel(),
                            child: QuestionPage(),
                          ),
                        ),
                      );
                    },
                  ),
                  OptionButton(
                    icon: Icons.star,
                    text: 'Make me proud',
                    onPressed: () {
                      // Add your onPressed functionality here
                    },
                  ),
                  OptionButton(
                    icon: Icons.emoji_emotions,
                    text: 'Check my mood',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StressQuestionsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const OptionButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 40, color: Color(0xFF4169E1)),
        label: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(0xFF4169E1)),
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
