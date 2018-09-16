import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String _kStartTag = '// START';
const String _kEndTag = '// END';
Map<String, String> _exampleCode;

Future<String> getExampleCode(String tag, AssetBundle bundle) async {
  if (_exampleCode == null) {
    await _parseExampleCode(bundle);
    return _exampleCode[tag];
  }
}

Future<Null> _parseExampleCode(AssetBundle bundle) async {
  final String code = await bundle.loadString('lib/example_code.dart') ??
      '// lib/example_code.dart not found\n';
  _exampleCode = <String, String>{};
  final List<String> lines = code.split('\n');
  List<String> codeBlock;
  String codeTag;
  for (String line in lines) {
    if (codeBlock == null) {
      if (line.startsWith(_kStartTag)) {
        codeBlock = <String>[];
        codeTag = line.substring(_kStartTag.length).trim();
      }
    }else{
      if (line.startsWith(_kEndTag)) {
        // Add the block.
        _exampleCode[codeTag] = codeBlock.join('\n');
        codeBlock = null;
        codeTag = null;
      } else {
        // Add to the current block
        codeBlock.add(line.trimRight());
      }
    }
  }
}
