import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    anchors.fill: parent

    header: PageHeader {
        id: header
        title: i18n.tr('Create')
    }

    Column {
        id: tableForm
        anchors {
            top: header.bottom
            topMargin: units.gu(10)
            left: parent.left
            leftMargin: units.gu(2)
            right: parent.right
            rightMargin: units.gu(2)
            bottom: parent.bottom
        }

        property int tableColumns: 0

        TextField {
            id: tableName
            width: parent.width
            placeholderText: 'Table name'
        }
        Rectangle {
            width: parent.width
            height: units.gu(5)
        }
        Label {
            text: 'Columns: ' + tableForm.tableColumns
            textSize: Label.Small
        }
        Button {
            width: parent.width
            text: 'Add column'
            color: UbuntuColors.graphite
            onClicked: {
                ++tableForm.tableColumns
            }
        }
        Rectangle {
            width: parent.width
            height: units.gu(5)
        }
        Row {
            width: parent.width
            Button {
                width: parent.width / 2
                text: 'Create table'
                color: UbuntuColors.green
                enabled: tableName.length > 0 ? true : false
                onClicked: {
                    tableModel.insert(0, { "name": tableName.text, "columns": tableForm.tableColumns, "rows": 0 })
                    pageStack.pop()
                }
            }
            Button {
                width: parent.width / 2
                text: 'Cancel'
                color: UbuntuColors.red
                onClicked: {
                    pageStack.pop()
                }
            }
        }
    }
}
