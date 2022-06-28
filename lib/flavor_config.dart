enum Environment { dev, staging, prod }

class _Config {
  static const flavor = 'flavor';
  static const name = 'name';

  static Map<String, dynamic> devConstants = {
    flavor: Environment.dev,
    name: "Swole bros DEV"
  };

  static Map<String, dynamic> stagingConstants = {
    flavor: Environment.staging,
    name: "Swole bros STAGING"
  };

  static Map<String, dynamic> prodConstants = {
    flavor: Environment.prod,
    name: "Swole bros STAGING"
  };
}

class Flavor {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = _Config.devConstants;
        break;
      case Environment.staging:
        _config = _Config.stagingConstants;
        break;
      case Environment.prod:
        _config = _Config.prodConstants;
        break;
    }
  }

  static Environment get current {
    return _config[_Config.flavor];
  }

  static String get name {
    return _config[_Config.name];
  }
}
