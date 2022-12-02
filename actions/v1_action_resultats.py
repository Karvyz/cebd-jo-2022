import sqlite3
from utils import display
from PyQt5.QtWidgets import QDialog
from PyQt5.QtCore import pyqtSlot
from PyQt5 import uic

# Classe permettant d'afficher la fenêtre de visualisation des données
class AppResults(QDialog):

    # Constructeur
    def __init__(self, data:sqlite3.Connection):
        super(QDialog, self).__init__()
        self.ui = uic.loadUi("gui/v1_Resultats.ui", self)
        self.data = data
        try:
            cursor = self.data.cursor()
            result = cursor.execute("SELECT DISTINCT numPA FROM Inscriptions ORDER BY numPA ASC")
            self.ui.CBPart.clear()
            self.ui.CBEpr.clear()
            for row in result:
                self.ui.CBPart.addItem(str(row[0]))
        except Exception as e:
            display.refreshLabel(self.ui.Status, "Impossible d'afficher les numéros : " + repr(e))



    @pyqtSlot()
    def RCB(self):
        try:
            cursor = self.data.cursor()
            result = cursor.execute("SELECT numEp FROM Inscriptions WHERE numPA = {} ORDER BY numEp ASC".format(
                self.ui.CBPart.currentText()
            ))
            self.ui.CBEpr.clear()
            for row in result:
                self.ui.CBEpr.addItem(str(row[0]))
            display.refreshLabel(self.ui.Status, "Succès")
        except Exception as e:
            display.refreshLabel(self.ui.Status, "Insertion impossible :possible d'afficher les numéros :  " + repr(e))

    @pyqtSlot()
    def apply(self):
        try:
            cursor = self.data.cursor()
            cursor.execute("UPDATE Inscriptions SET medaille = '{}' WHERE numPA = {} AND  numEp = {};".format(
                self.ui.CBMed.currentText(), self.ui.CBPart.currentText(), self.ui.CBEpr.currentText()
            ))
            display.refreshLabel(self.ui.Status, "Succès")
        except Exception as e:
            display.refreshLabel(self.ui.Status, "Insertion impossible : " + repr(e))