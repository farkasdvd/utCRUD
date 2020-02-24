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
        
        trailingActionBar.actions: [
            Action {
                iconName: 'ok'
                enabled: tableName.length > 0
                onTriggered: {
                    var columns = []
                    for( var i = 0; i < columnModel.count; ++i) {
                        columns.push({'name': columnModel.get(i).name})
                    }
                    tableModel.insert(0, { 'name': tableName.text, 'columns': columns, 'rows': 0 })
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

        TextField {
            id: tableName
            anchors {
                left: parent.left
                leftMargin: units.gu(3)
                right: parent.right
                rightMargin: units.gu(3)
            }
            width: parent.width
            placeholderText: 'Table name'
            maximumLength: 32
            validator: RegExpValidator {
                regExp: /^[a-zA-Z0-9]+$/
            }
        }
        ListItems.ThinDivider {}
        ListItems.Subtitled {
            text: 'Columns'
            subText: 'Count: ' + columnModel.count
            showDivider: false
        }
        TextField {
            id: columnName
            anchors {
                left: parent.left
                leftMargin: units.gu(3)
                right: parent.right
                rightMargin: units.gu(3)
            }
            width: parent.width
            placeholderText: 'Column name'
            maximumLength: 32
            validator: RegExpValidator {
                regExp: /^[a-zA-Z0-9]+$/
            }
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
                columnModel.insert(0, {'name': columnName.text})
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

            property string columnName: name

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
