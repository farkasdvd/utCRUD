import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItems

Page {
    anchors.fill: parent

    header: PageHeader {
        id: header
        title: i18n.tr('Create')
        
        trailingActionBar.actions: [
            Action {
                iconName: 'ok'
                enabled: tableName.length > 0
                onTriggered: {
                    tableModel.insert(0, { "name": tableName.text, "columns": tableForm.tableColumns, "rows": 0 })
                    pageStack.pop()
                }
            }
        ]
    }

    Column {
        id: tableForm
        anchors {
            top: header.bottom
            topMargin: units.gu(2)
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
            maximumLength: 32
            validator: RegExpValidator {
                regExp: /^[a-zA-Z0-9]+$/
            }
        }
        ListItems.Subtitled {
            text: 'Columns'
            subText: 'Count: ' + tableForm.tableColumns
        }
        Button {
            width: parent.width
            text: 'Add column'
            color: UbuntuColors.graphite
            onClicked: {
                ++tableForm.tableColumns
            }
        }
    }
}
