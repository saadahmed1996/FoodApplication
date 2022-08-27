



class ResponseModel {
  late final bool _isSuccess;
  late final String _message;
  ResponseModel(this._isSuccess, this._message);
  //Getter Values.
  bool get isSuccess => _isSuccess;
  String get message => _message;
}
