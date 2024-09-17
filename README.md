# retro_logger

`retro_logger` is a simple Dart package that allows users to log messages and display logs with a prebuilt widget in a retro style. This package is designed to be easy to use and integrate into your Dart or Flutter applications.

## Features

- Log messages with different levels (info, warning, error)
- Display logs in a retro-styled widget
- Customizable log display settings
- Lightweight and easy to integrate

## Getting started

### Prerequisites

- sdk: ^3.5.2
- flutter: ">=1.17.0"

### Installation

Add `retro_logger` to your `pubspec.yaml` file:

Using pub add (recommended):

> flutter pub add retro_logger

or by editing pubspec.yaml

```yaml
dependencies:
  retro_logger: ^0.0.1
```

Then, run flutter pub get to install the package.

Usage
Logging Messages
To log messages and register message, import the retro_logger package and use the Logger class:

```dart
import 'package:retro_logger/retro_logger.dart';


Logger.success.log('This is a success message')
Logger.info.log('This is an info message');
Logger.warning.log('This is a warning message');
Logger.error.log('This is an error message');
```

Displaying Logs:
to use pre-designed listview you can use the [LogListWidget]

```dart
import 'package:flutter/material.dart';
import 'package:retro_logger/retro_logger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Retro Logger Example'),
        ),
        body: Center(
          child: LogListWidget(),
        ),
      ),
    );
  }
}
```

You can also build your own widgets with the [LogManagerWidget]

```dart
LogManagerWidget(
    builder: (_, logs) {
      return YourCustomWidget();
    },
);
```

You can fine control the logs list by accessing the [LogManager.instance]

Additional information
For more information, visit the documentation.

Contributing
Contributions are welcome! Please see the contributing guidelines for more information.

Issues
If you encounter any issues, please file them here. We aim to respond to issues within 48 hours.

License
This package is licensed under the MIT License. See the LICENSE file for more information. ```
