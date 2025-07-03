import 'package:flutter/material.dart';

class SkinHealthChecker extends StatefulWidget {
  const SkinHealthChecker({super.key});

  @override
  State<SkinHealthChecker> createState() => _SkinHealthCheckerState();
}

class _SkinHealthCheckerState extends State<SkinHealthChecker> {
  final List<String> questions = [
    "Do you have red or rough patches on your skin?",
    "Do you experience frequent itching?",
    "Is your skin peeling or cracking?",
    "Have you noticed changes in your skin color?",
    "Does your skin react negatively to skincare products?"
  ];

  List<String?> answers = List.filled(5, null);
  final Color mainColor = const Color(0xFF017CFD);

  void calculateResult() async {
    if (answers.contains(null)) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            "Incomplete Answers",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            "Please answer all the questions first.",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "OK",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);

    int yesCount = answers.where((ans) => ans == 'Yes').length;
    String result;
    if (yesCount >= 4) {
      result =
          "⚠️ Strong signs may indicate a skin condition like eczema or psoriasis.\nPlease consult a dermatologist.";
    } else if (yesCount >= 2) {
      result =
          "🔍 Some symptoms detected that may relate to dryness or mild irritation.\nKeep monitoring your skin.";
    } else {
      result =
          "✅ Your skin appears to be in good condition!\nKeep taking care of it.";
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Skin Health Result",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Text(
          result,
          style: const TextStyle(fontSize: 19),
        ),
        actions: [
          TextButton(
            child: const Text(
              "OK",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  void resetAnswers() {
    setState(() {
      answers = List.filled(questions.length, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF2F7FD);
    final Color textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Skin Health Checker"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Answer the following questions to evaluate your overall skin health.",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    color: cardColor,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.health_and_safety_outlined, color: mainColor),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  questions[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: ["Yes", "Sometimes", "No"]
                                .map(
                                  (option) => RadioListTile<String>(
                                    title: Text(option, style: TextStyle(color: textColor)),
                                    value: option,
                                    groupValue: answers[index],
                                    activeColor: mainColor,
                                    onChanged: (value) {
                                      setState(() {
                                        answers[index] = value;
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: calculateResult,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                  ),
                  child: const Text(
                    "Check My Skin Health",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: resetAnswers,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: mainColor, width: 2.5),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: const Text(
                    "Reset",style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}