import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItems
import Ubuntu.Components.Popups 1.3

Page {
    id: tableRowPage

    property int tableIndex: -1
    property int rowIndex: -1

    anchors.fill: parent

    function isNewRowMode() {
        return tableRowPage.rowIndex == -1
    }

    function getPageTitle() {
        var title = tableModel.get(tableRowPage.tableIndex).name

        if(isNewRowMode()) {
            title += ' (new row)'
        }
        else {
            title += ' (row ' + (tableRowPage.rowIndex + 1) + ')'
        }

        return title
    }

    function getCellValue(index) {
        if(isNewRowMode()) {
            return ''
        }
        return tableModel.get(tableRowPage.tableIndex).rows.get(tableRowPage.rowIndex).row.get(index).value
    }

    header: PageHeader {
        id: tableRowPageHeader

        title: tableRowPage.getPageTitle()

        trailingActionBar.actions: [
            Action {
                iconName: 'save'
                onTriggered: {
                    var children = rowCells.children
                    var row = []

                    for(var i = 0; i < children.length; ++i) {
                        if(children[i].children.length == 2) {
                            var cell = children[i].children[1]
                            row.push({'value': cell.text})
                        }
                    }

                    if(isNewRowMode()) {
                        tableModel.get(tableRowPage.tableIndex).rows.append({'row': row})
                    }
                    else {
                        tableModel.get(tableRowPage.tableIndex).rows.remove(tableRowPage.rowIndex)
                        tableModel.get(tableRowPage.tableIndex).rows.insert(tableRowPage.rowIndex, {'row': row})
                    }

                    pageStack.pop()
                }
            },
            Action {
                iconName: 'delete'
                visible: !isNewRowMode()
                onTriggered: {
                    PopupUtils.open(Qt.resolvedUrl('DeleteConfirmationDialog.qml'),
                                    tableRowPage,
                                    {
                                        targetType: 'row',
                                        targetName: '#' + (tableRowPage.rowIndex + 1),
                                        targetModel: tableModel.get(tableRowPage.tableIndex).rows,
                                        targetIndex: tableRowPage.rowIndex,
                                        popStack: true
                                    })
                }
            }
        ]
    }

    Flickable {
        id: tableRowPageBody

        anchors {
            top: tableRowPageHeader.bottom
            left: tableRowPage.left
            right: tableRowPage.right
            bottom: tableRowPage.bottom
        }

        contentWidth: width
        contentHeight: rowCells.height
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Column {
            id: rowCells

            Repeater {
                model: tableModel.get(tableRowPage.tableIndex).header.count

                Column {
                    ListItems.Standard {
                        width: tableRowPageBody.width
                        showDivider: false
                        text: tableModel.get(tableRowPage.tableIndex).header.get(index).value
                    }
                    InputField {
                        text: getCellValue(index)
                    }
                }
            }

            ListItems.Empty {
                showDivider: false
            }
        }
    }
}
