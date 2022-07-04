import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:backend/src/modules/auth/presenter/guards/auth_guard.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:shelf_multipart/form_data.dart';
import 'package:uuid/uuid.dart';

class UploadResource extends Resource {
  @override
  List<Route> get routes => [
        Route.post('/upload', _upload, middlewares: [AuthGuard()]),
        Route.get('/download/:image', _download),
      ];

  FutureOr<Response> _upload(Request request) async {
    if (request.isMultipartForm) {
      String filename = '';
      await for (final formData in request.multipartFormData) {
        if (formData.name == 'file') {
          final bytes = await formData.part.readBytes();
          final extension = path.extension(formData.filename!);
          filename = '${Uuid().v1()}$extension';
          final file = File('uploads/$filename');
          if (!await file.exists()) {
            await file.create(recursive: true);
          }
          await file.writeAsBytes(bytes);
        } else {
          return Response(401);
        }
      }

      return Response.ok(jsonEncode({"image": filename}));
    } else {
      return Response(401);
    }
  }

  FutureOr<Response> _download(ModularArguments arguments) async {
    final file = File('uploads/${arguments.params['image']}');
    final contentType = MimeTypeResolver().lookup(file.path);
    if (!await file.exists()) {
      return Response(404);
    }

    return Response.ok(await file.readAsBytes(), headers: {
      HttpHeaders.lastModifiedHeader: formatHttpDate(file.statSync().modified),
      HttpHeaders.acceptRangesHeader: 'bytes',
      if (contentType != null) HttpHeaders.contentTypeHeader: contentType,
    });
  }
}
