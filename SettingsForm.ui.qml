import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    width: 400
    height: 100
    Layout.minimumWidth: 400
    Layout.minimumHeight: 100

    GridLayout {
        width: 400
        height: 100
        Layout.minimumWidth: 400
        Layout.minimumHeight: 100

        id: gridLayout1
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent
        columns: 2

        Label {
            id: label1
            text: qsTr("Redmine Connection URL")
        }

        TextField {
            id: url
            Layout.fillWidth: true
            objectName: "url"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 150
            placeholderText: qsTr("URL")
        }

        Label {
            id: label2
            text: qsTr("Redmine API Key")
        }

        TextField {
            id: apikey
            Layout.fillWidth: true
            objectName: "apikey"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 150
            placeholderText: qsTr("Key")
        }

        Label {
            id: label3
            text: qsTr("Worked on issue status")
        }

        ComboBox {
            id: workedOn
            Layout.fillWidth: true
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 150
            objectName: "workedOn"
            model: issueStatusModel
            textRole: "name"
        }

        ToolButton {
            id: apply
            objectName: "apply"
            text: qsTr("A&pply")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            isDefault: true
        }

        ToolButton {
            id: cancel
            objectName: "cancel"
            text: qsTr("&Cancel")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
    }
}

