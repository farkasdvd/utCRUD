import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'utcrud.hsl'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('utCRUD')

            trailingActionBar {
                actions: [
                    Action {
                        iconName: "add"
                        onTriggered: {
                            tableList.model.insert(0, { "name": "Books", "columns": 4, "rows": 10 })
                        }
                    }
                ]
            }
        }

        ListView {
            id: tableList
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            model:
                ListModel {}
            delegate:
                ListItem {
                    height: tableItem.height + divider.height
                    ListItemLayout {
                        id: tableItem
                        title.text: name
                        title.textSize: Label.Large
                        subtitle.text: columns + " columns"
                        summary.text: rows + " rows"
                    }
                }
        }
    }
}
