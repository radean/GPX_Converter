# This Python file uses the following encoding: utf-8
import sys
import os


import numpy 
import gpxpy
import pandas as pd
import csv

# GPX_Converter
# from fbs_runtime.application_context.PyQt5 import ApplicationContext
from gpx_converter import Converter
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot, QUrl
# from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, qmlRegisterType
from PyQt5.QtWidgets import QFileDialog, QApplication, QWidget


class Grable(QWidget):

    def __init__(self):
        QWidget.__init__(self)

    
    # Setting up a signal for QMLs
    enlargeButton = pyqtSignal(str, arguments=["inst"])

    # Error Message
    errorBroadcast = pyqtSignal(str, arguments=["error"])

    # Progression Variable
    progressBar_UI = 0
    # Progress Bar Progression
    progressChange = pyqtSignal(float, arguments=["progress"])

    #GLOBAL VARIABLES
    isInvertedSpline = False
    splineScaleFactor = 1.62
    splineScaleFactor_Generic = 10000000.0

    @pyqtSlot()
    def msgPrint(self): 
        print("Connected")

    @pyqtSlot(str, float)
    def openAbout(self, footmark, scaleFactor):
        self.enlargeButton.emit(footmark)
        
        # Signaling the DCom
        print (scaleFactor)
        # Expose the Python object to QML
        # context = engine.rootContext()

    @pyqtSlot(str)
    def closeAbout(self):
        self.enlargeButton.emit("Success")
        return

    @pyqtSlot()
    def openDialog(self):
        self.openFileBrowserGPX()

    # File Browser for GPX
    # @pyqtSlot()
    # def openFileBrowserGPX(self):
    #     Files = QFileDialog.getOpenFileName(self, "Select one or more files to open", r"C:\\Users\\", "GPX Files (*.gpx *.qml)")
    
    @pyqtSlot()
    def broadcastError(self, errorMessage):
        self.errorBroadcast.emit(errorMessage)
        print ("broadcastError, Reached")
        return

    # Updating the progress Bar by hitting the Signal
    @pyqtSlot()
    def progressUpdate(self, progress):
        # increasing the progressBar_UI value
        self.progressBar_UI = self.progressBar_UI + progress
        
        # Hitting the Signal Assigned the same slot type
        self.progressChange.emit(self.progressBar_UI)

        # printing the possible outcome
        # print ("Progression, " , self.progressBar_UI)
        return


    # setting the variable methodology
    @pyqtSlot(float)
    def setScaleFactor(self, factor):
        self.splineScaleFactor = float(factor)
        print ("Setted the Scale Factor : ", self.splineScaleFactor)

    # setting the variable Inverted Spline
    @pyqtSlot(bool)
    def setIsInvertedSpline(self, isInverted):
        self.isInvertedSpline = isInverted
        print ("Inversion setted to : ", self.isInvertedSpline)


    # calculating the Multiplication for Spline track 
    def calculateFactor(self):
        factor = self.splineScaleFactor * self.splineScaleFactor_Generic
        return factor

    # calculating the Inversion Mechanism
    def calculateInversion(self):
        inversionFactor = 1.0
        if self.isInvertedSpline:
            inversionFactor = -1.0
        else:
            inversionFactor = 1.0
        return inversionFactor

# File Dialog Class
class FileDialogOpener(QWidget):

    def __init__(self):
        QWidget.__init__(self)

    # -- EVENT HANDLER --

    # GPX file event broadcaster
    gpxFileCaptured = pyqtSignal(str, arguments=["directory"])


    # CSV file event broadcaster
    csvFileCaptured = pyqtSignal(str, arguments=["directory"])

    # -- SLOTS -- 

    # File Opener
    @pyqtSlot(str, str)
    def FileOpener(self, fileType, appliedExtensions):
        if fileType == "GPX":
            capturedFile = QFileDialog.getOpenFileName(self,
                "Select " + fileType + " file",
                r"D:\\Project\\Tools-Development\\Samples\\GPX\\Fujairah.gpx",
               appliedExtensions)

            print ("GPX")
            conversion.fileGPX = capturedFile[0]
            self.gpxFileCaptured.emit(conversion.fileGPX)
        else:
            capturedFile = QFileDialog.getSaveFileName(self,
                "Save " + fileType + " file",
                r"D:\\Project\\Tools-Development\\Samples\\GPX\\Fujairah.csv",
                appliedExtensions)
            conversion.fileCSV = capturedFile[0]
            self.csvFileCaptured.emit(conversion.fileCSV)
            print ("CSV")

# GPX to CSVs
class Conversion(QObject):

    def __init__(self):
        QObject.__init__(self)


    #GLOBAL VARIABLES
    fileGPX = ''
    fileCSV = ''
     # Getting the GPX File

    # Confinig the GPX File
    def gpxtranslate(self, input_file, serial="serialNumber", position_colname="position", tangentIn_colname="tanIn", tangentOut_colname="tanOut" ):
        # Arrays Manipulation
        ser, position, tanIn, tanOut = [], [], [], []

        latitude = 0
        longitude = 0
        elevation = 0
        # Scale Factor
        scaleFactor = grable.calculateFactor()
        # Elevation sectional DBs
        elevationScaleFactor = 100
        # Spline Orientation Adjustment Notation
        inverterIndex = grable.calculateInversion()
        initialPosition = {"x":0, "y":0, "z":0}

        # Method compromission\

        with open(input_file, 'r') as gpxfile:
            # Updating the Progress
            grable.progressUpdate(0.1)
            gpx = gpxpy.parse(gpxfile)
            # print(gpx)
            lastindex = 0
            for track in gpx.tracks:
                # Updating the Progress
                grable.progressUpdate(0.1)

                # Iterating the initial Position
                for segment in track.segments:
                    grable.progressUpdate(0.1)
                    for point in segment.points:
                        initialPosition["x"] = point.latitude
                        initialPosition["y"] = point.longitude
                        initialPosition["z"] = point.elevation
                        break


                # Iterating the Position pointsa information
                for segment in track.segments:
                    grable.progressUpdate(0.1)
                    # print ("Reform", initialPosition)
                    # print ("segments", segment)
                    for point in segment.points:
                        grable.progressUpdate(0.001)
                        latitude = str(round((initialPosition["x"] - point.latitude) * scaleFactor * inverterIndex, 4))
                        longitude = str(round((initialPosition["y"] - point.longitude) * scaleFactor, 4))
                        elevation = str(round((point.elevation * elevationScaleFactor), 4))
                        ser.append(lastindex)
                        position.append( "(X="+ latitude + ",Y=" + longitude + ",Z=" + elevation + ")")
                        lastindex = lastindex + 1
                        
                    # for elevation in point.ele:
                    #     ele.append(elevation)

        grable.progressUpdate(0.18)
        return {serial: ser, position_colname: position, tangentIn_colname: position, tangentOut_colname: position}

    @pyqtSlot()
    def submittion(self):

        #Setting the GPX coords
        #transper = Converter(input_file=self.fileGPX).gpx_to_csv(output_file=self.fileCSV, 
                                                                # lats_colname="x",
                                                                # longs_colname="y",)
        
        
        transper = self.gpxtranslate(self.fileGPX, serial="s", position_colname="position", tangentIn_colname="tanIn", tangentOut_colname="tanOut")

        # info = pd.DataFrame.from_dict(transper(serial=..., lats_colname=x,
        #                                        longs_colname=y,
        #                                        elevation_colname=z))
        # print (transper)
        # DISABLED 
        # Saving the geenerated information
        self.saveCSVFile(transper)

    # Saving file
    def saveCSVFile(self, data):

        # Opening the file using native file handler
        csv_column = ["---", "Position", "InTangent", "OutTangent"]

        my_df = pd.DataFrame(data)

        #Saving the file the macronizations
        try:
            my_df.to_csv(self.fileCSV, index=False, header=csv_column)
            grable.broadcastError("Success")
        except IOError:
            grable.progressUpdate(-1)
            grable.broadcastError("Please close the csv file first")

        # Writing the flie using native file handler
        # filesave.write(info)



if __name__ == "__main__":

    # appctxt = ApplicationContext()
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    grable = Grable()

    # Dialog Methos
    fileDialogOpener = FileDialogOpener()

    # Conversion Class 
    # For Converting the data into information
    conversion = Conversion()

    # modelClass.enlargeButton.connect(lambda textion: print(textion))
    engine.rootContext().setContextProperty('grabler', grable)
    engine.rootContext().setContextProperty('fileDialogOpener', fileDialogOpener)
    engine.rootContext().setContextProperty('conversion', conversion)
    # clipped = "Clipped"
    # Registering the class for accessiblity from python
    # qmlRegisterType(Grable, 'Grabling', 1, 0, 'Grable')

    # engine.load('./main.qml')
    engine.load(QUrl('main.qml'))
    engine.load(QUrl("ui.qml"))
    engine.load(QUrl("alerts.qml"))

    # context = engine.rootContext()
    # context.setContextProperty("textion", clipped)

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
