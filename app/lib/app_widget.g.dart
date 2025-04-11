// GENERATED FILE. PLEASE DO NOT EDIT THIS FILE!!

part of 'app_widget.dart';

List<RouteEntity> get routes => [
  RouteEntity(
    key: '/splash',
    uri: Uri.parse('/splash'),
    routeBuilder: b0Builder,
  ),
  RouteEntity(
    key: '/auth/recover_password/otp',
    uri: Uri.parse('/auth/recover_password/otp'),
    routeBuilder: b1Builder,
  ),
  RouteEntity(
    key: '/auth/recover_password/feedback_success',
    uri: Uri.parse('/auth/recover_password/feedback_success'),
    routeBuilder: b2Builder,
  ),
  RouteEntity(
    key: '/auth/recover_password/send_email',
    uri: Uri.parse('/auth/recover_password/send_email'),
    routeBuilder: b3Builder,
  ),
  RouteEntity(
    key: '/auth/recover_password/confirm_password',
    uri: Uri.parse('/auth/recover_password/confirm_password'),
    routeBuilder: b4Builder,
  ),
  RouteEntity(
    key: '/auth/register',
    uri: Uri.parse('/auth/register'),
    routeBuilder: b5Builder,
  ),
  RouteEntity(
    key: '/auth/register/pages/feedback_success',
    uri: Uri.parse('/auth/register/pages/feedback_success'),
    routeBuilder: b6Builder,
  ),
  RouteEntity(
    key: '/auth/register/pages/feedback_error',
    uri: Uri.parse('/auth/register/pages/feedback_error'),
    routeBuilder: b7Builder,
  ),
  RouteEntity(
    key: '/auth/login',
    uri: Uri.parse('/auth/login'),
    routeBuilder: b8Builder,
  ),
  RouteEntity(key: '/feed', uri: Uri.parse('/feed'), routeBuilder: b9Builder),
];

const routePaths = (
  path: '/',
  splash: '/splash',
  auth: (
    path: '/auth',
    recoverPassword: (
      path: '/auth/recover_password',
      otp: '/auth/recover_password/otp',
      feedbackSuccess: '/auth/recover_password/feedback_success',
      sendEmail: '/auth/recover_password/send_email',
      confirmPassword: '/auth/recover_password/confirm_password',
    ),
    register: (
      path: '/auth/register',
      pages: (
        path: '/auth/register/pages',
        feedbackSuccess: '/auth/register/pages/feedback_success',
        feedbackError: '/auth/register/pages/feedback_error',
      ),
    ),
    login: '/auth/login',
  ),
  feed: '/feed',
);
