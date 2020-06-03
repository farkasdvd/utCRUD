import QtQuick 2.4
import Ubuntu.Components 1.3

TextField {
    anchors {
        left: parent.left
        leftMargin: units.gu(3)
        right: parent.right
        rightMargin: units.gu(3)
    }

    maximumLength: 32
    validator: RegExpValidator {
        regExp: /^[a-zA-Z0-9]+$/
    }
}
