// Using a simple showModalBottomSheet
import 'package:flutter/material.dart';

void showBottomConfirmationSheet(BuildContext context,
    {required VoidCallback onConfirm}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20),
        height: 200,
        child: Column(
          children: [
            const Text('Proceed with deleting this Todo?',
                style: TextStyle(fontSize: 18)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Execute confirmation logic
                    onConfirm();
                    Navigator.pop(context);
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
