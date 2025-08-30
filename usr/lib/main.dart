import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absolin Business Solutions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Start with a welcome message from Yaseen
    _addMessage(
      "Hello! I'm Yaseen, your Business Development Executive from Absolin. How can I help you today? Please tell me about your business challenges or ERP requirements.",
      isUser: false,
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    if (text.trim().isEmpty) return;

    // Add user message
    _addMessage(text, isUser: true);

    // Get and add Yaseen's response
    String response = _getAbsolinSolution(text);
    _addMessage(response, isUser: false);
  }

  void _addMessage(String text, {required bool isUser}) {
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: isUser));
    });
  }

  String _getAbsolinSolution(String query) {
    query = query.toLowerCase();
    if (query.contains('erp') || query.contains('odoo')) {
      return "Great! For ERP requirements, we highly recommend Odoo, a suite of open-source business management apps. We can customize it to fit your exact needs, covering everything from accounting and CRM to inventory and project management. Would you like to know more about our Odoo implementation services?";
    } else if (query.contains('hr') || query.contains('hrms') || query.contains('payroll')) {
      return "For HR and payroll management, our HRMS solution is perfect. It helps automate HR processes, manage employee data, track attendance, and handle payroll seamlessly. This can significantly reduce your administrative workload.";
    } else if (query.contains('crm') || query.contains('sales') || query.contains('customer')) {
      return "To enhance your customer relationships, our CRM solution is the way to go. It helps you manage leads, track sales activities, and provides valuable insights to improve customer engagement and drive growth.";
    } else if (query.contains('asset') || query.contains('asset pi')) {
      return "For managing your physical assets, Asset Pi is an excellent choice. It allows for efficient tracking, maintenance scheduling, and depreciation management, ensuring you get the most out of your assets.";
    } else if (query.contains('weighbridge')) {
      return "We offer robust weighbridge integration solutions that can be linked with your ERP system. This ensures accurate weight recording and seamless data flow for logistics and inventory management.";
    } else if (query.contains('mobile app') || query.contains('application')) {
      return "We develop custom mobile applications for both Android and iOS that can integrate with your existing systems. Whether you need an app for your sales team, your customers, or for internal operations, we can build it.";
    } else {
      return "Thank you for sharing. Based on your needs, we can offer a customized solution combining our expertise in ERP, CRM, and custom application development. Could you please elaborate on your specific challenges so I can provide a more detailed solution?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Chat with Yaseen",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.primary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: "Describe your business needs...",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({required this.text, required this.isUser, super.key});

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isUser) ...[
            const CircleAvatar(child: Text("Y")),
            const SizedBox(width: 8.0),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isUser ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(text),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8.0),
            const CircleAvatar(child: Icon(Icons.person)),
          ],
        ],
      ),
    );
  }
}
