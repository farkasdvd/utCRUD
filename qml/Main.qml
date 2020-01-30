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
                            body.model += 1
                        }
                    }
                ]
            }
        }
        ListView {
            id: body
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            model: 0
            delegate:
                ListItem {
                    Label {
                        anchors.fill: parent
                        text: "Table #" + modelData

                        verticalAlignment: Label.AlignVCenter
                        horizontalAlignment: Label.AlignHCenter
                    }
                }
        }
    }
}
