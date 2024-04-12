import QtQuick 2.15

Item {
    property alias rotation: hand.rotation

    Rectangle {
        id: hand
        color: "black"
        width: 4
        height: parent.height * 0.45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.2
        transformOrigin: Item.Bottom
    }
}
