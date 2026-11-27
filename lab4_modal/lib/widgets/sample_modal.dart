import 'package:flutter/material.dart';

class SampleModal extends StatelessWidget {
  const SampleModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        width: 400,
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            // TITLE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Color(0xFF26734D),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              child: const Text(
                'SampleModal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // SCROLLABLE IMAGE AND TEXT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/sample_modal_image.png',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      '''
Long text in a scrollable area. 

The Body Continues beyond the

visible section so users can scroll.

Keep the close action below it.
                      ''',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),

            // CLOSE BUTTON
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF26734D),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('CLOSE'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}