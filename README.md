# 🚧 WARNING DEVELOPMENT IN PROGRESS 🚧

This package is in early stage development and might introduce breaking changes.

# Retro Logger

`retro_logger` is a lightweight Dart package that provides a retro-styled logging system for Dart and Flutter applications. It allows you to log messages with different levels and display them using a prebuilt widget, making debugging and monitoring easier and more visually appealing.

## Table of Contents

- [🚧 WARNING DEVELOPMENT IN PROGRESS 🚧](#-warning-development-in-progress-)
- [Retro Logger](#retro-logger)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Getting Started](#getting-started)
    - [Installation](#installation)
    - [Prerequisites](#prerequisites)
  - [Usage](#usage)
    - [Logging Messages](#logging-messages)
    - [Displaying Logs](#displaying-logs)
      - [Using `LogListWidget`](#using-loglistwidget)
      - [Customizing with `LogManagerWidget`](#customizing-with-logmanagerwidget)
      - [Accessing `LogManager` Instance](#accessing-logmanager-instance)
    - [Filtering and Searching Logs](#filtering-and-searching-logs)
    - [Benchmarking Functions](#benchmarking-functions)
      - [Synchronous Functions](#synchronous-functions)
      - [Asynchronous Functions](#asynchronous-functions)
  - [Additional Information](#additional-information)
  - [Contributing](#contributing)
  - [Issues](#issues)
  - [License](#license)

## Features

- **Multiple Log Levels**: Supports various log levels such as info, warning, error, success, network, UI, API, and more.
- **Retro-Styled Widget**: Provides a prebuilt widget to display logs in a retro style.
- **Filtering and Searching**: Easily filter logs by type and search by keywords.
- **Benchmarking Utilities**: Includes utilities to benchmark synchronous and asynchronous functions.
- **Lightweight**: Designed to be easy to integrate without adding significant overhead.

## Getting Started

### Installation

Add `retro_logger` to your `pubspec.yaml` file:

Using **Flutter**:

```bash
flutter pub add retro_logger
```

Or manually add the dependency:

```yaml
dependencies:
  retro_logger: ^0.0.1
```

Then, run:

```bash
flutter pub get
```

### Prerequisites

- Dart SDK: **^3.5.2**
- Flutter: **>=1.17.0**

## Usage

### Logging Messages

To log messages, import the `retro_logger` package and use the `Logger` class:

```dart
import 'package:retro_logger/retro_logger.dart';

void main() {
  Logger.success('This is a success message', origin: 'Main');
  Logger.info('This is an info message', origin: 'Main');
  Logger.warning('This is a warning message', origin: 'Main');
  Logger.error('This is an error message', origin: 'Main');
}
```

- **Note**: The `origin` parameter is a string that identifies where the log is coming from, making it easier to trace logs.

### Displaying Logs

#### Using `LogListWidget`

To display logs using the pre-designed list view, use the `LogListWidget`:

```dart
import 'package:flutter/material.dart';
import 'package:retro_logger/retro_logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retro Logger Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Retro Logger Example'),
        ),
        body: const LogListWidget(),
      ),
    );
  }
}
```

#### Customizing with `LogManagerWidget`

If you want to build your own custom log display, you can use `LogManagerWidget`:

```dart
import 'package:flutter/material.dart';
import 'package:retro_logger/retro_logger.dart';

class CustomLogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LogManagerWidget(
      builder: (context, logs) {
        return ListView.builder(
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            return ListTile(
              title: Text(log.message),
              subtitle: Text(log.origin),
              leading: Icon(Icons.bug_report, color: Logger.getColor(log.level)),
            );
          },
        );
      },
    );
  }
}
```

#### Accessing `LogManager` Instance

For advanced control over logs, you can directly interact with the `LogManager` singleton:

```dart
final LogManager logManager = LogManager.instance;

// Adding a log manually
logManager.addLog(Log(
  origin: 'CustomOrigin',
  level: 'info',
  message: 'This is a custom log message',
  type: LogType.other,
));

// Clearing all logs
logManager.clearLogs();

// Filtering logs by type
logManager.filterLogsByTypes({LogType.error, LogType.warning});

// Searching logs
logManager.searchLogs('search query');
```

### Filtering and Searching Logs

The `LogListWidget` comes with built-in filtering and searching capabilities:

- **Filtering by Log Type**: Click on the filter icon in the search bar to select log types to display.
- **Searching by Keyword**: Type in the search bar to filter logs containing specific keywords.

### Benchmarking Functions

Use `Logger`'s benchmarking utilities to measure the execution time of functions:

#### Synchronous Functions

```dart
  Logger.benchmark(()  {
    // your code here
  }, (String elapsedTime) {
    Logger.timestamp(
      'Benchmark completed in $elapsedTime',
      origin: '_simulateLogs',
    );
  });
```

#### Asynchronous Functions

```dart
  await Logger.benchmarkAsync(() async {
    // your code here
  }, (String elapsedTime) {
    Logger.timestamp(
      'Benchmark completed in $elapsedTime',
      origin: '_simulateLogs',
    );
  });
```

- **Note**: The benchmark results will be logged with the `timestamp` log level.

## Additional Information

For more detailed documentation and examples, please refer to the [official documentation](#).

## Contributing

Contributions are welcome! Please see the [contributing guidelines](CONTRIBUTING.md) for more information.

## Issues

If you encounter any issues, please [file them here](https://github.com/yourusername/retro_logger/issues). We aim to respond to issues within 48 hours.

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
