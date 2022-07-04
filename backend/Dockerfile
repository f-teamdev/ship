################
FROM dart:2.17.5

WORKDIR /app
COPY pubspec.yaml /app/pubspec.yaml
RUN dart pub get
COPY . .
RUN dart pub get --offline

#RUN dart pub run build_runner build --delete-conflicting-outputs
RUN dart compile exe bin/backend.dart -o bin/server

########################
FROM subfuzion/dart:2.12-slim
COPY --from=0 /app/bin/server /server
COPY --from=0 /app/swagger/swagger.yaml /swagger/swagger.yaml
EXPOSE 4000
ENTRYPOINT ["/server"]