class DeviceInfoModel {
  final CollectionInfo? collectionInfo;
  final PlatformInfo? platformInfo;
  final FlutterInfo? flutterInfo;
  final DartInfo? dartInfo;
  final DisplayInfo? displayInfo;
  final WebInfo? webInfo;
  final BrowserInfo? browserInfo;
  final NetworkInfo? networkInfo;
  final SystemInfo? systemInfo;
  final EnvironmentInfo? environmentInfo;
  final AppInfo? appInfo;

  DeviceInfoModel({
    this.collectionInfo,
    this.platformInfo,
    this.flutterInfo,
    this.dartInfo,
    this.displayInfo,
    this.webInfo,
    this.browserInfo,
    this.networkInfo,
    this.systemInfo,
    this.environmentInfo,
    this.appInfo,
  });

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) {
    return DeviceInfoModel(
      collectionInfo: json['collection_info'] != null
          ? CollectionInfo.fromJson(json['collection_info'])
          : null,
      platformInfo: json['platform_info'] != null
          ? PlatformInfo.fromJson(json['platform_info'])
          : null,
      flutterInfo: json['flutter_info'] != null
          ? FlutterInfo.fromJson(json['flutter_info'])
          : null,
      dartInfo: json['dart_info'] != null
          ? DartInfo.fromJson(json['dart_info'])
          : null,
      displayInfo: json['display_info'] != null
          ? DisplayInfo.fromJson(json['display_info'])
          : null,
      webInfo:
          json['web_info'] != null ? WebInfo.fromJson(json['web_info']) : null,
      browserInfo: json['browser_info'] != null
          ? BrowserInfo.fromJson(json['browser_info'])
          : null,
      networkInfo: json['network_info'] != null
          ? NetworkInfo.fromJson(json['network_info'])
          : null,
      systemInfo: json['system_info'] != null
          ? SystemInfo.fromJson(json['system_info'])
          : null,
      environmentInfo: json['environment_info'] != null
          ? EnvironmentInfo.fromJson(json['environment_info'])
          : null,
      appInfo:
          json['app_info'] != null ? AppInfo.fromJson(json['app_info']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collection_info': collectionInfo?.toJson(),
      'platform_info': platformInfo?.toJson(),
      'flutter_info': flutterInfo?.toJson(),
      'dart_info': dartInfo?.toJson(),
      'display_info': displayInfo?.toJson(),
      'web_info': webInfo?.toJson(),
      'browser_info': browserInfo?.toJson(),
      'network_info': networkInfo?.toJson(),
      'system_info': systemInfo?.toJson(),
      'environment_info': environmentInfo?.toJson(),
      'app_info': appInfo?.toJson(),
    };
  }
}

class CollectionInfo {
  final String? timestampUtc;
  final String? timestampFormatted;
  final String? collectorVersion;
  final String? userLogin;
  final String? collectionEnvironment;

  CollectionInfo({
    this.timestampUtc,
    this.timestampFormatted,
    this.collectorVersion,
    this.userLogin,
    this.collectionEnvironment,
  });

  factory CollectionInfo.fromJson(Map<String, dynamic> json) {
    return CollectionInfo(
      timestampUtc: json['timestamp_utc'],
      timestampFormatted: json['timestamp_formatted'],
      collectorVersion: json['collector_version'],
      userLogin: json['user_login'],
      collectionEnvironment: json['collection_environment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp_utc': timestampUtc,
      'timestamp_formatted': timestampFormatted,
      'collector_version': collectorVersion,
      'user_login': userLogin,
      'collection_environment': collectionEnvironment,
    };
  }
}

class PlatformInfo {
  final bool? isWeb;
  final String? defaultTargetPlatform;
  final String? platformType;
  final String? userAgent;
  final String? language;
  final List<String>? languages;
  final bool? online;
  final bool? cookieEnabled;
  final bool? javaEnabled;

  PlatformInfo({
    this.isWeb,
    this.defaultTargetPlatform,
    this.platformType,
    this.userAgent,
    this.language,
    this.languages,
    this.online,
    this.cookieEnabled,
    this.javaEnabled,
  });

  factory PlatformInfo.fromJson(Map<String, dynamic> json) {
    return PlatformInfo(
      isWeb: json['is_web'],
      defaultTargetPlatform: json['default_target_platform'],
      platformType: json['platform_type'],
      userAgent: json['user_agent'],
      language: json['language'],
      languages: json['languages']?.cast<String>(),
      online: json['online'],
      cookieEnabled: json['cookie_enabled'],
      javaEnabled: json['java_enabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_web': isWeb,
      'default_target_platform': defaultTargetPlatform,
      'platform_type': platformType,
      'user_agent': userAgent,
      'language': language,
      'languages': languages,
      'online': online,
      'cookie_enabled': cookieEnabled,
      'java_enabled': javaEnabled,
    };
  }
}

class FlutterInfo {
  final bool? isReleaseMode;
  final bool? isDebugMode;
  final bool? isProfileMode;
  final bool? isWeb;
  final String? defaultTargetPlatform;
  final String? buildMode;
  final String? flutterRuntime;

  FlutterInfo({
    this.isReleaseMode,
    this.isDebugMode,
    this.isProfileMode,
    this.isWeb,
    this.defaultTargetPlatform,
    this.buildMode,
    this.flutterRuntime,
  });

  factory FlutterInfo.fromJson(Map<String, dynamic> json) {
    return FlutterInfo(
      isReleaseMode: json['is_release_mode'],
      isDebugMode: json['is_debug_mode'],
      isProfileMode: json['is_profile_mode'],
      isWeb: json['is_web'],
      defaultTargetPlatform: json['default_target_platform'],
      buildMode: json['build_mode'],
      flutterRuntime: json['flutter_runtime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_release_mode': isReleaseMode,
      'is_debug_mode': isDebugMode,
      'is_profile_mode': isProfileMode,
      'is_web': isWeb,
      'default_target_platform': defaultTargetPlatform,
      'build_mode': buildMode,
      'flutter_runtime': flutterRuntime,
    };
  }
}

class DartInfo {
  final bool? isWeb;
  final String? runtime;
  final String? dartVersion;
  final String? compilationTarget;

  DartInfo({
    this.isWeb,
    this.runtime,
    this.dartVersion,
    this.compilationTarget,
  });

  factory DartInfo.fromJson(Map<String, dynamic> json) {
    return DartInfo(
      isWeb: json['is_web'],
      runtime: json['runtime_type'],
      dartVersion: json['dart_version'],
      compilationTarget: json['compilation_target'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_web': isWeb,
      'runtime_type': runtime,
      'dart_version': dartVersion,
      'compilation_target': compilationTarget,
    };
  }
}

class DisplayInfo {
  final String? devicePixelRatio;
  final SizeInfo? physicalSize;
  final SizeInfo? logicalSize;
  final EdgeInsets? padding;
  final EdgeInsets? viewInsets;
  final EdgeInsets? systemGestureInsets;
  final String? screenWidth;
  final String? screenHeight;
  final String? availableWidth;
  final String? availableHeight;
  final String? colorDepth;
  final String? pixelDepth;
  final String? innerWidth;
  final String? innerHeight;
  final String? outerWidth;
  final String? outerHeight;

  DisplayInfo({
    this.devicePixelRatio,
    this.physicalSize,
    this.logicalSize,
    this.padding,
    this.viewInsets,
    this.systemGestureInsets,
    this.screenWidth,
    this.screenHeight,
    this.availableWidth,
    this.availableHeight,
    this.colorDepth,
    this.pixelDepth,
    this.innerWidth,
    this.innerHeight,
    this.outerWidth,
    this.outerHeight,
  });

  factory DisplayInfo.fromJson(Map<String, dynamic> json) {
    return DisplayInfo(
      devicePixelRatio: json['device_pixel_ratio']?.toString(),
      physicalSize: json['physical_size'] != null
          ? SizeInfo.fromJson(json['physical_size'])
          : null,
      logicalSize: json['logical_size'] != null
          ? SizeInfo.fromJson(json['logical_size'])
          : null,
      padding:
          json['padding'] != null ? EdgeInsets.fromJson(json['padding']) : null,
      viewInsets: json['view_insets'] != null
          ? EdgeInsets.fromJson(json['view_insets'])
          : null,
      systemGestureInsets: json['system_gesture_insets'] != null
          ? EdgeInsets.fromJson(json['system_gesture_insets'])
          : null,
      screenWidth: json['screen_width']?.toString(),
      screenHeight: json['screen_height']?.toString(),
      availableWidth: json['available_width']?.toString(),
      availableHeight: json['available_height']?.toString(),
      colorDepth: json['color_depth']?.toString(),
      pixelDepth: json['pixel_depth']?.toString(),
      innerWidth: json['inner_width']?.toString(),
      innerHeight: json['inner_height']?.toString(),
      outerWidth: json['outer_width']?.toString(),
      outerHeight: json['outer_height']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device_pixel_ratio': devicePixelRatio,
      'physical_size': physicalSize?.toJson(),
      'logical_size': logicalSize?.toJson(),
      'padding': padding?.toJson(),
      'view_insets': viewInsets?.toJson(),
      'system_gesture_insets': systemGestureInsets?.toJson(),
      'screen_width': screenWidth,
      'screen_height': screenHeight,
      'available_width': availableWidth,
      'available_height': availableHeight,
      'color_depth': colorDepth,
      'pixel_depth': pixelDepth,
      'inner_width': innerWidth,
      'inner_height': innerHeight,
      'outer_width': outerWidth,
      'outer_height': outerHeight,
    };
  }
}

class SizeInfo {
  final String? width;
  final String? height;

  SizeInfo({this.width, this.height});

  factory SizeInfo.fromJson(Map<String, dynamic> json) {
    return SizeInfo(
      width: json['width']?.toString(),
      height: json['height']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
    };
  }
}

class EdgeInsets {
  final String? top;
  final String? bottom;
  final String? left;
  final String? right;

  EdgeInsets({this.top, this.bottom, this.left, this.right});

  factory EdgeInsets.fromJson(Map<String, dynamic> json) {
    return EdgeInsets(
      top: json['top']?.toString(),
      bottom: json['bottom']?.toString(),
      left: json['left']?.toString(),
      right: json['right']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'top': top,
      'bottom': bottom,
      'left': left,
      'right': right,
    };
  }
}

class WebInfo {
  final bool? isWebPlatform;
  final String? userAgent;
  final String? appName;
  final String? appVersion;
  final String? platform;
  final String? language;
  final List<String>? languages;
  final bool? online;
  final bool? cookieEnabled;
  final bool? javaEnabled;
  final String? webRuntime;

  WebInfo({
    this.isWebPlatform,
    this.userAgent,
    this.appName,
    this.appVersion,
    this.platform,
    this.language,
    this.languages,
    this.online,
    this.cookieEnabled,
    this.javaEnabled,
    this.webRuntime,
  });

  factory WebInfo.fromJson(Map<String, dynamic> json) {
    return WebInfo(
      isWebPlatform: json['is_web_platform'],
      userAgent: json['user_agent'],
      appName: json['app_name'],
      appVersion: json['app_version'],
      platform: json['platform'],
      language: json['language'],
      languages: json['languages']?.cast<String>(),
      online: json['online'],
      cookieEnabled: json['cookie_enabled'],
      javaEnabled: json['java_enabled'],
      webRuntime: json['web_runtime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_web_platform': isWebPlatform,
      'user_agent': userAgent,
      'app_name': appName,
      'app_version': appVersion,
      'platform': platform,
      'language': language,
      'languages': languages,
      'online': online,
      'cookie_enabled': cookieEnabled,
      'java_enabled': javaEnabled,
      'web_runtime': webRuntime,
    };
  }
}

class BrowserInfo {
  final String? userAgent;
  final String? vendor;
  final String? appName;
  final String? appVersion;
  final String? platform;
  final String? product;
  final String? browserName;
  final String? browserVersion;
  final String? operatingSystem;
  final String? deviceType;

  BrowserInfo({
    this.userAgent,
    this.vendor,
    this.appName,
    this.appVersion,
    this.platform,
    this.product,
    this.browserName,
    this.browserVersion,
    this.operatingSystem,
    this.deviceType,
  });

  factory BrowserInfo.fromJson(Map<String, dynamic> json) {
    return BrowserInfo(
      userAgent: json['user_agent'],
      vendor: json['vendor'],
      appName: json['app_name'],
      appVersion: json['app_version'],
      platform: json['platform'],
      product: json['product'],
      browserName: json['browser_name'],
      browserVersion: json['browser_version'],
      operatingSystem: json['operating_system'],
      deviceType: json['device_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_agent': userAgent,
      'vendor': vendor,
      'app_name': appName,
      'app_version': appVersion,
      'platform': platform,
      'product': product,
      'browser_name': browserName,
      'browser_version': browserVersion,
      'operating_system': operatingSystem,
      'device_type': deviceType,
    };
  }
}

class NetworkInfo {
  final bool? online;
  final String? connectionType;
  final String? protocol;
  final String? host;
  final String? hostname;
  final String? port;
  final String? origin;

  NetworkInfo({
    this.online,
    this.connectionType,
    this.protocol,
    this.host,
    this.hostname,
    this.port,
    this.origin,
  });

  factory NetworkInfo.fromJson(Map<String, dynamic> json) {
    return NetworkInfo(
      online: json['online'],
      connectionType: json['connection_type'],
      protocol: json['protocol'],
      host: json['host'],
      hostname: json['hostname'],
      port: json['port']?.toString(),
      origin: json['origin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'online': online,
      'connection_type': connectionType,
      'protocol': protocol,
      'host': host,
      'hostname': hostname,
      'port': port,
      'origin': origin,
    };
  }
}

class SystemInfo {
  final String? hardwareConcurrency;
  final String? maxTouchPoints;
  final MemoryInfo? memory;
  final TimingInfo? timing;

  SystemInfo({
    this.hardwareConcurrency,
    this.maxTouchPoints,
    this.memory,
    this.timing,
  });

  factory SystemInfo.fromJson(Map<String, dynamic> json) {
    return SystemInfo(
      hardwareConcurrency: json['hardware_concurrency']?.toString(),
      maxTouchPoints: json['max_touch_points']?.toString(),
      memory:
          json['memory'] != null ? MemoryInfo.fromJson(json['memory']) : null,
      timing:
          json['timing'] != null ? TimingInfo.fromJson(json['timing']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hardware_concurrency': hardwareConcurrency,
      'max_touch_points': maxTouchPoints,
      'memory': memory?.toJson(),
      'timing': timing?.toJson(),
    };
  }
}

class MemoryInfo {
  final String? usedJsHeapSize;
  final String? totalJsHeapSize;
  final String? jsHeapSizeLimit;

  MemoryInfo({
    this.usedJsHeapSize,
    this.totalJsHeapSize,
    this.jsHeapSizeLimit,
  });

  factory MemoryInfo.fromJson(Map<String, dynamic> json) {
    return MemoryInfo(
      usedJsHeapSize: json['used_js_heap_size']?.toString(),
      totalJsHeapSize: json['total_js_heap_size']?.toString(),
      jsHeapSizeLimit: json['js_heap_size_limit']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'used_js_heap_size': usedJsHeapSize,
      'total_js_heap_size': totalJsHeapSize,
      'js_heap_size_limit': jsHeapSizeLimit,
    };
  }
}

class TimingInfo {
  final String? navigationStart;
  final String? loadEventEnd;
  final String? domComplete;

  TimingInfo({
    this.navigationStart,
    this.loadEventEnd,
    this.domComplete,
  });

  factory TimingInfo.fromJson(Map<String, dynamic> json) {
    return TimingInfo(
      navigationStart: json['navigation_start']?.toString(),
      loadEventEnd: json['load_event_end']?.toString(),
      domComplete: json['dom_complete']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'navigation_start': navigationStart,
      'load_event_end': loadEventEnd,
      'dom_complete': domComplete,
    };
  }
}

class EnvironmentInfo {
  final String? platformType;
  final String? runtimeEnvironment;
  final String? webEnvironment;
  final bool? javascriptEnabled;

  EnvironmentInfo({
    this.platformType,
    this.runtimeEnvironment,
    this.webEnvironment,
    this.javascriptEnabled,
  });

  factory EnvironmentInfo.fromJson(Map<String, dynamic> json) {
    return EnvironmentInfo(
      platformType: json['platform_type'],
      runtimeEnvironment: json['runtime_environment'],
      webEnvironment: json['web_environment'],
      javascriptEnabled: json['javascript_enabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform_type': platformType,
      'runtime_environment': runtimeEnvironment,
      'web_environment': webEnvironment,
      'javascript_enabled': javascriptEnabled,
    };
  }
}

class AppInfo {
  final bool? isFlutterApp;
  final String? runtime;
  final String? compilationMode;
  final bool? platformChannelSupport;
  final bool? assertionsEnabled;

  AppInfo({
    this.isFlutterApp,
    this.runtime,
    this.compilationMode,
    this.platformChannelSupport,
    this.assertionsEnabled,
  });

  factory AppInfo.fromJson(Map<String, dynamic> json) {
    return AppInfo(
      isFlutterApp: json['is_flutter_app'],
      runtime: json['runtime_type'],
      compilationMode: json['compilation_mode'],
      platformChannelSupport: json['platform_channel_support'],
      assertionsEnabled: json['assertions_enabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_flutter_app': isFlutterApp,
      'runtime_type': runtime,
      'compilation_mode': compilationMode,
      'platform_channel_support': platformChannelSupport,
      'assertions_enabled': assertionsEnabled,
    };
  }
}
