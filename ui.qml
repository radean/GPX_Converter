import QtQuick 2.12
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.2

ApplicationWindow {
    id: mainWindowAbout
    title: qsTr("About")
    visible: false
    height: 120
    color: "#474747"
    width: 280

    Grid {
        id: grid
        width: 280
        height: 120
        columns: 3
        rows: 4



        Text {
            id: tx_About
            x: 0
            y: 20
            width: 280
            color: "#ffffff"
            text: qsTr("About ")
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Bold
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            Layout.columnSpan: 3
        }

        Text {
            id: tx_About_Description
            y: 40
            width: 280
            color: "#ffffff"
            text: qsTr("Whoosh, GFX, All Rights Reserved, 2020")
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            Layout.columnSpan: 3
        }



        Text {
            id: tx_About_footmark
            y: 60
            width: 280
            color: "#ffffff"
            text: qsTr("clone")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 8
            Layout.columnSpan: 3

        }

        Button {
            id: closeButton
            x: 100
            y: 80
            text: qsTr("Close")
            scale: 0.7
            width: 80

            Connections {
                target: closeButton

                function onClicked() {

                    grabler.closeAbout("Grab")

                    mainWindowAbout.visible = false
                    //print (enlargeButton())
                }
            }
        }

    }

    Connections {
        target: grabler

        function onEnlargeButton(inst) {
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
    D{i:0;formeditorZoom:1.5}D{i:3;anchors_y:40}D{i:5;anchors_x:8;anchors_y:60}
}
##^##*/
