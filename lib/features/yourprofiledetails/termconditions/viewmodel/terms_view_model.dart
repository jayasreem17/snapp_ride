import 'package:flutter/material.dart';

class TermsAndConditionsViewModel extends ChangeNotifier {
  final String title = 'Terms & Conditions';

  final String paragraph =
      'Dorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis '
      'molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla '
      'accumsan, risus sem sollicitudin lacus, ut interdum elit sed risus. '
      'Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent '
      'taciti sociosqu ad litora torquent per conubia nostra, per inceptos '
      'himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante '
      'pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor '
      'urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit '
      'amet lacinia. Aliquam in elementum tellus.';

  List<String> get paragraphs => [paragraph, paragraph];

  void goBack(BuildContext context) {
    Navigator.of(context).maybePop();
  }
}