import QtQuick 2.4
import Ubuntu.Components 1.3

Column {
    id: tableCellRoot

    width: parent.width
    height: parent.height

    property string content: ''
    property bool bold: false

    Row {
        Label {
            id: tableCellContent

            width: tableCellRoot.width - vTableCellDivider.width
            height: tableCellRoot.height - hTableCellDivider.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            clip: true
            font.bold: tableCellRoot.bold

            text: tableCellRoot.content
        }
        Rectangle {
            id: vTableCellDivider

            width: tableCellRoot.bold ? units.gu(0.2) : units.gu(0.1)
            height: tableCellContent.height
            color: UbuntuColors.silk
        }
    }
    Rectangle {
        id: hTableCellDivider

        width: tableCellRoot.width
        height: tableCellRoot.bold ? units.gu(0.2) : units.gu(0.1)
        color: UbuntuColors.silk
    }
}
