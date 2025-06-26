import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:html' if (dart.library.html) 'dart:html' as html;

class DeviceInfoCollector {
  static const MethodChannel _channel = MethodChannel('device_info_channel');

  static Future<Map<String, dynamic>> collectAndPrintDeviceInfo() async {
    if (kDebugMode) {
      print('\n🔍 Starting comprehensive device information collection...\n');
    }

    Map<String, dynamic> completeDeviceInfo = {};

    try {
      final timestamp = DateTime.now().toUtc();
      completeDeviceInfo['collection_info'] = {
        'timestamp_utc': timestamp.toIso8601String(),
        'timestamp_formatted': '2025-06-25 15:51:13',
        'collector_version': '1.0.0',
        'user_login': 'dev-ali2',
        'collection_environment': kIsWeb ? 'web' : 'native',
      };

      completeDeviceInfo['platform_info'] = await _collectPlatformInfo();

      completeDeviceInfo['flutter_info'] = _collectFlutterInfo();

      completeDeviceInfo['dart_info'] = _collectDartInfo();

      completeDeviceInfo['display_info'] = _collectDisplayInfo();

      if (kIsWeb) {
        completeDeviceInfo['web_info'] = _collectWebInfo();
        completeDeviceInfo['browser_info'] = _collectBrowserInfo();
      } else {
        completeDeviceInfo['native_platform_info'] =
            await _collectNativePlatformInfo();
      }

      completeDeviceInfo['network_info'] = await _collectNetworkInfo();

      completeDeviceInfo['system_info'] = await _collectSystemInfo();

      completeDeviceInfo['environment_info'] = _collectEnvironmentInfo();

      completeDeviceInfo['app_info'] = _collectAppInfo();

      if (kDebugMode) {
        _printCompleteDeviceInfo(completeDeviceInfo);
      }
    } catch (e, stackTrace) {
      completeDeviceInfo['collection_error'] = {
        'error': e.toString(),
        'stack_trace': stackTrace.toString(),
        'timestamp': DateTime.now().toUtc().toIso8601String(),
      };

      if (kDebugMode) {
        print('❌ Error collecting device info: $e');
      }
    }

    if (kDebugMode) {
      print('\n✅ Device information collection completed!\n');
    }

    return completeDeviceInfo;
  }

  static Future<Map<String, dynamic>> _collectPlatformInfo() async {
    Map<String, dynamic> platformInfo = {
      'is_web': kIsWeb,
      'default_target_platform': defaultTargetPlatform.toString(),
    };

    if (kIsWeb) {
      platformInfo.addAll({
        'platform_type': 'web',
        'user_agent': _getWebUserAgent(),
        'language': _getWebLanguage(),
        'languages': _getWebLanguages(),
        'online': _isWebOnline(),
        'cookie_enabled': _isWebCookieEnabled(),
        'java_enabled': _isWebJavaEnabled(),
      });
    } else {
      try {
        final io = await import('dart:io') as dynamic;
        platformInfo.addAll({
          'operating_system': io.Platform.operatingSystem,
          'operating_system_version': io.Platform.operatingSystemVersion,
          'is_android': io.Platform.isAndroid,
          'is_ios': io.Platform.isIOS,
          'is_windows': io.Platform.isWindows,
          'is_macos': io.Platform.isMacOS,
          'is_linux': io.Platform.isLinux,
          'is_fuchsia': io.Platform.isFuchsia,
          'number_of_processors': io.Platform.numberOfProcessors,
          'path_separator': io.Platform.pathSeparator,
          'locale_name': io.Platform.localeName ?? 'Unknown',
          'executable': io.Platform.executable,
          'resolved_executable': io.Platform.resolvedExecutable,
          'script_path': io.Platform.script.toString(),
          'version': io.Platform.version,
        });
      } catch (e) {
        platformInfo['native_platform_error'] = e.toString();
      }
    }

    return platformInfo;
  }

  static Future<Map<String, dynamic>> _collectNativePlatformInfo() async {
    if (kIsWeb) return {'note': 'Not applicable for web platform'};

    try {
      final io = await import('dart:io') as dynamic;

      if (io.Platform.isAndroid) {
        return await _collectAndroidInfo();
      } else if (io.Platform.isIOS) {
        return await _collectIOSInfo();
      } else if (io.Platform.isWindows) {
        return await _collectWindowsInfo();
      } else if (io.Platform.isMacOS) {
        return await _collectMacOSInfo();
      } else if (io.Platform.isLinux) {
        return await _collectLinuxInfo();
      }
    } catch (e) {
      return {
        'error': 'Failed to collect native platform info: ${e.toString()}'
      };
    }

    return {'note': 'Unknown native platform'};
  }

  static Map<String, dynamic> _collectWebInfo() {
    if (!kIsWeb) return {'note': 'Not applicable for native platforms'};

    return {
      'is_web_platform': true,
      'user_agent': _getWebUserAgent(),
      'app_name': _getWebAppName(),
      'app_version': _getWebAppVersion(),
      'platform': _getWebPlatform(),
      'language': _getWebLanguage(),
      'languages': _getWebLanguages(),
      'online': _isWebOnline(),
      'cookie_enabled': _isWebCookieEnabled(),
      'java_enabled': _isWebJavaEnabled(),
      'web_runtime': 'Flutter Web',
    };
  }

  static Map<String, dynamic> _collectBrowserInfo() {
    if (!kIsWeb) return {'note': 'Not applicable for native platforms'};

    Map<String, dynamic> browserInfo = {
      'user_agent': _getWebUserAgent(),
      'vendor': _getWebVendor(),
      'app_name': _getWebAppName(),
      'app_version': _getWebAppVersion(),
      'platform': _getWebPlatform(),
      'product': _getWebProduct(),
    };

    final userAgent = _getWebUserAgent();
    browserInfo.addAll(_parseUserAgent(userAgent));

    return browserInfo;
  }

  static Map<String, dynamic> _collectFlutterInfo() {
    return {
      'is_release_mode': kReleaseMode,
      'is_debug_mode': kDebugMode,
      'is_profile_mode': kProfileMode,
      'is_web': kIsWeb,
      'default_target_platform': defaultTargetPlatform.toString(),
      'build_mode':
          kReleaseMode ? 'release' : (kDebugMode ? 'debug' : 'profile'),
      'flutter_runtime': kIsWeb ? 'Flutter Web' : 'Flutter Native',
    };
  }

  static Map<String, dynamic> _collectDartInfo() {
    Map<String, dynamic> dartInfo = {
      'is_web': kIsWeb,
      'runtime_type': kIsWeb ? 'dart2js' : 'dart_vm',
    };

    if (!kIsWeb) {
      try {
        dartInfo['dart_version'] = 'Available on native platforms only';
      } catch (e) {
        dartInfo['dart_version_error'] = e.toString();
      }
    } else {
      dartInfo['dart_version'] = 'Compiled to JavaScript';
      dartInfo['compilation_target'] = 'JavaScript';
    }

    return dartInfo;
  }

  static Map<String, dynamic> _collectDisplayInfo() {
    try {
      final binding = WidgetsBinding.instance;
      final view = binding.platformDispatcher.views.isNotEmpty
          ? binding.platformDispatcher.views.first
          : null;

      if (view == null) {
        return {'error': 'No display view available'};
      }

      Map<String, dynamic> displayInfo = {
        'device_pixel_ratio': view.devicePixelRatio,
        'physical_size': {
          'width': view.physicalSize.width,
          'height': view.physicalSize.height,
        },
        'logical_size': {
          'width': view.physicalSize.width / view.devicePixelRatio,
          'height': view.physicalSize.height / view.devicePixelRatio,
        },
        'padding': {
          'top': view.padding.top,
          'bottom': view.padding.bottom,
          'left': view.padding.left,
          'right': view.padding.right,
        },
        'view_insets': {
          'top': view.viewInsets.top,
          'bottom': view.viewInsets.bottom,
          'left': view.viewInsets.left,
          'right': view.viewInsets.right,
        },
        'system_gesture_insets': {
          'top': view.systemGestureInsets.top,
          'bottom': view.systemGestureInsets.bottom,
          'left': view.systemGestureInsets.left,
          'right': view.systemGestureInsets.right,
        },
      };

      if (kIsWeb) {
        displayInfo.addAll(_getWebDisplayInfo());
      }

      return displayInfo;
    } catch (e) {
      return {'error': 'Failed to collect display info: ${e.toString()}'};
    }
  }

  static Future<Map<String, dynamic>> _collectAndroidInfo() async {
    try {
      final result = await _channel.invokeMethod('getAndroidInfo');
      return Map<String, dynamic>.from(result ?? {});
    } catch (e) {
      return {'error': 'Failed to get Android info: ${e.toString()}'};
    }
  }

  static Future<Map<String, dynamic>> _collectIOSInfo() async {
    try {
      final result = await _channel.invokeMethod('getIOSInfo');
      return Map<String, dynamic>.from(result ?? {});
    } catch (e) {
      return {'error': 'Failed to get iOS info: ${e.toString()}'};
    }
  }

  static Future<Map<String, dynamic>> _collectWindowsInfo() async {
    try {
      final result = await _channel.invokeMethod('getWindowsInfo');
      return Map<String, dynamic>.from(result ?? {});
    } catch (e) {
      return {'error': 'Failed to get Windows info: ${e.toString()}'};
    }
  }

  static Future<Map<String, dynamic>> _collectMacOSInfo() async {
    try {
      final result = await _channel.invokeMethod('getMacOSInfo');
      return Map<String, dynamic>.from(result ?? {});
    } catch (e) {
      return {'error': 'Failed to get macOS info: ${e.toString()}'};
    }
  }

  static Future<Map<String, dynamic>> _collectLinuxInfo() async {
    try {
      final result = await _channel.invokeMethod('getLinuxInfo');
      return Map<String, dynamic>.from(result ?? {});
    } catch (e) {
      return {'error': 'Failed to get Linux info: ${e.toString()}'};
    }
  }

  static Future<Map<String, dynamic>> _collectNetworkInfo() async {
    Map<String, dynamic> networkInfo = {};

    if (kIsWeb) {
      networkInfo.addAll(_getWebNetworkInfo());
    } else {
      try {
        final result = await _channel.invokeMethod('getNetworkInfo');
        networkInfo = Map<String, dynamic>.from(result ?? {});
      } catch (e) {
        networkInfo['error'] = 'Failed to get network info: ${e.toString()}';
      }
    }

    return networkInfo;
  }

  static Future<Map<String, dynamic>> _collectSystemInfo() async {
    Map<String, dynamic> systemInfo = {};

    if (kIsWeb) {
      systemInfo.addAll(_getWebSystemInfo());
    } else {
      try {
        final result = await _channel.invokeMethod('getSystemInfo');
        systemInfo = Map<String, dynamic>.from(result ?? {});
      } catch (e) {
        systemInfo['error'] = 'Failed to get system info: ${e.toString()}';
      }
    }

    return systemInfo;
  }

  static Map<String, dynamic> _collectEnvironmentInfo() {
    Map<String, dynamic> envInfo = {
      'platform_type': kIsWeb ? 'web' : 'native',
      'runtime_environment': kIsWeb ? 'browser' : 'native_os',
    };

    if (!kIsWeb) {
      try {
        envInfo['note'] =
            'Environment variables available on native platforms only';
      } catch (e) {
        envInfo['error'] = e.toString();
      }
    } else {
      envInfo['web_environment'] = 'Browser Runtime';
      envInfo['javascript_enabled'] = true;
    }

    return envInfo;
  }

  static Map<String, dynamic> _collectAppInfo() {
    return {
      'is_flutter_app': true,
      'runtime_type': kIsWeb ? 'web' : 'native',
      'compilation_mode':
          kReleaseMode ? 'release' : (kDebugMode ? 'debug' : 'profile'),
      'platform_channel_support': !kIsWeb,
      'assertions_enabled': () {
        bool assertionsEnabled = false;
        assert(assertionsEnabled = true);
        return assertionsEnabled;
      }(),
    };
  }

  static String _getWebUserAgent() {
    if (!kIsWeb) return 'Not available on native platforms';
    try {
      return html.window.navigator.userAgent;
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  static String _getWebAppName() {
    if (!kIsWeb) return 'Not available on native platforms';
    try {
      return html.window.navigator.appName;
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  static String _getWebAppVersion() {
    if (!kIsWeb) return 'Not available on native platforms';
    try {
      return html.window.navigator.appVersion;
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  static String _getWebPlatform() {
    if (!kIsWeb) return 'Not available on native platforms';
    try {
      return html.window.navigator.platform ?? 'Unknown';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  static String _getWebVendor() {
    if (!kIsWeb) return 'Not available on native platforms';
    try {
      return html.window.navigator.vendor;
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  static String _getWebProduct() {
    if (!kIsWeb) return 'Not available on native platforms';
    try {
      return html.window.navigator.product;
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  static String _getWebLanguage() {
    if (!kIsWeb) return 'Not available on native platforms';
    try {
      return html.window.navigator.language;
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  static List<String> _getWebLanguages() {
    if (!kIsWeb) return ['Not available on native platforms'];
    try {
      return html.window.navigator.languages ?? ['Unknown'];
    } catch (e) {
      return ['Error: ${e.toString()}'];
    }
  }

  static bool _isWebOnline() {
    if (!kIsWeb) return false;
    try {
      return html.window.navigator.onLine ?? false;
    } catch (e) {
      return false;
    }
  }

  static bool _isWebCookieEnabled() {
    if (!kIsWeb) return false;
    try {
      return html.window.navigator.cookieEnabled ?? false;
    } catch (e) {
      return false;
    }
  }

  static bool _isWebJavaEnabled() {
    if (!kIsWeb) return false;
    try {
      return false;
    } catch (e) {
      return false;
    }
  }

  static Map<String, dynamic> _getWebDisplayInfo() {
    if (!kIsWeb) return {'note': 'Not available on native platforms'};

    try {
      return {
        'screen_width': html.window.screen?.width ?? 0,
        'screen_height': html.window.screen?.height ?? 0,
        'available_width': html.window.screen?.available.width ?? 0,
        'available_height': html.window.screen?.available.height ?? 0,
        'color_depth': html.window.screen?.colorDepth ?? 0,
        'pixel_depth': html.window.screen?.pixelDepth ?? 0,
        'inner_width': html.window.innerWidth ?? 0,
        'inner_height': html.window.innerHeight ?? 0,
        'outer_width': html.window.outerWidth,
        'outer_height': html.window.outerHeight,
        'device_pixel_ratio': html.window.devicePixelRatio,
      };
    } catch (e) {
      return {'error': 'Failed to get web display info: ${e.toString()}'};
    }
  }

  static Map<String, dynamic> _getWebNetworkInfo() {
    if (!kIsWeb) return {'note': 'Not available on native platforms'};

    return {
      'online': _isWebOnline(),
      'connection_type': 'web_browser',
      'protocol': html.window.location.protocol,
      'host': html.window.location.host,
      'hostname': html.window.location.hostname,
      'port': html.window.location.port,
      'origin': html.window.location.origin,
    };
  }

  static Map<String, dynamic> _getWebSystemInfo() {
    if (!kIsWeb) return {'note': 'Not available on native platforms'};

    try {
      return {
        'hardware_concurrency': html.window.navigator.hardwareConcurrency ?? 0,
        'max_touch_points': html.window.navigator.maxTouchPoints ?? 0,
        'memory': html.window.performance.memory != null
            ? {
                'used_js_heap_size':
                    html.window.performance.memory!.usedJSHeapSize,
                'total_js_heap_size':
                    html.window.performance.memory!.totalJSHeapSize,
                'js_heap_size_limit':
                    html.window.performance.memory!.jsHeapSizeLimit,
              }
            : null,
        'timing': {
          'navigation_start': html.window.performance.timing.navigationStart,
          'load_event_end': html.window.performance.timing.loadEventEnd,
          'dom_complete': html.window.performance.timing.domComplete,
        },
      };
    } catch (e) {
      return {'error': 'Failed to get web system info: ${e.toString()}'};
    }
  }

  static Map<String, dynamic> _parseUserAgent(String userAgent) {
    Map<String, dynamic> parsed = {
      'browser_name': 'Unknown',
      'browser_version': 'Unknown',
      'operating_system': 'Unknown',
      'device_type': 'Unknown',
    };

    if (userAgent.contains('Chrome')) {
      parsed['browser_name'] = 'Chrome';
      final chromeMatch = RegExp(r'Chrome/(\d+\.\d+)').firstMatch(userAgent);
      if (chromeMatch != null) {
        parsed['browser_version'] = chromeMatch.group(1);
      }
    } else if (userAgent.contains('Firefox')) {
      parsed['browser_name'] = 'Firefox';
      final firefoxMatch = RegExp(r'Firefox/(\d+\.\d+)').firstMatch(userAgent);
      if (firefoxMatch != null) {
        parsed['browser_version'] = firefoxMatch.group(1);
      }
    } else if (userAgent.contains('Safari') && !userAgent.contains('Chrome')) {
      parsed['browser_name'] = 'Safari';
      final safariMatch = RegExp(r'Version/(\d+\.\d+)').firstMatch(userAgent);
      if (safariMatch != null) {
        parsed['browser_version'] = safariMatch.group(1);
      }
    } else if (userAgent.contains('Edge')) {
      parsed['browser_name'] = 'Edge';
      final edgeMatch = RegExp(r'Edge/(\d+\.\d+)').firstMatch(userAgent);
      if (edgeMatch != null) {
        parsed['browser_version'] = edgeMatch.group(1);
      }
    }

    if (userAgent.contains('Windows')) {
      parsed['operating_system'] = 'Windows';
    } else if (userAgent.contains('Mac OS')) {
      parsed['operating_system'] = 'macOS';
    } else if (userAgent.contains('Linux')) {
      parsed['operating_system'] = 'Linux';
    } else if (userAgent.contains('Android')) {
      parsed['operating_system'] = 'Android';
    } else if (userAgent.contains('iOS')) {
      parsed['operating_system'] = 'iOS';
    }

    if (userAgent.contains('Mobile')) {
      parsed['device_type'] = 'Mobile';
    } else if (userAgent.contains('Tablet')) {
      parsed['device_type'] = 'Tablet';
    } else {
      parsed['device_type'] = 'Desktop';
    }

    return parsed;
  }

  static Future<dynamic> import(String library) async {
    throw UnsupportedError('Dynamic imports not supported in this context');
  }

  static void _printCompleteDeviceInfo(Map<String, dynamic> deviceInfo) {
    if (!kDebugMode) return;

    print('╔══════════════════════════════════════════════════════════════╗');
    print('║                    DEVICE INFORMATION REPORT                ║');
    print(
        '║                     ${kIsWeb ? "WEB PLATFORM" : "NATIVE PLATFORM"}                       ║');
    print('║                         DEBUG MODE                          ║');
    print('╚══════════════════════════════════════════════════════════════╝');

    _printSection('📊 COLLECTION INFO', deviceInfo['collection_info']);

    _printSection('🖥️  PLATFORM INFO', deviceInfo['platform_info']);

    _printSection('🔷 FLUTTER INFO', deviceInfo['flutter_info']);

    _printSection('🎯 DART INFO', deviceInfo['dart_info']);

    _printSection('📱 DISPLAY INFO', deviceInfo['display_info']);

    if (deviceInfo.containsKey('web_info')) {
      _printSection('🌐 WEB INFO', deviceInfo['web_info']);
    }
    if (deviceInfo.containsKey('browser_info')) {
      _printSection('🌍 BROWSER INFO', deviceInfo['browser_info']);
    }

    if (deviceInfo.containsKey('native_platform_info')) {
      _printSection(
          '💻 NATIVE PLATFORM INFO', deviceInfo['native_platform_info']);
    }

    _printSection('🌐 NETWORK INFO', deviceInfo['network_info']);

    _printSection('⚙️  SYSTEM INFO', deviceInfo['system_info']);

    _printSection('🌍 ENVIRONMENT INFO', deviceInfo['environment_info']);

    _printSection('📱 APP INFO', deviceInfo['app_info']);

    if (deviceInfo.containsKey('collection_error')) {
      _printSection('❌ COLLECTION ERRORS', deviceInfo['collection_error']);
    }

    print('\n╔══════════════════════════════════════════════════════════════╗');
    print('║                        JSON OUTPUT                          ║');
    print('╚══════════════════════════════════════════════════════════════╝');

    try {
      final jsonString = const JsonEncoder.withIndent('  ').convert(deviceInfo);
      print(jsonString);
    } catch (e) {
      print('Error converting to JSON: $e');
    }

    print('\n╔══════════════════════════════════════════════════════════════╗');
    print('║                    COLLECTION COMPLETED                     ║');
    print(
        '║                Platform: ${kIsWeb ? "WEB" : "NATIVE"}                        ║');
    print('║                        DEBUG MODE                           ║');
    print('╚══════════════════════════════════════════════════════════════╝\n');
  }

  static void _printSection(String title, dynamic data) {
    if (!kDebugMode) return;

    print('\n┌─ $title');

    if (data == null) {
      print('│ No data available');
      return;
    }

    if (data is Map<String, dynamic>) {
      data.forEach((key, value) {
        if (value is Map || value is List) {
          print('│ $key: ${_formatComplexValue(value)}');
        } else {
          print('│ $key: ${value ?? 'null'}');
        }
      });
    } else {
      print('│ ${data.toString()}');
    }

    print('└─────────────────────────────────────────────────────────────');
  }

  static String _formatComplexValue(dynamic value) {
    try {
      if (value is Map || value is List) {
        return const JsonEncoder().convert(value);
      }
      return value.toString();
    } catch (e) {
      return value.toString();
    }
  }
}
