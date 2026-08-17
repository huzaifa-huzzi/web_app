

import 'package:get/get.dart';

class FAQItem {
  final String question;
  final String answer;
  var isExpanded = false.obs;

  FAQItem({required this.question, required this.answer});
}

class HelpCenterController extends GetxController {
  var searchQuery = ''.obs;
  var selectedCategory = 'All'.obs;

  final List<String> categories = ['All', 'General', 'Account', 'Billing', 'Tracking'];

  final RxList<FAQItem> faqs = <FAQItem>[
    FAQItem(
      question: "How do I reset my account password?",
      answer: "You can reset your password by going to the Login screen and clicking on 'Forgot Password'. Follow the instructions sent to your email.",
    ),
    FAQItem(
      question: "How does auto-time tracking work?",
      answer: "Auto-time tracking starts recording your activity as soon as you launch the desktop app or start a task assigned to your profile.",
    ),
    FAQItem(
      question: "Can I export my timesheet logs?",
      answer: "Yes, you can export your logs in CSV or PDF format from the Reports & Export section.",
    ),
    FAQItem(
      question: "What should I do if my screenshots are not syncing?",
      answer: "Check your internet connection and ensure synchronization is turned on in the Settings module under Notifications.",
    ),
  ].obs;

  List<FAQItem> get filteredFaqs {
    if (searchQuery.value.isEmpty) {
      return faqs;
    }
    return faqs
        .where((faq) =>
    faq.question.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        faq.answer.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }
}