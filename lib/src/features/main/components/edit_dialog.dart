import 'package:andesgroup_common/common.dart';
import 'package:flutter/material.dart';

Dialog editDialog(BuildContext context, String lapName,
    {ValueChanged<String>? onEdit}) {
  final textController = TextEditingController(text: lapName);

  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter new name',
            ),
            autofocus: true,
          ),
          const Gap(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100.0,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
              ),
              SizedBox(
                width: 100.0,
                child: ElevatedButton(
                  onPressed: () {
                    onEdit?.call(textController.text);
                    Navigator.pop(context);
                  },
                  child: const Text('EDIT'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
