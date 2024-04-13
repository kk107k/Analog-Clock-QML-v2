
import QtQuick 2.15

Item {
    id: root

    property int hours
    property int minutes
    property int seconds
    property bool hourPaused: false
    property bool minutePaused: false

    Rectangle {
        id: clockFace
        width: 500
        height: 500
        color: "white"
        border.color: "black"
        border.width: 30
        radius: width / 2
        anchors.centerIn: parent

        // Hour Markers
        Repeater {
            model: 12 // One for each hour
            delegate: Rectangle {
                width: 4
                height: 16
                color: "black"
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: clockFace.horizontalCenter
                transform: Rotation {
                    origin.y: clockFace.radius - 30
                    origin.x: width / 2
                    angle: index * 30 // 360 / 12 = 30 degrees per hour
                }
            }
        }

        // Minute Markers
        Repeater {
            model: 60 // One for each minute
            delegate: Rectangle {
                width: 2  // Thinner than hour markers
                height: 12  // Shorter than hour markers
                color: "black"
                visible: (index % 5 !== 0) // Hide every 5th line to not overlap with hour markers
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                transform: Rotation {
                    origin.y: clockFace.radius - 30
                    origin.x: width / 2
                    angle: index * 6 // 360 / 60 = 6 degrees per minute
                }
            }
        }

        // Hour Text
        Repeater {
            model: 12 // One for each hour
            delegate: Text {
                text: index === 0 ? "12" : index.toString()
                font.pixelSize: 50
                color: "black"
                // Calculate the position for each number
                x: clockFace.radius + Math.cos((index - 3) * Math.PI / 6) * (clockFace.radius - 70) - width / 2
                y: clockFace.radius + Math.sin((index - 3) * Math.PI / 6) * (clockFace.radius - 70) - height / 2
            }
        }

        // Minute Text
        Repeater {
            model: 60 // One for each minute
            delegate: Text {
                text: index === 0 ? "00" : (index < 5 ? "0" + index.toString() : index.toString())
                font.pixelSize: 15
                visible: (index % 5 == 0)
                color: "white"
                // Calculate the position for each minute marker
                x: clockFace.radius + Math.cos((index - 15) * Math.PI / 30) * (clockFace.radius - 15) - width / 2
                y: clockFace.radius + Math.sin((index - 15) * Math.PI / 30) * (clockFace.radius - 15) - height / 2
            }
        }



        // Hour hand
        Rectangle {
            id: hourHand
            width: 15
            height: clockFace.height / 4
            color: "black"
            anchors.bottom: clockFace.verticalCenter
            anchors.horizontalCenter: clockFace.horizontalCenter
            transformOrigin: Item.Bottom

            Rectangle {
                width: 80
                height: 88
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                anchors.bottomMargin: 11
                radius: width / 2

                Repeater {
                    model: 30 // Adjust the number of dashes
                    Rectangle {
                        width: 2 // Adjust the width of each dash
                        height: 6 // Adjust the height of each dash
                        color: "grey" // Adjust the color of the dashes
                        opacity: 0.5
                        x: parent.width / 2 + (parent.width / 2 - width) * Math.cos(index * 15 * Math.PI / 180)
                        y: parent.height / 2 + (parent.height / 2 - height) * Math.sin(index * 15 * Math.PI / 180)
                        transformOrigin: Item.TopLeft
                        rotation: index * 15 // Adjust the rotation angle
                    }
                }

                // Dashed line coming down the middle
                Repeater {
                    model: 10 // Adjust the number of dashes
                    Rectangle {
                        width: 2 // Adjust the width of each dash
                        height: 6 // Adjust the height of each dash
                        color: "grey" // Adjust the color of the dashes
                        opacity: 0.5
                        x: parent.width / 2 - width / 2
                        y: height * index * 1.7 // Spacing between dashes
                        transformOrigin: Item.TopLeft
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    property real hourCoordinateX: 0
                    property real initialRotation: 0

                    onPressed: {
                        hourCoordinateX = mouseX
                        initialRotation = hourHand.rotation
                        hourPaused = true
                    }

                    onReleased: {
                        hourPaused = false
                    }

                    onPositionChanged: {
                        if (!hourPaused) return;
                        let deltaX = mouseX - hourCoordinateX;
                        if (deltaX !== 0) {
                            hourHand.rotation = initialRotation + deltaX / 4; // Adjust the divisor to control the rotation sensitivity
                            minuteHand.rotation = hourHand.rotation * 12; // Update minute hand rotation based on hour hand rotation
                            updateClockTime();
                        }
                    }
                }
            }
        }

        // Minute hand
        Rectangle {
            id: minuteHand
            width: 15
            height: clockFace.height / 2.4 - 4
            color: "black"
            anchors.bottom: clockFace.verticalCenter
            anchors.horizontalCenter: clockFace.horizontalCenter
            transformOrigin: Item.Bottom

            Rectangle {
                width: 80
                height: 88
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                anchors.bottomMargin: -70
                radius: width / 2

                Repeater {
                    model: 30 // Adjust the number of dashes
                    Rectangle {
                        width: 2 // Adjust the width of each dash
                        height: 6 // Adjust the height of each dash
                        color: "grey" // Adjust the color of the dashes
                        opacity: 0.5
                        x: parent.width / 2 + (parent.width / 2 - width) * Math.cos(index * 15 * Math.PI / 180)
                        y: parent.height / 2 + (parent.height / 2 - height) * Math.sin(index * 15 * Math.PI / 180)
                        transformOrigin: Item.TopLeft
                        rotation: index * 15 // Adjust the rotation angle
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    property real minuteCoordinateX: 0
                    property real initialRotation: 0

                    onPressed: {
                        minuteCoordinateX = mouseX
                        initialRotation = minuteHand.rotation
                        minutePaused = true
                    }

                    onReleased: {
                        minutePaused = false
                    }

                    onPositionChanged: {
                        if (!minutePaused) return;
                        let deltaX = mouseX - minuteCoordinateX;
                        if (deltaX !== 0) {
                            minuteHand.rotation = (initialRotation + deltaX / 4); // Adjust the divisor to control the rotation sensitivity
                            if (minuteHand.rotation < 0) minuteHand.rotation += 360; // Ensure rotation is positive
                            var newMinutes = Math.floor(minuteHand.rotation / 6); // 360 / 60 = 6 degrees per minute
                            hourHand.rotation = minuteHand.rotation / 12; // Update hour hand rotation based on minute hand rotation
                            updateClockTime();
                        }
                    }

                }
            }
        }

        // Second hand
        Rectangle {
            id: secondHand
            width: 2
            height: clockFace.height / 2.5
            color: "red"
            anchors.bottom: clockFace.verticalCenter
            anchors.horizontalCenter: clockFace.horizontalCenter
            transformOrigin: Item.Bottom
        }

        // Digital Time Display
        Item {
            width: digitalTime.width + 20 // Adjust width and height as needed
            height: digitalTime.height
            anchors {
                top: parent.top
                topMargin: 150
                horizontalCenter: clockFace.horizontalCenter
            }

            Rectangle {
                color: "white"
                opacity: 0.5
                width: parent.width
                height: parent.height
            }

            Text {
                id: digitalTime
                text: {
                    return (hours < 10 ? "0" + hours : hours) + ":" +
                           (minutes < 10 ? "0" + minutes : minutes);
                }
                font.pixelSize: 40
                color: "black"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }
        }



    }

    function updateClockTime() {
        // Calculate hours and minutes based on the rotation of hour and minute hands
        hours = Math.floor(hourHand.rotation / 30); // 360 / 12 = 30 degrees per hour
        minutes = Math.floor(minuteHand.rotation / 6); // 360 / 60 = 6 degrees per minute

        // Reset minutes if they exceed 59
        minutes = minutes % 60;
    }

    Timer {
        interval: 1000 // Milliseconds
        running: true
        repeat: true
        onTriggered: {
            if (!hourPaused && !minutePaused) {
                // Update time
                seconds++;
                if (seconds >= 60) {
                    seconds = 0;
                    minutes++;
                    if (minutes >= 60) {
                        minutes = 0;
                        hours++;
                        if (hours >= 24) {
                            hours = 0;
                        }
                    }
                }

                // Calculate rotations
                var secondRotation = seconds * 6; // 360 / 60
                var minuteRotation = (minutes + seconds / 60) * 6; // 360 / 60
                var hourRotation = (hours % 12 + minutes / 60) * 30; // 360 / 12

                // Apply rotations to clock hands
                secondHand.rotation = secondRotation;
                minuteHand.rotation = minuteRotation;
                hourHand.rotation = hourRotation;

                // Update digital time display
                digitalTime.text = (hours < 10 ? "0" + hours : hours) + ":" +
                                   (minutes < 10 ? "0" + minutes : minutes);
            }
        }
    }
}
