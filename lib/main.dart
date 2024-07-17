import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SfDataGridDemo()));
}

class SfDataGridDemo extends StatefulWidget {
  const SfDataGridDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SfDataGridDemoState createState() => _SfDataGridDemoState();
}

class _SfDataGridDemoState extends State<SfDataGridDemo> {
  List<Employee> _employees = <Employee>[];
  DataGridController dataGridController = DataGridController();
  late EmployeeDataSource _employeeDataSource;

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees);
  }

  @override
  Widget build(BuildContext context) {
    _employeeDataSource._customSelectionManager = CustomSelectionManager(
        context, _employeeDataSource, dataGridController);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter SfDataGrid'),
      ),
      body: SfDataGrid(
          controller: dataGridController,
          selectionMode: SelectionMode.single,
          navigationMode: GridNavigationMode.cell,
          selectionManager: _employeeDataSource._customSelectionManager,
          source: _employeeDataSource,
          columns: [
            GridColumn(
              columnName: 'id',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('ID'),
              ),
            ),
            GridColumn(
              columnName: 'name',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('Name'),
              ),
            ),
            GridColumn(
              columnName: 'designation',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('Designation'),
              ),
            ),
            GridColumn(
              columnName: 'buttons',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('Buttons '),
              ),
            ),
          ]),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead '),
      Employee(10002, 'Kathryn', 'Manager'),
      Employee(10003, 'Lara', 'Developer'),
      Employee(10004, 'Michael', 'Designer'),
      Employee(10005, 'Martin', 'Developer'),
      Employee(10006, 'Newberry', 'Developer'),
      Employee(10007, 'Balnc', 'Developer'),
      Employee(10008, 'Perry', 'Developer'),
      Employee(10009, 'Gable', 'Developer'),
      Employee(10010, 'Grimes', 'Developer'),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    buildDataGridRow(employees);
  }

  void buildDataGridRow(List<Employee> employeeData) {
    dataGridRow = employeeData.map<DataGridRow>((employee) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: employee.id),
        DataGridCell<String>(columnName: 'name', value: employee.name),
        DataGridCell<String>(
            columnName: 'designation', value: employee.designation),
        const DataGridCell<Widget>(columnName: 'buttons', value: null),
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRow = <DataGridRow>[];

  late final CustomSelectionManager _customSelectionManager;

  @override
  List<DataGridRow> get rows => dataGridRow.isEmpty ? [] : dataGridRow;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          child: dataGridCell.columnName == 'buttons'
              ? LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Retrieve the details of the row corresponding to the pressed button.
                          _customSelectionManager.handleButton1Pressed(
                              true, row);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(30, 30),
                          padding: const EdgeInsets.all(8),
                        ),
                        child: const Text(
                          'B1',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Retrieve the details of the row corresponding to the pressed button.
                          _customSelectionManager.handleButton2Pressed(
                              true, row);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(30, 30),
                          padding: const EdgeInsets.all(8),
                        ),
                        child: const Text(
                          'B2',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                })
              : Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}

class Employee {
  Employee(this.id, this.name, this.designation);
  final int id;
  final String name;
  final String designation;
}

class CustomSelectionManager extends RowSelectionManager {
  CustomSelectionManager(
      this.context, this.employeeDataSource, this.dataGridController);
  BuildContext context;
  DataGridController dataGridController;
  late EmployeeDataSource employeeDataSource;

  void handleButton1Pressed([isButtonPressed = false, DataGridRow? row]) {
    var selectedRow = isButtonPressed
        ? row
        : employeeDataSource
            .effectiveRows[dataGridController.currentCell.rowIndex];

    // To show the respective Button1 row details.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Button1 Details'),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Employee ID: ${selectedRow!.getCells()[0].value.toString()}'),
                  Text(
                      'Employee Name: ${selectedRow.getCells()[1].value.toString()}'),
                  Text(
                      'Employee Designation: ${selectedRow.getCells()[2].value.toString()}'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return;
  }

  void handleButton2Pressed([isButtonPressed = false, DataGridRow? row]) {
    var selectedRow = isButtonPressed
        ? row
        : employeeDataSource
            .effectiveRows[dataGridController.currentCell.rowIndex];

    // To show the respective Button2 row details.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Button2 Details'),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Employee ID: ${selectedRow!.getCells()[0].value.toString()}'),
                  Text(
                      'Employee Name: ${selectedRow.getCells()[1].value.toString()}'),
                  Text(
                      'Employee Designation: ${selectedRow.getCells()[2].value.toString()}'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return;
  }

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
}
