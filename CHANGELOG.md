## 0.0.1

- Implement Logger initial code

## 0.0.2

- Implement benchmark logging for timing methods logs

## 0.0.3

- Implement search field and refactor log_manager to handle search

## 0.0.4

- Added documentation

## 0.0.5

- Added LogType and additional log options.

```dart
enum LogType {
  network,
  button,
  database,
  ui,
  api,
  other,
  error,
  warning,
  success,
  info,
  fatal,
  timestamp,
}
```

- Added name to the log method to register the origin of the caller.

  > Logger.button.log('message', name: 'FloatingActionButton')

- Improved search field to handle keywords matching and multi types.

## 0.0.6

- Improved doc using ChatGPT

## 0.0.7

- added View by dropdown and implement a group view of logs based on their origin.
- added analytics tab and basic pie chart from fl_chart

## 0.0.8

- Update time format in LoggerTimeExtension to include seconds and ms
- _(Breaking Changes)_ Simplified Log writing
  > Logger.button('message', origin: 'FloatingActionButton')
