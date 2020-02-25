import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    id: readPage
    anchors.fill: parent
        
    property int tableIndex: -1

    header: PageHeader {
        id: header
        title: tableModel.get(tableIndex).name

        trailingActionBar.actions: [
            Action {
                iconName: 'filters'
            }
        ]
    }
}
