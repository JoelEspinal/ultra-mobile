// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodosResponse {
// The list of Todo items
  List<Todo> get todos; // The other metadata fields
  int get total;
  int get skip;
  int get limit;

  /// Create a copy of TodosResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TodosResponseCopyWith<TodosResponse> get copyWith =>
      _$TodosResponseCopyWithImpl<TodosResponse>(
          this as TodosResponse, _$identity);

  /// Serializes this TodosResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TodosResponse &&
            const DeepCollectionEquality().equals(other.todos, todos) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.skip, skip) || other.skip == skip) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(todos), total, skip, limit);

  @override
  String toString() {
    return 'TodosResponse(todos: $todos, total: $total, skip: $skip, limit: $limit)';
  }
}

/// @nodoc
abstract mixin class $TodosResponseCopyWith<$Res> {
  factory $TodosResponseCopyWith(
          TodosResponse value, $Res Function(TodosResponse) _then) =
      _$TodosResponseCopyWithImpl;
  @useResult
  $Res call({List<Todo> todos, int total, int skip, int limit});
}

/// @nodoc
class _$TodosResponseCopyWithImpl<$Res>
    implements $TodosResponseCopyWith<$Res> {
  _$TodosResponseCopyWithImpl(this._self, this._then);

  final TodosResponse _self;
  final $Res Function(TodosResponse) _then;

  /// Create a copy of TodosResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todos = null,
    Object? total = null,
    Object? skip = null,
    Object? limit = null,
  }) {
    return _then(_self.copyWith(
      todos: null == todos
          ? _self.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      skip: null == skip
          ? _self.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [TodosResponse].
extension TodosResponsePatterns on TodosResponse {
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
    TResult Function(_TodosResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TodosResponse() when $default != null:
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
    TResult Function(_TodosResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodosResponse():
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
    TResult? Function(_TodosResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodosResponse() when $default != null:
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
    TResult Function(List<Todo> todos, int total, int skip, int limit)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TodosResponse() when $default != null:
        return $default(_that.todos, _that.total, _that.skip, _that.limit);
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
    TResult Function(List<Todo> todos, int total, int skip, int limit) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodosResponse():
        return $default(_that.todos, _that.total, _that.skip, _that.limit);
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
    TResult? Function(List<Todo> todos, int total, int skip, int limit)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodosResponse() when $default != null:
        return $default(_that.todos, _that.total, _that.skip, _that.limit);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TodosResponse implements TodosResponse {
  const _TodosResponse(
      {required final List<Todo> todos,
      required this.total,
      required this.skip,
      required this.limit})
      : _todos = todos;
  factory _TodosResponse.fromJson(Map<String, dynamic> json) =>
      _$TodosResponseFromJson(json);

// The list of Todo items
  final List<Todo> _todos;
// The list of Todo items
  @override
  List<Todo> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

// The other metadata fields
  @override
  final int total;
  @override
  final int skip;
  @override
  final int limit;

  /// Create a copy of TodosResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TodosResponseCopyWith<_TodosResponse> get copyWith =>
      __$TodosResponseCopyWithImpl<_TodosResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TodosResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TodosResponse &&
            const DeepCollectionEquality().equals(other._todos, _todos) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.skip, skip) || other.skip == skip) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_todos), total, skip, limit);

  @override
  String toString() {
    return 'TodosResponse(todos: $todos, total: $total, skip: $skip, limit: $limit)';
  }
}

/// @nodoc
abstract mixin class _$TodosResponseCopyWith<$Res>
    implements $TodosResponseCopyWith<$Res> {
  factory _$TodosResponseCopyWith(
          _TodosResponse value, $Res Function(_TodosResponse) _then) =
      __$TodosResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<Todo> todos, int total, int skip, int limit});
}

/// @nodoc
class __$TodosResponseCopyWithImpl<$Res>
    implements _$TodosResponseCopyWith<$Res> {
  __$TodosResponseCopyWithImpl(this._self, this._then);

  final _TodosResponse _self;
  final $Res Function(_TodosResponse) _then;

  /// Create a copy of TodosResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? todos = null,
    Object? total = null,
    Object? skip = null,
    Object? limit = null,
  }) {
    return _then(_TodosResponse(
      todos: null == todos
          ? _self._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      skip: null == skip
          ? _self.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
