// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Todo {
  int get id;
  String get todo;
  bool get completed;
  int get userId; // optional fields
  String? get description;
  DateTime? get dueDate;
  int? get priority;
  String? get category;
  String? get imageUrl;
  DateTime? get reminderTime;
  bool? get isFavorite;
  String? get imagePath;
  String? get createdAt;
  String? get updatedAt;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TodoCopyWith<Todo> get copyWith =>
      _$TodoCopyWithImpl<Todo>(this as Todo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Todo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.todo, todo) || other.todo == todo) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.reminderTime, reminderTime) ||
                other.reminderTime == reminderTime) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      todo,
      completed,
      userId,
      description,
      dueDate,
      priority,
      category,
      imageUrl,
      reminderTime,
      isFavorite,
      imagePath,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'Todo(id: $id, todo: $todo, completed: $completed, userId: $userId, description: $description, dueDate: $dueDate, priority: $priority, category: $category, imageUrl: $imageUrl, reminderTime: $reminderTime, isFavorite: $isFavorite, imagePath: $imagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) _then) =
      _$TodoCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String todo,
      bool completed,
      int userId,
      String? description,
      DateTime? dueDate,
      int? priority,
      String? category,
      String? imageUrl,
      DateTime? reminderTime,
      bool? isFavorite,
      String? imagePath,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class _$TodoCopyWithImpl<$Res> implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._self, this._then);

  final Todo _self;
  final $Res Function(Todo) _then;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? todo = null,
    Object? completed = null,
    Object? userId = null,
    Object? description = freezed,
    Object? dueDate = freezed,
    Object? priority = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
    Object? reminderTime = freezed,
    Object? isFavorite = freezed,
    Object? imagePath = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      todo: null == todo
          ? _self.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dueDate: freezed == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: freezed == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      reminderTime: freezed == reminderTime
          ? _self.reminderTime
          : reminderTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isFavorite: freezed == isFavorite
          ? _self.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool?,
      imagePath: freezed == imagePath
          ? _self.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Todo].
extension TodoPatterns on Todo {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Todo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Todo() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Todo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Todo():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Todo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Todo() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            String todo,
            bool completed,
            int userId,
            String? description,
            DateTime? dueDate,
            int? priority,
            String? category,
            String? imageUrl,
            DateTime? reminderTime,
            bool? isFavorite,
            String? imagePath,
            String? createdAt,
            String? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Todo() when $default != null:
        return $default(
            _that.id,
            _that.todo,
            _that.completed,
            _that.userId,
            _that.description,
            _that.dueDate,
            _that.priority,
            _that.category,
            _that.imageUrl,
            _that.reminderTime,
            _that.isFavorite,
            _that.imagePath,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            String todo,
            bool completed,
            int userId,
            String? description,
            DateTime? dueDate,
            int? priority,
            String? category,
            String? imageUrl,
            DateTime? reminderTime,
            bool? isFavorite,
            String? imagePath,
            String? createdAt,
            String? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Todo():
        return $default(
            _that.id,
            _that.todo,
            _that.completed,
            _that.userId,
            _that.description,
            _that.dueDate,
            _that.priority,
            _that.category,
            _that.imageUrl,
            _that.reminderTime,
            _that.isFavorite,
            _that.imagePath,
            _that.createdAt,
            _that.updatedAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            String todo,
            bool completed,
            int userId,
            String? description,
            DateTime? dueDate,
            int? priority,
            String? category,
            String? imageUrl,
            DateTime? reminderTime,
            bool? isFavorite,
            String? imagePath,
            String? createdAt,
            String? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Todo() when $default != null:
        return $default(
            _that.id,
            _that.todo,
            _that.completed,
            _that.userId,
            _that.description,
            _that.dueDate,
            _that.priority,
            _that.category,
            _that.imageUrl,
            _that.reminderTime,
            _that.isFavorite,
            _that.imagePath,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Todo implements Todo {
  _Todo(
      {required this.id,
      required this.todo,
      required this.completed,
      required this.userId,
      this.description,
      this.dueDate,
      this.priority,
      this.category,
      this.imageUrl,
      this.reminderTime,
      this.isFavorite,
      this.imagePath,
      this.createdAt,
      this.updatedAt});

  @override
  final int id;
  @override
  final String todo;
  @override
  final bool completed;
  @override
  final int userId;
// optional fields
  @override
  final String? description;
  @override
  final DateTime? dueDate;
  @override
  final int? priority;
  @override
  final String? category;
  @override
  final String? imageUrl;
  @override
  final DateTime? reminderTime;
  @override
  final bool? isFavorite;
  @override
  final String? imagePath;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TodoCopyWith<_Todo> get copyWith =>
      __$TodoCopyWithImpl<_Todo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Todo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.todo, todo) || other.todo == todo) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.reminderTime, reminderTime) ||
                other.reminderTime == reminderTime) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      todo,
      completed,
      userId,
      description,
      dueDate,
      priority,
      category,
      imageUrl,
      reminderTime,
      isFavorite,
      imagePath,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'Todo(id: $id, todo: $todo, completed: $completed, userId: $userId, description: $description, dueDate: $dueDate, priority: $priority, category: $category, imageUrl: $imageUrl, reminderTime: $reminderTime, isFavorite: $isFavorite, imagePath: $imagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$TodoCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$TodoCopyWith(_Todo value, $Res Function(_Todo) _then) =
      __$TodoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String todo,
      bool completed,
      int userId,
      String? description,
      DateTime? dueDate,
      int? priority,
      String? category,
      String? imageUrl,
      DateTime? reminderTime,
      bool? isFavorite,
      String? imagePath,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class __$TodoCopyWithImpl<$Res> implements _$TodoCopyWith<$Res> {
  __$TodoCopyWithImpl(this._self, this._then);

  final _Todo _self;
  final $Res Function(_Todo) _then;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? todo = null,
    Object? completed = null,
    Object? userId = null,
    Object? description = freezed,
    Object? dueDate = freezed,
    Object? priority = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
    Object? reminderTime = freezed,
    Object? isFavorite = freezed,
    Object? imagePath = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_Todo(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      todo: null == todo
          ? _self.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dueDate: freezed == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: freezed == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      reminderTime: freezed == reminderTime
          ? _self.reminderTime
          : reminderTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isFavorite: freezed == isFavorite
          ? _self.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool?,
      imagePath: freezed == imagePath
          ? _self.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
