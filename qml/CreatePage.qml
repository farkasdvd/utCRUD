import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItems
import Ubuntu.Components.Popups 1.3

Page {
    id: createPage

    anchors.fill: parent

    header: PageHeader {
        id: header

        title: i18n.tr('Create')

        function addTableToModel() {
            var columns = []
            for( var i = (columnModel.count - 1); i >= 0; --i) {
                columns.push({'value': columnModel.get(i).value})
            }
            tableModel.insert(0, { 'name': tableName.text, 'header': columns, 'rows': [] })
        }

        function isTableReady() {
            return (tableName.length > 0) && (columnModel.count > 0)
        }

        trailingActionBar.actions: [
            Action {
                iconName: 'add'
                enabled: header.isTableReady()
                onTriggered: {
                    header.addTableToModel()
                    tableName.text = ''
                    columnName.text = ''
                    columnModel.clear()
                    header.title = header.title + ' another'
                }
            },
            Action {
                iconName: 'ok'
                enabled: header.isTableReady()
                onTriggered: {
                    header.addTableToModel()
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
            right: parent.right
        }

        spacing: units.gu(1)

        InputField {
            id: tableName

            placeholderText: 'Table name'
        }
        ListItems.ThinDivider {}
        ListItems.Subtitled {
            text: 'Columns'
            subText: 'Count: ' + columnModel.count
            showDivider: false
        }
        InputField {
            id: columnName

            placeholderText: 'Column name'
        }
        Button {
            anchors {
                left: parent.left
                leftMargin: units.gu(3)
                right: parent.right
                rightMargin: units.gu(3)
            }

            width: parent.width
            text: 'Add column'
            color: UbuntuColors.graphite
            enabled: columnName.length > 0
            onClicked: {
                columnModel.insert(0, {'value': columnName.text})
                columnName.text = ''
            }
        }
    }
    ListView {
        anchors {
            top: tableForm.bottom
            topMargin: units.gu(1)
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        clip: true
        model: ListModel {
            id: columnModel
        }
        delegate: ListItem {
            id: columnItem

            property string columnName: value

            ListItemLayout {
                title.text: columnName
            }
            leadingActions: ListItemActions {
                actions: [
                    Action {
                        iconName: 'delete'
                        onTriggered: {
                            PopupUtils.open(Qt.resolvedUrl('DeleteConfirmationDialog.qml'), createPage, {targetType: 'column', targetName: columnItem.columnName, targetModel: columnModel, targetIndex: index})
                        }
                    }
                ]
            }
        }
    }
}
