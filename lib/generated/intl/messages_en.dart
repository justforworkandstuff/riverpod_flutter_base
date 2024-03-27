// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(value) => "Name is: ${value}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "counter": MessageLookupByLibrary.simpleMessage("Counter"),
        "counterText": MessageLookupByLibrary.simpleMessage(
            "You have pushed this button this many times:"),
        "errorTitle": MessageLookupByLibrary.simpleMessage("Error"),
        "generalError": MessageLookupByLibrary.simpleMessage(
            "Something went wrong, please try again later."),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
        "nameIs": m0,
        "network": MessageLookupByLibrary.simpleMessage("Network"),
        "networkWithRefreshToken":
            MessageLookupByLibrary.simpleMessage("Network (Refresh Token)"),
        "newToDo": MessageLookupByLibrary.simpleMessage("New to do"),
        "textOk": MessageLookupByLibrary.simpleMessage("OK"),
        "todo": MessageLookupByLibrary.simpleMessage("To-Do"),
        "webView": MessageLookupByLibrary.simpleMessage("Web View")
      };
}
