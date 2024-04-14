// Buttons.qml
import QtQuick 2.15

Item {
    signal toggleDashLines(bool on)
    signal toggleHourHand(bool visible)
    signal toggleMinuteHand(bool visible)

    Row {
        spacing: 10 // Adjust the space between the button and the text label as needed

        Rectangle {
            id: toggleButton
            width: 45
            height: 45
            radius: 10
            border.color: "black"
            border.width: 3

            // Use a property to manage the button state
            property bool isOn: true


            Text {
                text: toggleButton.isOn ? "ON" : "OFF"
                color: "black"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "sans-serif"
                font.pixelSize: 20
            }

            // Mouse area to detect clicks and toggle the state
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    toggleButton.isOn = !toggleButton.isOn
                    toggleDashLines(toggleButton.isOn)
                    toggleHourHand(toggleButton.isOn)
                    toggleMinuteHand(toggleButton.isOn)
                }
            }

        }
    }
}


