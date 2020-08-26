import QtQuick 2.15
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3



ApplicationWindow {
    id: mainWindow
    title: qsTr("GPXConverter 1.1")
    visible: true
    height: 442
    color: "#222222"
    width: 340
    objectName: "MainWindow"
    

    Row {
        id: sectionInfo
        x: 0
        width: 340
        height: 160
        anchors.top: parent.top
        anchors.topMargin: 0
        spacing: 7

        Image {
            id: image
            width: 340
            height: 144
            verticalAlignment: Image.AlignVCenter
            smooth: false
            mirror: false
            mipmap: false
            cache: true
            autoTransform: false
            asynchronous: false
            sourceSize.height: 0
            sourceSize.width: 340
            fillMode: Image.PreserveAspectFit
            source: "res/banner.png"
            objectName: "bannerImage"
        }
    }

    Flow {
        id: sectionGpxConfig
        x: 10
        width: 320
        height: 97
        anchors.top: parent.top
        anchors.topMargin: 150
        Text {
            id: infoText_GPX
            color: "#ffffff"
            text: qsTr("GPX Config")
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 10
        }

        Text {
            id: infoText_GPXSection_Location
            color: "#ffffff"
            text: qsTr("GPX Location")
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 30
        }

        TextField {
            id: tf_GPX_saveLocation
            width: 140
            height: 20
            font.pixelSize: 8
            anchors.left: parent.left
            placeholderText: qsTr("GPX Location")
            anchors.leftMargin: 112
            anchors.top: parent.top
            anchors.topMargin: 28
            

            Connections {
                target: tf_GPX_saveLocation
                
                function onClicked() {
                    tf_GPX_saveLocation.text = "Clicked"
                }
            }
        }

        Button {
            id: bt_GPX_Browse
            width: 62
            height: 20
            text: qsTr("Browse")
            anchors.left: parent.left
            anchors.leftMargin: 258
            anchors.top: parent.top
            checkable: false
            transformOrigin: Item.Bottom
            anchors.topMargin: 28

           Connections {
               target: bt_GPX_Browse

               function onClicked() {
                   fileDialogOpener.FileOpener("GPX", "GPX Files (*.gpx )")
               }
           }
        }

        Text {
            id: infoText_GPXSection_Location1
            color: "#ffffff"
            text: qsTr("Invert X Axis")
            lineHeightMode: Text.ProportionalHeight
            maximumLineCount: 1
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 70
        }

        Text {
            id: infoText_GPXSection_Location2
            color: "#ffffff"
            text: qsTr("Scale Factor")
            maximumLineCount: 1
            anchors.left: parent.left
            anchors.leftMargin: 170
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 70

        }


        TextField {
            id: tf_ScaleFactor
            width: 60
            height: 20
            font.pixelSize: 8
            text: qsTr("1.62")
            anchors.left: parent.left
            placeholderText: qsTr("1.62")
            anchors.leftMargin: 260
            anchors.top: parent.top
            anchors.topMargin: 68
        
            Connections {
                target: tf_ScaleFactor


                // For the first time only
                Component.onCompleted: {
                    grabler.setScaleFactor(tf_ScaleFactor.text)
                }

                function onFocusChanged() {
                    // Sending the Var to Methods
                    grabler.setScaleFactor(tf_ScaleFactor.text)
                    //print("Hitted")
                }
            }
        }

        Switch {
            id: swc_InvertedSpline
            width: 68
            height: 40
            anchors.left: parent.left
            anchors.leftMargin: 90
            anchors.top: parent.top
            anchors.topMargin: 58
            checked: true
            clip: true

            Connections {
                target: swc_InvertedSpline

                function onClicked(isInvertedSpline) {
                    if (swc_InvertedSpline.checked == true) {
                        grabler.setIsInvertedSpline(true)
                    } else {
                        grabler.setIsInvertedSpline(false)
                    }
                    print ("Checked", swc_InvertedSpline.checked)
                }
            }
        }

    }

    Flow {
        id: sectionCsvConfig
        x: 10
        width: 320
        height: 60
        anchors.top: parent.top
        anchors.topMargin: 250

        Text {
            id: infoText_CSV
            color: "#ffffff"
            text: qsTr("CSV Config")
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            font.pixelSize: 12
        }

        Text {
            id: infoText_CSVSection_Location
            color: "#ffffff"
            text: qsTr("Output Location")
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 30
        }

        TextField {
            id: tf_csv_saveLocation
            width: 140
            height: 20
            font.pixelSize: 8
            anchors.top: parent.top
            anchors.topMargin: 28
            anchors.left: parent.left
            anchors.leftMargin: 112
            placeholderText: qsTr("CSV Location")

            Connections {
                target: tf_csv_saveLocation

                function onCsvFileCaptured(directory) {
                    tf_csv_saveLocation.text = directory
                }
            }
        }

        Button {
            id: bt_CSV_Browse
            width: 62
            height: 20
            text: qsTr("Browse")
            anchors.left: parent.left
            anchors.leftMargin: 258
            anchors.top: parent.top
            transformOrigin: Item.Bottom
            enabled: false
            checkable: false
            anchors.topMargin: 28

           Connections {
               target: bt_CSV_Browse

               function onClicked() {
                   fileDialogOpener.FileOpener("CSV", "CSV Files (*.csv)")
               }
           }
        }

    }

    Flow {
        id: sectionExecution
        x: 10
        width: 320
        height: 120
        anchors.top: parent.top
        anchors.topMargin: 315



        Text {
            id: infoText1
            width: 320
            color: "#ffffff"
            text: qsTr("Note: Please try to use .gpx files from valid sources e.g. Strava, ridewithgps. Otherwise, the result might be malfunctional.")
            minimumPointSize: 11
            minimumPixelSize: 11
            fontSizeMode: Text.HorizontalFit
            renderType: Text.QtRendering
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignLeft
            maximumLineCount: 4
            elide: Text.ElideNone
            wrapMode: Text.WordWrap
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 10
        }

        Text {
            id: infoText
            color: "#ffffff"
            text: qsTr("Progress")
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            font.bold: true
            anchors.top: parent.top
            anchors.topMargin: 42
            anchors.left: parent.left
            anchors.leftMargin: 130
            font.pixelSize: 12
        }

        ProgressBar {
            id: progressBar
            y: 0
            width: 160
            height: 6
            anchors.left: parent.left
            anchors.leftMargin: 80
            scale: 2
            visible: true
            indeterminate: false
            anchors.top: parent.top
            anchors.topMargin: 64
            clip: false
            value: 0
        }


        Button {
            id: ex_About
            width: 62
            height: 40
            text: "About"
            anchors.left: parent.left
            anchors.leftMargin: 258
            anchors.top: parent.top
            anchors.topMargin: 80
            transformOrigin: Item.Bottom
            checkable: false

            Connections {
                target: ex_About
                
                function onClicked() {
                    grabler.openAbout(footmark, scaleFactor)
                } 
            
           }
            
        }

        Button {
            id: ex_Conversion
            width: 252
            height: 40
            text: textion
            enabled: false
            anchors.top: parent.top
            anchors.topMargin: 80
            checkable: false
            property string textion: "Convension"

           Connections {
               target: ex_Conversion
                
               function onClicked() {
                   // Conversion Slot Mech
                   conversion.submittion();
               }
           }
        }

    }


    Connections {
        target: grabler;

        // on progress bar changes
        function onProgressChange (progress) {
            progressBar.value = progress
        }
    }

    // Emitter File Dialog Opener
    Connections {
        target: fileDialogOpener

        // When EU Select a GPX File
        function onGpxFileCaptured(directory) {
            tf_GPX_saveLocation.text = directory

            if (directory) {
                bt_CSV_Browse.enabled = true
            } else {
                bt_CSV_Browse.enabled = false
            }
        }

        // When EU Select the save converted file location
        function onCsvFileCaptured(directory) {
            tf_csv_saveLocation.text = directory

            if (directory) {
                ex_Conversion.enabled = true
            } else {
                ex_Conversion.enabled = false
            }
        }
    }

    // Emitter DN Capture
    // GLOBAL VARIABLE
    property string footmark: "Vishal bajaj, Feroz Ahmed"
    property int scaleFactor: tf_ScaleFactor.text
}







/*##^##
Designer {
    D{i:0;formeditorZoom:2}
}
##^##*/
