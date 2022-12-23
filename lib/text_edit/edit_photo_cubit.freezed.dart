
part of 'edit_photo_cubit.dart';

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

mixin _$EditPhotoState {
  EditState get editState => throw _privateConstructorUsedError;
  double get opacityLayer => throw _privateConstructorUsedError;
  List<DragableWidget> get widgets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditPhotoStateCopyWith<EditPhotoState> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $EditPhotoStateCopyWith<$Res> {
  factory $EditPhotoStateCopyWith(
          EditPhotoState value, $Res Function(EditPhotoState) then) =
      _$EditPhotoStateCopyWithImpl<$Res>;
  $Res call(
      {EditState editState,
      double opacityLayer,
      List<DragableWidget> widgets,
      });
}

class _$EditPhotoStateCopyWithImpl<$Res>
    implements $EditPhotoStateCopyWith<$Res> {
  _$EditPhotoStateCopyWithImpl(this._value, this._then);

  final EditPhotoState _value;
  // ignore: unused_field
  final $Res Function(EditPhotoState) _then;

  @override
  $Res call({
    Object? editState = freezed,
    Object? opacityLayer = freezed,
    Object? widgets = freezed,
    Object? downloadStatus = freezed,
    Object? shareStatus = freezed,
  }) {
    return _then(_value.copyWith(
      editState: editState == freezed
          ? _value.editState
          : editState
              as EditState,
      opacityLayer: opacityLayer == freezed
          ? _value.opacityLayer
          : opacityLayer
              as double,
      widgets: widgets == freezed
          ? _value.widgets
          : widgets
              as List<DragableWidget>,
    ));
  }
}

abstract class _$$_EditPhotoStateCopyWith<$Res>
    implements $EditPhotoStateCopyWith<$Res> {
  factory _$$_EditPhotoStateCopyWith(
          _$_EditPhotoState value, $Res Function(_$_EditPhotoState) then) =
      __$$_EditPhotoStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {EditState editState,
      double opacityLayer,
      List<DragableWidget> widgets,
      });
}

class __$$_EditPhotoStateCopyWithImpl<$Res>
    extends _$EditPhotoStateCopyWithImpl<$Res>
    implements _$$_EditPhotoStateCopyWith<$Res> {
  __$$_EditPhotoStateCopyWithImpl(
      _$_EditPhotoState _value, $Res Function(_$_EditPhotoState) _then)
      : super(_value, (v) => _then(v as _$_EditPhotoState));

  @override
  _$_EditPhotoState get _value => super._value as _$_EditPhotoState;

  @override
  $Res call({
    Object? editState = freezed,
    Object? opacityLayer = freezed,
    Object? widgets = freezed,
    Object? downloadStatus = freezed,
    Object? shareStatus = freezed,
  }) {
    return _then(_$_EditPhotoState(
      editState: editState == freezed
          ? _value.editState
          : editState
              as EditState,
      opacityLayer: opacityLayer == freezed
          ? _value.opacityLayer
          : opacityLayer
              as double,
      widgets: widgets == freezed
          ? _value._widgets
          : widgets
              as List<DragableWidget>,
    ));
  }
}


class _$_EditPhotoState implements _EditPhotoState {
  const _$_EditPhotoState(
      {this.editState = EditState.idle,
      this.opacityLayer = 0,
      final List<DragableWidget> widgets = const [],
      })
      : _widgets = widgets;

  @override
  @JsonKey()
  final EditState editState;
  @override
  @JsonKey()
  final double opacityLayer;
  final List<DragableWidget> _widgets;
  @override
  @JsonKey()
  List<DragableWidget> get widgets {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_widgets);
  }


  @override
  String toString() {
    return 'EditPhotoState(editState: $editState, opacityLayer: $opacityLayer, widgets: $widgets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditPhotoState &&
            const DeepCollectionEquality().equals(other.editState, editState) &&
            const DeepCollectionEquality()
                .equals(other.opacityLayer, opacityLayer) &&
            const DeepCollectionEquality().equals(other._widgets, _widgets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(editState),
      const DeepCollectionEquality().hash(opacityLayer),
      const DeepCollectionEquality().hash(_widgets),
      );

  @JsonKey(ignore: true)
  @override
  _$$_EditPhotoStateCopyWith<_$_EditPhotoState> get copyWith =>
      __$$_EditPhotoStateCopyWithImpl<_$_EditPhotoState>(this, _$identity);
}

abstract class _EditPhotoState implements EditPhotoState {
  const factory _EditPhotoState(
      {final EditState editState,
      final double opacityLayer,
      final List<DragableWidget> widgets,
      }) = _$_EditPhotoState;

  @override
  EditState get editState;
  @override
  double get opacityLayer;
  @override
  List<DragableWidget> get widgets;
  @override
  @JsonKey(ignore: true)
  _$$_EditPhotoStateCopyWith<_$_EditPhotoState> get copyWith =>
      throw _privateConstructorUsedError;
}
