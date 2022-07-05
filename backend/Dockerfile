################
FROM dart:2.17.5 AS build

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart pub get --offline
RUN dart compile exe bin/backend.dart -o bin/server

########################
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /server
COPY --from=build /app/swagger/swagger.yaml /swagger/swagger.yaml
EXPOSE 4000
CMD ["/server"]