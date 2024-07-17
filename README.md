# How to perform an action using shortcut keys for buttons in Flutter DataTable (SfDataGrid)?.

In this article, we will show you how to perform an action using shortcut keys for buttons in [Flutter DataTable](https://www.syncfusion.com/flutter-widgets/flutter-datagrid).

Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all necessary properties. By using the [handleKeyEvent()](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/RowSelectionManager/handleKeyEvent.html) method in the [RowSelectionManager](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/RowSelectionManager-class.html) with selection enabled, we can fetch the respective row details based on the [currentCell](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridController/currentCell.html) when the Fn key is pressed. To perform an action using shortcut keys for buttons, you need to maintain the currentCell on the button cells. Based on the key pressed, we perform the respective action for the corresponding button.

```dart
  @override
  Future<void> handleKeyEvent(KeyEvent keyEvent) async {
    // Only trigger for the button columns when the current cell is in the button column.
    // So we have checked the columnIndex == 3.
    if (keyEvent.logicalKey == LogicalKeyboardKey.f1 &&
        dataGridController.currentCell.columnIndex == 3) {
      // To show the respective Button1 row details when F1 is pressed.
      handleButton1Pressed();

      return;
    } else if (keyEvent.logicalKey == LogicalKeyboardKey.f2 &&
        dataGridController.currentCell.columnIndex == 3) {
      // To show the respective Button2 row details when F2 is pressed.
      handleButton2Pressed();

      return;
    }
    super.handleKeyEvent(keyEvent);
  }
```

You can download this example on [GitHub](https://github.com/SyncfusionExamples/How-to-perform-an-action-using-shortcut-keys-for-buttons-in-Flutter-DataTable).