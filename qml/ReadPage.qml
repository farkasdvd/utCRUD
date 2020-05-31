import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    id: readPage

    property int tableIndex: -1
    property int cellWidth: {
        var justifiedCellWidth = tableContent.width / tableModel.get(tableIndex).header.count
        if(justifiedCellWidth < rowIndexCellWidth) {
            return rowIndexCellWidth
        }
        return justifiedCellWidth
    }
    property int rowIndexCellWidth: 60
    property int cellHeight: 50

    anchors.fill: parent

    header: PageHeader {
        id: readPageHeader

        title: tableModel.get(tableIndex).name

        trailingActionBar.actions: [
            Action {
                iconName: 'filters'
            }
        ]
    }

    Rectangle {
        id: tableHeader

        anchors {
            top: readPageHeader.bottom
            left: readPage.left
        }

        width: readPage.width
        height: readPage.cellHeight

        Row {
            TableCell {
                width: readPage.rowIndexCellWidth
                height: tableHeader.height
                bold: true
                content: '#'
            }
            Rectangle {
                width: readPage.width - readPage.rowIndexCellWidth
                height: tableHeader.height
                clip: true

                Row {
                    x: -tableContent.contentX

                    Repeater {
                        model: tableModel.get(tableIndex).header

                        TableCell {
                            width: readPage.cellWidth
                            height: tableHeader.height
                            bold: true
                            content: value
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        anchors {
            top: tableHeader.bottom
            left: readPage.left
        }

        width: readPage.width
        height: readPage.height - tableHeader.height

        Row {
            Rectangle {
                width: readPage.rowIndexCellWidth
                height: readPage.height - tableHeader.height
                clip: true

                Column {
                    id: c1

                    y: -tableContent.contentY

                    Repeater {
                        model: tableModel.get(tableIndex).rows.count

                        TableCell {
                            width: readPage.rowIndexCellWidth
                            height: readPage.cellHeight
                            bold: true
                            content: index + 1
                        }
                    }
                }
            }
            Flickable {
                id: tableContent

                width: readPage.width - c1.width
                height: readPage.height - tableHeader.height
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                contentWidth: tableBody.width
                contentHeight: tableBody.height

                Column {
                    id: tableBody

                    Repeater {
                        model: tableModel.get(tableIndex).rows

                        Row {
                            id: tableRow

                            property int rowIndex: index

                            Repeater {
                                model: modelData

                                TableCell {
                                    width: readPage.cellWidth
                                    height: readPage.cellHeight
                                    content: value
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
