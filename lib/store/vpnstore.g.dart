// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vpnstore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VpnStore on VpnStoreBase, Store {
  final _$vpnStatusAtom = Atom(name: 'VpnStoreBase.vpnStatus');

  @override
  VPNStatus get vpnStatus {
    _$vpnStatusAtom.reportRead();
    return super.vpnStatus;
  }

  @override
  set vpnStatus(VPNStatus value) {
    _$vpnStatusAtom.reportWrite(value, super.vpnStatus, () {
      super.vpnStatus = value;
    });
  }

  final _$isConnectedAtom = Atom(name: 'VpnStoreBase.isConnected');

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  final _$mIsPreparedAtom = Atom(name: 'VpnStoreBase.mIsPrepared');

  @override
  bool get mIsPrepared {
    _$mIsPreparedAtom.reportRead();
    return super.mIsPrepared;
  }

  @override
  set mIsPrepared(bool value) {
    _$mIsPreparedAtom.reportWrite(value, super.mIsPrepared, () {
      super.mIsPrepared = value;
    });
  }

  final _$startAtom = Atom(name: 'VpnStoreBase.start');

  @override
  String get start {
    _$startAtom.reportRead();
    return super.start;
  }

  @override
  set start(String value) {
    _$startAtom.reportWrite(value, super.start, () {
      super.start = value;
    });
  }

  final _$serverListAtom = Atom(name: 'VpnStoreBase.serverList');

  @override
  List<ServerModel> get serverList {
    _$serverListAtom.reportRead();
    return super.serverList;
  }

  @override
  set serverList(List<ServerModel> value) {
    _$serverListAtom.reportWrite(value, super.serverList, () {
      super.serverList = value;
    });
  }

  final _$mVpnStageAtom = Atom(name: 'VpnStoreBase.mVpnStage');

  @override
  String get mVpnStage {
    _$mVpnStageAtom.reportRead();
    return super.mVpnStage;
  }

  @override
  set mVpnStage(String value) {
    _$mVpnStageAtom.reportWrite(value, super.mVpnStage, () {
      super.mVpnStage = value;
    });
  }

  final _$mByteInAtom = Atom(name: 'VpnStoreBase.mByteIn');

  @override
  String get mByteIn {
    _$mByteInAtom.reportRead();
    return super.mByteIn;
  }

  @override
  set mByteIn(String value) {
    _$mByteInAtom.reportWrite(value, super.mByteIn, () {
      super.mByteIn = value;
    });
  }

  final _$mByteOutAtom = Atom(name: 'VpnStoreBase.mByteOut');

  @override
  String get mByteOut {
    _$mByteOutAtom.reportRead();
    return super.mByteOut;
  }

  @override
  set mByteOut(String value) {
    _$mByteOutAtom.reportWrite(value, super.mByteOut, () {
      super.mByteOut = value;
    });
  }

  final _$mDurationAtom = Atom(name: 'VpnStoreBase.mDuration');

  @override
  String get mDuration {
    _$mDurationAtom.reportRead();
    return super.mDuration;
  }

  @override
  set mDuration(String value) {
    _$mDurationAtom.reportWrite(value, super.mDuration, () {
      super.mDuration = value;
    });
  }

  final _$mLastPacketReceiveAtom =
      Atom(name: 'VpnStoreBase.mLastPacketReceive');

  @override
  String get mLastPacketReceive {
    _$mLastPacketReceiveAtom.reportRead();
    return super.mLastPacketReceive;
  }

  @override
  set mLastPacketReceive(String value) {
    _$mLastPacketReceiveAtom.reportWrite(value, super.mLastPacketReceive, () {
      super.mLastPacketReceive = value;
    });
  }

  final _$setVPNStatusAsyncAction = AsyncAction('VpnStoreBase.setVPNStatus');

  @override
  Future<void> setVPNStatus() {
    return _$setVPNStatusAsyncAction.run(() => super.setVPNStatus());
  }

  final _$VpnStoreBaseActionController = ActionController(name: 'VpnStoreBase');

  @override
  void setServerList(List<ServerModel> val) {
    final _$actionInfo = _$VpnStoreBaseActionController.startAction(
        name: 'VpnStoreBase.setServerList');
    try {
      return super.setServerList(val);
    } finally {
      _$VpnStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStartAction(String val) {
    final _$actionInfo = _$VpnStoreBaseActionController.startAction(
        name: 'VpnStoreBase.setStartAction');
    try {
      return super.setStartAction(val);
    } finally {
      _$VpnStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsPrepared(bool val, {bool initialize = false}) {
    final _$actionInfo = _$VpnStoreBaseActionController.startAction(
        name: 'VpnStoreBase.setIsPrepared');
    try {
      return super.setIsPrepared(val, initialize: initialize);
    } finally {
      _$VpnStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeServerList(int index) {
    final _$actionInfo = _$VpnStoreBaseActionController.startAction(
        name: 'VpnStoreBase.removeServerList');
    try {
      return super.removeServerList(index);
    } finally {
      _$VpnStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConnectedStatus() {
    final _$actionInfo = _$VpnStoreBaseActionController.startAction(
        name: 'VpnStoreBase.setConnectedStatus');
    try {
      return super.setConnectedStatus();
    } finally {
      _$VpnStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVpnStage(String aVpnStage) {
    final _$actionInfo = _$VpnStoreBaseActionController.startAction(
        name: 'VpnStoreBase.setVpnStage');
    try {
      return super.setVpnStage(aVpnStage);
    } finally {
      _$VpnStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setByteIn(String val) {
    final _$actionInfo = _$VpnStoreBaseActionController.startAction(
        name: 'VpnStoreBase.setByteIn');
    try {
      return super.setByteIn(val);
    } finally {
      _$VpnStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setByteOut(String val) {
    final _$actionInfo = _$VpnStoreBaseActionController.startAction(
        name: 'VpnStoreBase.setByteOut');
    try {
      return super.setByteOut(val);
    } finally {
      _$VpnStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDuration(String aDuration) {
    final _$actionInfo = _$VpnStoreBaseActionController.startAction(
        name: 'VpnStoreBase.setDuration');
    try {
      return super.setDuration(aDuration);
    } finally {
      _$VpnStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastPacketReceive(String aLastPacketReceive) {
    final _$actionInfo = _$VpnStoreBaseActionController.startAction(
        name: 'VpnStoreBase.setLastPacketReceive');
    try {
      return super.setLastPacketReceive(aLastPacketReceive);
    } finally {
      _$VpnStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
vpnStatus: ${vpnStatus},
isConnected: ${isConnected},
mIsPrepared: ${mIsPrepared},
start: ${start},
serverList: ${serverList},
mVpnStage: ${mVpnStage},
mByteIn: ${mByteIn},
mByteOut: ${mByteOut},
mDuration: ${mDuration},
mLastPacketReceive: ${mLastPacketReceive}
    ''';
  }
}
