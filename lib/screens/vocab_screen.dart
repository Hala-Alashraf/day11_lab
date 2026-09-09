import 'package:flutter/material.dart';
import '../service/gemini_api.dart';

class VocabScreen extends StatefulWidget{
const VocabScreen({super.key});

  @override
  State<VocabScreen> createState() => _VocabScreenState();
}

class _VocabScreenState extends State<VocabScreen> {
   final TextEditingController _controller = TextEditingController();
   

   String result = "";
   bool isLoading = false;

   void search() async{
    if (_controller.text.trim().isEmpty)return;

    setState(() {
      isLoading = true;
      result = "";
    });

    String response = await GeminiApi().getWordInfo(_controller.text.trim());

    setState(() {
      isLoading = false;
      result = response;
    });
   }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مدرب مفردات")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "اكتبي كلمة",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: isLoading ? null: search, 
              child: Text("اشرحي لي")
              ),
                    SizedBox(height: 20),
            if (isLoading) const CircularProgressIndicator(),
            if (result.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(result), 
                ),
              )else(Text("no data"))
          ],
        ),
      ),
    );
  }
}