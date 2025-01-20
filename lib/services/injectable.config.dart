// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:panda/blocs/auth/auth_bloc.dart' as _i710;
import 'package:panda/repositories/auth_repository.dart' as _i1012;
import 'package:panda/screens/home/pages/chat/chat_bloc/chat_bloc.dart'
    as _i214;
import 'package:panda/services/http/http_client.dart' as _i124;
import 'package:panda/services/ws/ws_service.dart' as _i521;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of auth-scope dependencies inside of GetIt
  _i174.GetIt initAuthScope({_i174.ScopeDisposeFunc? dispose}) {
    return _i526.GetItHelper(this).initScope(
      'auth',
      dispose: dispose,
      init: (_i526.GetItHelper gh) {
        gh.singleton<_i124.HttpClient>(() => _i124.HttpClient());
        gh.singleton<_i521.WebSocketService>(() => _i521.WebSocketService());
        gh.factory<_i1012.AuthRepository>(
            () => _i1012.AuthRepository(gh<_i124.HttpClient>()));
        gh.singleton<_i710.AuthBloc>(
            () => _i710.AuthBloc(gh<_i1012.AuthRepository>()));
      },
    );
  }

// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i214.ChatBloc>(
        () => _i214.ChatBloc(gh<_i521.WebSocketService>()));
    return this;
  }
}
