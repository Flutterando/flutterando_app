const baseUrl = String.fromEnvironment('BASE_URL');
final debugAPI =
    bool.tryParse(const String.fromEnvironment('DEBUG_API')) ?? false;
final debugLogger =
    bool.tryParse(const String.fromEnvironment('LOGGER_APP')) ?? false;
const connectTimeout =
    int.fromEnvironment('CONNECT_TIMEOUT', defaultValue: 5000);
const receiveTimeout =
    int.fromEnvironment('RECEIVE_TIMEOUT', defaultValue: 5000);
