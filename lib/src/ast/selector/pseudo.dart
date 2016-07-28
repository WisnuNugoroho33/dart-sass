// Copyright 2016 Google Inc. Use of this source code is governed by an
// MIT-style license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:charcode/charcode.dart';

import '../selector.dart';

class PseudoSelector extends SimpleSelector {
  final String name;

  final PseudoType type;

  final String argument;

  final SelectorList selector; 

  PseudoSelector(this.name, this.type, {this.argument, this.selector});

  // This intentionally uses identity for the selector list, if one is available.
  bool operator==(other) =>
      other is PseudoSelector &&
      other.name == name &&
      other.type == type &&
      other.argument == argument &&
      other.selector == selector;

  int get hashCode =>
      name.hashCode ^ type.hashCode ^ argument.hashCode ^ selector.hashCode;

  String toString() {
    var buffer = new StringBuffer("$type$name");
    if (argument == null && selector == null) return buffer.toString();

    buffer.writeCharCode($lparen);
    if (argument != null) buffer.write(argument);
    if (argument != null && selector != null) buffer.writeCharCode($space);
    if (selector != null) buffer.write(selector);
    buffer.writeCharCode($rparen);
    return buffer.toString();
  }
}

class PseudoType {
  static const element = const PseudoType._("::");
  static const klass = const PseudoType._(":");

  final String _text;

  const PseudoType._(this._text);

  String toString() => _text;
}