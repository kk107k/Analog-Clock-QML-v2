import QtQuick 2.15

Item {
    id: root

    property int hours
    property int minutes
    property int seconds
    property bool hourPaused: false
    property bool minutePaused: false
    property bool isDigitalTimeVisible: true
    property bool isHourHandVisible: true
    property bool isMinuteHandVisible: true
    property string markerColor: "black"
    property bool use24HourFormat: true // Default to 24-hour format


    Buttons {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70
        // Connect the signal to the function that toggles dash lines
        onToggleDashLines: {
            hourHand.dashLinesVisible = on
            minuteHand.dashLinesVisible = on
        }

        // Set the text label for the hour hand button
        Text {
            text: "Dash Lines"
            color: "black"
            font.family: "sans-serif"
            font.pixelSize: 8
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 17
        }
    }


    Buttons {

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 95
        anchors.rightMargin: 45

        // Connect the signal to the function that toggles dash lines
        onToggleDashLines: {
            isDigitalTimeVisible = on
        }

        Text {
                text: "Digital"
                color: "black"
                font.family: "sans-serif"
                font.pixelSize: 8
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 25
            }
    }

    Buttons {
        id: hourHandButton
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalTop
        onToggleHourHand: {
            isHourHandVisible = visible
        }

        Text {
                text: "Hour Hand"
                color: "black"
                font.family: "sans-serif"
                font.pixelSize: 8
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.top: parent.top
                anchors.topMargin: 17
            }
    }

    Buttons {
            id: minuteHandButton
            anchors.right: parent.right // Position the button to the right
            anchors.verticalCenter: parent.verticalTop // Center vertically
            anchors.rightMargin: 45

            onToggleHourHand: {
                isMinuteHandVisible = visible
            }

            Text {
                    text: "Minute Hand"
                    color: "black"
                    font.family: "sans-serif"
                    font.pixelSize: 8
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 17
                }
        }

    // Function to switch to 12-hour format
    function switchTo12HourFormat() {
        use24HourFormat = false;
        updateDigitalTime(); // Call updateDigitalTime to apply format changes
    }

    // Function to switch to 24-hour format
    function switchTo24HourFormat() {
        use24HourFormat = true;
        updateDigitalTime(); // Call updateDigitalTime to apply format changes
    }

    Row {
        anchors {
            bottom: parent.bottom
            right: parent.right
        }


        spacing: 5

        Rectangle {
            id: normalTime
            width: 45
            height: 45
            radius: 10
            border.color: "black"
            border.width: 3

            Text {
                text: "12"
                color: "black"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "sans-serif"
                font.pixelSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    switchTo12HourFormat()
                }
            }
        }

        Rectangle {
            id: militaryTime
            width: 45
            height: 45
            radius: 10
            border.color: "black"
            border.width: 3

            Text {
                text: "24"
                color: "black"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "sans-serif"
                font.pixelSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    switchTo24HourFormat()
                }
            }
        }
    }

    Row {
        anchors {
            bottom: parent.bottom
            left: parent.left
        }


        spacing: 5

        Rectangle {
            id: blackButton
            width: 20
            height: 20
            radius: 10
            color: "black"
            border.color: "black"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    clockFace.border.color = "black"
                    minuteHand.color = "black"
                    markerColor = "black"
                }
            }
        }

        Rectangle {
            id: blueButton
            width: 20
            height: 20
            radius: 10
            color: "#1976D2"
            border.color: "#1976D2"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    clockFace.border.color = "#1976D2"
                    minuteHand.color = "#1976D2"
                    markerColor = "#1976D2"
                }
            }
        }

        Rectangle {
            id: orangeButton
            width: 20
            height: 20
            radius: 10
            color: "#FF5722"
            border.color: "#FF5722"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    clockFace.border.color = "#FF5722"
                    minuteHand.color = "#FF5722"
                    markerColor = "#FF5722"
                }
            }
        }

        Rectangle {
            id: greenButton
            width: 20
            height: 20
            radius: 10
            color: "#388E3C"
            border.color: "#388E3C"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    clockFace.border.color = "#388E3C"
                    minuteHand.color = "#388E3C"
                    markerColor = "#388E3C"
                }
            }
        }
    }

    // Update digital time display based on clock format
    function updateDigitalTime() {
        if (use24HourFormat) {
            digitalTime.text = formatHours(hours) + ":" + (minutes < 10 ? "0" + minutes : minutes);
        } else {
            digitalTime.text = formatHours(hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) + " " + getAMPM();
        }
    }

    // Function to format hours based on the clock format
    function formatHours(hour) {
        if (use24HourFormat) {
            return hour < 10 ? "0" + hour : hour;
        } else {
            if (hour === 0) {
                return "12";
            } else if (hour <= 12) {
                return hour;
            } else {
                return hour - 12;
            }
        }
    }

    // Function to determine AM/PM for 12-hour format
    function getAMPM() {
        return hours < 12 ? "AM" : "PM";
    }


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
                color: markerColor
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
                color: markerColor
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
            visible: isHourHandVisible
            property bool dashLinesVisible: true


            // Dash lines for the Hour hand
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
                        visible: parent.parent.dashLinesVisible
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
                        visible: parent.parent.dashLinesVisible
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
                            hourHand.rotation = initialRotation + deltaX / 4;

                            // Calculate minute hand rotation based on minute component
                            let currentHour = Math.floor(hourHand.rotation / 30);
                            let currentMinute = (hourHand.rotation % 30) * 2;
                            minuteHand.rotation = currentMinute * 6; // 360 / 60

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
            visible: isMinuteHandVisible
            property bool dashLinesVisible: true


            // Dash lines for the minute hand
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
                        visible: parent.parent.dashLinesVisible
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
                            let newRotation = initialRotation + deltaX / 4;
                            // Ensure rotation is within [0, 360) range
                            minuteHand.rotation = newRotation >= 0 ? newRotation % 360 : 360 - (-newRotation % 360);
                            print(hourHand.rotation)
                            hourHand.rotation = minuteHand.rotation / 12;
                            print(hourHand.rotation)
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
            visible: isDigitalTimeVisible
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
                visible: parent.visible
            }

            Text {
                id: digitalTime
                visible: parent.visible
                text: {
                    return (hours == 0 ? "12" : hours) + ":" +
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
           hours = hourHand.rotation / 30; // 360 / 12 = 30 degrees per hour
           minutes = minuteHand.rotation / 6; // 360 / 60 = 6 degrees per minute

           // Reset minutes if they exceed 59
           minutes = minutes % 60;

           // Update digital time display
           updateDigitalTime();
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
                var minuteRotation = ((minutes * 6) + (seconds / 10)) + ((hours % 12) * 30 / 60); // Minute hand: (360 / 60) + (360 / 60 / 10) + (360 / 12 / 60)
                var hourRotation = ((hours % 12) * 30) + ((minutes / 2) + (seconds / 120)); // Hour hand: (360 / 12) + (360 / 60 / 2) + (360 / 60 / 120)


                // Apply rotations to clock hands
                secondHand.rotation = secondRotation;
                minuteHand.rotation = minuteRotation;
                hourHand.rotation = hourRotation;

                // Update digital time display
                updateDigitalTime();
            }    // Call the function to test hour hand synchronization
        }
    }

}
