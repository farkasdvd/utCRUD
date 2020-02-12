import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Dialog {
    id: deleteConfirmationDialog

    property string targetType
    property string targetName
    property var targetModel
    property int targetIndex

    title: 'Delete'
    text: 'Are you sure you want to delete ' + targetType + ' <b>' + targetName + '</b>?'

    Button {
        text: 'Delete'
        color: UbuntuColors.red
        onClicked: {
            targetModel.remove(targetIndex)
            PopupUtils.close(deleteConfirmationDialog)
        }
    }
    Button {
        text: 'Cancel'
        color: UbuntuColors.green
        onClicked: {
            PopupUtils.close(deleteConfirmationDialog)
        }
    }
}
