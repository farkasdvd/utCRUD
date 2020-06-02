import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItems

Page {
    id: tableRowPage

    property int tableIndex: -1
    property int rowIndex: -1

    anchors.fill: parent

    function getPageTitle() {
        var title = tableModel.get(tableRowPage.tableIndex).name

        if(tableRowPage.rowIndex == -1) {
            title += ' (new row)'
        }
        else {
            title += ' (row ' + (tableRowPage.rowIndex + 1) + ')'
        }

        return title
    }

    function getCellValue(index) {
        if(tableRowPage.rowIndex == -1) {
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

                    if(tableRowPage.rowIndex == -1) {
                        tableModel.get(tableRowPage.tableIndex).rows.append({'row': row})
                    }
                    else {
                        tableModel.get(tableRowPage.tableIndex).rows.set(tableRowPage.rowIndex, {'row': row})
                    }

                    pageStack.pop()
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
                    TextField {
                        anchors {
                            left: parent.left
                            leftMargin: units.gu(3)
                            right: parent.right
                            rightMargin: units.gu(3)
                        }

                        text: getCellValue(index+1)
                    }
                }
            }

            ListItems.Empty {
                showDivider: false
            }
        }
    }
}
