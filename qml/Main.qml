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

    PageStack {
        id: pageStack

        Component.onCompleted: {
            pageStack.push(homePage)
        }
    }

    ListModel {
        id: tableModel
    }

    Page {
        id: homePage
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('utCRUD')

            trailingActionBar {
                actions: [
                    Action {
                        iconName: 'add'
                        onTriggered: {
                            pageStack.push(Qt.resolvedUrl('CreatePage.qml'))
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
            model: tableModel
            delegate:
                ListItem {
                    height: tableItem.height + divider.height
                    ListItemLayout {
                        id: tableItem
                        title.text: name
                        title.textSize: Label.Large
                        subtitle.text: columns + ' columns'
                        summary.text: rows + ' rows'
                    }
                }
        }
    }
}
