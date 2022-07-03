import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'generate_functions.dart';

final functions = <String, FutureOr<JsonRPCResponse> Function(JsonRPCRequest request)>{};

main() async {
  functions['getManifest'] = getManifest;
  functions['generate'] = generate;

  String? result = '';

  while (result != null) {
    try {
      result = io.stdin.readLineSync();
      if (result == null) {
        continue;
      }

      final json = jsonDecode(result);
      final request = JsonRPC.request(json);
      final response = await functions[request.method]?.call(request);
      if (response == null) {
        result = null;
        throw UnimplementedError('Method ${request.method} not found');
      }
      respond(response.toJson());
    } catch (e, s) {
      print(e);
      print(s);
      result = null;
    }
  }

  await io.stdout.done;
}

void respond(String response) {
  io.stderr.writeln(response);
}

abstract class JsonRPC {
  final String version;
  final int id;

  JsonRPC(this.version, this.id);

  String toJson();

  static JsonRPCRequest request(dynamic json) {
    return JsonRPCRequest.fromJson(json);
  }

  static JsonRPCResponse response(dynamic json) {
    return JsonRPCResponse.fromJson(json);
  }

  @override
  String toString() {
    return '$runtimeType: ${toJson()}';
  }
}

class JsonRPCRequest extends JsonRPC {
  final String method;
  final dynamic params;

  JsonRPCRequest({
    required String version,
    required int id,
    required this.method,
    this.params = const {},
  }) : super(version, id);

  static JsonRPCRequest fromJson(dynamic json) {
    return JsonRPCRequest(
      id: json['id'],
      version: json['jsonrpc'],
      method: json['method'],
      params: json['params'],
    );
  }

  JsonRPCResponse respond(dynamic result) {
    return JsonRPCResponse(id: id, version: version, result: result);
  }

  @override
  String toJson() {
    return jsonEncode({
      'jsonrpc': version,
      'id': id,
      'method': method,
      'params': params,
    });
  }
}

class JsonRPCResponse extends JsonRPC {
  final dynamic result;

  JsonRPCResponse({
    required String version,
    required int id,
    this.result = const {},
  }) : super(version, id);

  static JsonRPCResponse fromJson(dynamic json) {
    return JsonRPCResponse(
      id: json['id'],
      version: json['jsonrpc'],
      result: json['result'],
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      'jsonrpc': version,
      'id': id,
      'result': result,
    });
  }
}
