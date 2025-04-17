import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../../config/dependencies.dart';
import '../../../../main.dart';
import '../../../app_widget.dart';
import '../../../core/constants/env.dart';
import '../../../data/infrastructure/auth_interceptor.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/api/client_http/i_rest_client.dart';
import '../../../data/services/api/client_http/logger/client_interceptor_logger_impl.dart';
import '../../../data/services/storage/auth_storage.dart';

class InterceptorProvider extends StatefulWidget {
  final Widget? child;

  const InterceptorProvider({super.key, this.child});

  static InterceptorProvider instance(BuildContext context, Widget? child) {
    return InterceptorProvider(child: child);
  }

  @override
  State<InterceptorProvider> createState() => _InterceptorConfigState();
}

class _InterceptorConfigState extends State<InterceptorProvider> {
  final client = injector.get<IRestClient>();
  final authRepository = injector.get<AuthRepository>();
  final authStorage = injector.get<AuthStorage>();

  @override
  void initState() {
    super.initState();

    client.addInterceptors(
      AuthInterceptor(
        client: client,
        authRepository: authRepository,
        authStorage: authStorage,
        onErrorRefreshToken: () {
          Routefly.navigate(routePaths.auth.login);
        },
      ),
    );

    if (!isProduction && debugAPI) {
      client.addInterceptors(ClientInterceptorLoggerImpl());
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
