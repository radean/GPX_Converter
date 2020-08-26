import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2

ApplicationWindow {
    id: mainWindowAbout
    title: qsTr("About")
    visible: false
    height: 120
    color: "#474747"
    width: 280

    Flow {
        id: element
        width: 280
        height: 120


        Text {
            id: tx_About
            width: 280
            color: "#ffffff"
            text: qsTr("About ")
            topPadding: 10
            bottomPadding: 10
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Bold
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            Layout.columnSpan: 3
        }


        Text {
            id: tx_About_Description
            width: 280
            color: "#ffffff"
            text: qsTr("Whoosh, GFX, All Rights Reserved, 2020")
            anchors.top: parent.top
            anchors.topMargin: 34
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            Layout.columnSpan: 3
        }



        Text {
            id: tx_About_footmark
            width: 280
            color: "#ffffff"
            text: qsTr("clone")
            anchors.top: parent.top
            anchors.topMargin: 48
            topPadding: 10
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 8
            Layout.columnSpan: 3

        }

        Button {
            id: closeButton
            text: qsTr("Close")
            anchors.top: parent.top
            anchors.topMargin: 74
            anchors.left: parent.left
            anchors.leftMargin: 100
            topPadding: 0
            rightPadding: 0
            leftPadding: 0
            padding: 0
            highlighted: true
            autoRepeat: false
            flat: false
            scale: 0.7
            width: 80

            Connections {
                target: closeButton

                onClicked: {

                    grabler.closeAbout("Grab")

                    mainWindowAbout.visible = false
                    //print (enlargeButton())
                }
            }
        }

    }

    Connections {
        target: grabler

        onEnlargeButton: {
            if (mainWindowAbout.visible) {
                mainWindowAbout.visible = false

                // Changing the Text to footmark
                tx_About_footmark.text = inst
            } else {
                mainWindowAbout.visible = true

                // Changing the Text to footmark
                tx_About_footmark.text = inst
            }
        }
    }






}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}D{i:5;anchors_y:0}
}
##^##*/
