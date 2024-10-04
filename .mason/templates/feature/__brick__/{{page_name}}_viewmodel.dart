import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{{page_name}}_viewmodel.g.dart';

@riverpod
class {{page_name.pascalCase()}}Viewmodel extends _${{page_name.pascalCase()}}Viewmodel {

  @override
  {{page_name.pascalCase()}}State build() {
    return {{page_name.pascalCase()}}State(
    );
  }

  Future<AppError?> call() async {
    final {{page_name.camelCase()}}Request = {{page_name.pascalCase()}}Request(
    );

    state = state.copyWith(isLoading: true);

    try {
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return e as AppError;
    }
    return null;
  }
}