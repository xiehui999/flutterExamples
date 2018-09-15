import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  static const String routeName = 'material/modal-bottom-sheet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modal bottom sheet')),
      body: Center(
        child: RaisedButton(
            child: Text('Show Bottom Sheet'),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          'This is the modal bottom sheet,Tap  anywhere to dismiss',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 24.0),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
