import 'package:spry/config.dart';

void main() {
  defineSpryConfig(
    openapi: .new(
      document: .new(
        info: .new(title: "Spry Full-stack starter", version: "1.0.0+1"),
      ),
      componentsMergeStrategy: .deepMerge,
      ui: .new(route: "/docs"),
    ),
    client: .new(pkgDir: ".", output: "lib/src/generated/api"),
    target: .vm,
  );
}
