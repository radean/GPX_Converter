import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2

ApplicationWindow {
    id: mainWindowAlert
    title: qsTr("Alert")
    visible: false
    height: 120
    color: "#474747"
    width: 220

   Flow {
       id: flowGrid
       x: 0
       y: 0
       width: 220
       height: 120
       visible: true

       Text {
           id: tx_Alert
           color: "#ffffff"
           text: qsTr("Notification")
           anchors.top: parent.top
           anchors.topMargin: 10
           anchors.left: parent.horizontalCenter
           anchors.leftMargin: -35
           font.weight: Font.Bold
           horizontalAlignment: Text.AlignLeft
           font.pixelSize: 12
       }

       Text {
           id: tx_Alert_Description
           width: 180
           color: "#ffffff"
           text: qsTr("General Issue")
           textFormat: Text.PlainText
           renderType: Text.QtRendering
           clip: false
           elide: Text.ElideMiddle
           wrapMode: Text.NoWrap
           verticalAlignment: Text.AlignVCenter
           horizontalAlignment: Text.AlignHCenter
           anchors.left: parent.horizontalCenter
           anchors.leftMargin: -90
           anchors.top: parent.top
           anchors.topMargin: 40
           font.pixelSize: 12

       }

       Button {
           id: closeButton
           x: 0
           text: qsTr("Done")
           highlighted: true
           width: 80
           anchors.top: parent.top
           anchors.topMargin: 70
           anchors.left: parent.horizontalCenter
           anchors.leftMargin: -40
           //objectName: "closeButton"

           Connections {
               target: closeButton

               onClicked: {

                   mainWindowAlert.visible = false
                   //print (enlargeButton())
               }
           }
       }
   }
   // Setting the error Message
       Connections {
           target: grabler

           onErrorBroadcast: {
               if (mainWindowAlert.visible) {
                    mainWindowAlert.visible = false

                    // Changing the Text to footmark
                    tx_Alert_Description.text = error
                } else {
                    mainWindowAlert.visible = true

                    // Changing the Text to footmark
                    tx_Alert_Description.text = error
                }
           }
       }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}
}
##^##*/
