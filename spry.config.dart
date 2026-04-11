import 'package:spry/config.dart';

void main() {
  defineSpryConfig(
    host: '127.0.0.1',
    port: 4000,
    openapi: .new(
      document: .new(
        info: .new(title: "Spry Full-stack starter", version: "1.0.0+1"),
      ),
      componentsMergeStrategy: .deepMerge,
      ui: .new(route: "/docs"),
    ),
    client: .new(
      pkgDir: ".",
      output: "lib/src/generated/api",
      endpoint: "http://127.0.0.1:4000",
    ),
    target: .vm,
  );
}
