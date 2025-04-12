enum Environment {
  dev,
  stg,
  prod,
}

extension EnvironmentExt on Environment {
  String get envName {
    switch (this) {
      case Environment.dev:
        return 'DEV';
      case Environment.stg:
        return 'STG';
      case Environment.prod:
        return 'PROD';
    }
  }

  String get baseUrl {
    switch (this) {
      case Environment.dev:
        return "https://d7b8-2401-d800-254-3189-4dd3-c2ae-b794-6831.ngrok-free.app";
      case Environment.stg:
        return "http://stg";
      case Environment.prod:
        return "https://c8e0-1-55-211-216.ngrok-free.app/api";
    }
  }
}
