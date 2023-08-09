import 'package:flutter/material.dart';

class ContextHelper {
  ContextHelper._();

  static final instance = ContextHelper._();

  late BuildContext _context;

  set context(value) => _context = value;

  get context => _context;
}
