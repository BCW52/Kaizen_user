// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appstore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on AppStoreBase, Store {
  Computed<bool>? _$isNetworkAvailableComputed;

  @override
  bool get isNetworkAvailable => (_$isNetworkAvailableComputed ??=
          Computed<bool>(() => super.isNetworkAvailable,
              name: 'AppStoreBase.isNetworkAvailable'))
      .value;

  final _$mConnectivityResultAtom =
      Atom(name: 'AppStoreBase.mConnectivityResult');

  @override
  ConnectivityResult get mConnectivityResult {
    _$mConnectivityResultAtom.reportRead();
    return super.mConnectivityResult;
  }

  @override
  set mConnectivityResult(ConnectivityResult value) {
    _$mConnectivityResultAtom.reportWrite(value, super.mConnectivityResult, () {
      super.mConnectivityResult = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'AppStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$selectedLanguageAtom = Atom(name: 'AppStoreBase.selectedLanguage');

  @override
  String get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(String value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  final _$isDarkModeAtom = Atom(name: 'AppStoreBase.isDarkMode');

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  final _$mSelectedServerModelAtom =
      Atom(name: 'AppStoreBase.mSelectedServerModel');

  @override
  ServerModel get mSelectedServerModel {
    _$mSelectedServerModelAtom.reportRead();
    return super.mSelectedServerModel;
  }

  @override
  set mSelectedServerModel(ServerModel value) {
    _$mSelectedServerModelAtom.reportWrite(value, super.mSelectedServerModel,
        () {
      super.mSelectedServerModel = value;
    });
  }

  final _$setConnectivityResultAsyncAction =
      AsyncAction('AppStoreBase.setConnectivityResult');

  @override
  Future<void> setConnectivityResult(ConnectivityResult aConnectivityResult) {
    return _$setConnectivityResultAsyncAction
        .run(() => super.setConnectivityResult(aConnectivityResult));
  }

  final _$setDarkModeAsyncAction = AsyncAction('AppStoreBase.setDarkMode');

  @override
  Future<void> setDarkMode(bool aIsDarkMode) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(aIsDarkMode));
  }

  final _$setLanguageAsyncAction = AsyncAction('AppStoreBase.setLanguage');

  @override
  Future<void> setLanguage(String aCode, {BuildContext? context}) {
    return _$setLanguageAsyncAction
        .run(() => super.setLanguage(aCode, context: context));
  }

  final _$AppStoreBaseActionController = ActionController(name: 'AppStoreBase');

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedServerModel(ServerModel aSelectedServerModel) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setSelectedServerModel');
    try {
      return super.setSelectedServerModel(aSelectedServerModel);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mConnectivityResult: ${mConnectivityResult},
isLoading: ${isLoading},
selectedLanguage: ${selectedLanguage},
isDarkMode: ${isDarkMode},
mSelectedServerModel: ${mSelectedServerModel},
isNetworkAvailable: ${isNetworkAvailable}
    ''';
  }
}
