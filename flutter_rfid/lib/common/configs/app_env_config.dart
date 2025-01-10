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
        return "http://localhost:3000";
      case Environment.stg:
        return "http://stg";
      case Environment.prod:
        return "https://c8e0-1-55-211-216.ngrok-free.app/api";
    }
  }
}
