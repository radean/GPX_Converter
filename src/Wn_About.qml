import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2

Page {

    title: qsTr("About")
    visible: true
    height: 120
    layer.enabled: false
    enabled: true
    width: 220
    objectName: "AboutWindow"

   Flow {
       id: flowGrid
       width: 400
       height: 400

       Text {
           id: tx_About
           color: "#ffffff"
           text: qsTr("About ")
           anchors.top: parent.top
           anchors.topMargin: 10
           anchors.left: parent.left
           anchors.leftMargin: 90
           font.weight: Font.Bold
           horizontalAlignment: Text.AlignLeft
           font.pixelSize: 12
       }

       Text {
           id: tx_About_Description
           color: "#ffffff"
           text: qsTr("Whoosh, All Rights Reserved, 2020")
           anchors.left: parent.left
           anchors.leftMargin: 16
           anchors.top: parent.top
           anchors.topMargin: 40
           font.pixelSize: 12

       }

       Button {
           id: closeButton
           x: 0
           text: qsTr("Close")
           width: 30
           anchors.top: parent.top
           anchors.topMargin: 70
           anchors.left: parent.left
           anchors.leftMargin: 60
           //objectName: "closeButton"

           Connections {
               target: closeButton

               onClicked: {
                   grabler.closeAbout()
                   //print (enlargeButton())
               }
           }
       }
   }
}
