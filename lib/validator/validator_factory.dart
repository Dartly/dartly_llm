import 'dart:mirrors';

import 'package:vania/src/exception/validation_exception.dart';

import 'base_validator.dart';

class ValidatorFactory {
  static final ValidatorFactory _instance = ValidatorFactory._internal();

  factory ValidatorFactory() {
    return _instance;
  }

  ValidatorFactory._internal();

  static List<String> validate(Object obj, {String? parentField}) {
    List<String> errors = [];

    InstanceMirror im = reflect(obj);
    ClassMirror classMirror = _getClassMirror(obj.runtimeType);

    for (var declaration in classMirror.declarations.values) {
      if (declaration is VariableMirror) {
        var variable = declaration;
        var fieldName = MirrorSystem.getName(variable.simpleName);
        var fieldValue = im.getField(variable.simpleName).reflectee;

        if (fieldValue != null &&
            !variable.type.isSubtypeOf(reflectType(String)) &&
            variable.type.isSubtypeOf(reflectType(Object))) {
          errors.addAll(validate(fieldValue, parentField: fieldName));
        }

        for (var metadata in variable.metadata) {
          var validator = metadata.reflectee as BaseValidator;
          if (!validator.isValid(fieldValue)) {
            errors.add(validator.message);
          }
        }
      }
    }
    if (errors.isNotEmpty) {
      throw ValidationException(message: errors.first);
    }

    return errors;
  }

  static final Map<Type, ClassMirror> _classMirrorCache = {};

  static ClassMirror _getClassMirror(Type type) {
    if (_classMirrorCache.containsKey(type)) {
      return _classMirrorCache[type]!;
    }
    var classMirror = reflectClass(type);
    _classMirrorCache[type] = classMirror;
    return classMirror;
  }
}