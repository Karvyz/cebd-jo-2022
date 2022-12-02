import sqlite3
from utils import display
from PyQt5.QtWidgets import QDialog
from PyQt5.QtCore import pyqtSlot
from PyQt5 import uic

# Classe permettant d'afficher la fenêtre de visualisation des données
class AppInscription(QDialog):

    # Constructeur
    def __init__(self, data:sqlite3.Connection):
        super(QDialog, self).__init__()
        self.ui = uic.loadUi("gui/v1_inscription.ui", self)
        self.data = data
        try:
            cursor = self.data.cursor()
            result = cursor.execute("SELECT numPA FROM Participants ORDER BY numPA ASC")
            self.ui.CBPart.clear()
            for row in result:
                self.ui.CBPart.addItem(str(row[0]))
        except Exception as e:
            display.refreshLabel(self.ui.Status, "Impossible d'afficher les numéros des participants" + repr(e))

        try:
            cursor = self.data.cursor()
            result = cursor.execute("SELECT numEp FROM Epreuves ORDER BY numEp ASC")
            self.ui.CBEpr.clear()
            for row in result:
                self.ui.CBEpr.addItem(str(row[0]))
                
        except Exception as e:
            display.refreshLabel(self.ui.Status, "Impossible d'afficher les numéros des épreuves" + repr(e))

    @pyqtSlot()
    def insert(self):
        try:
            cursor = self.data.cursor()
            cursor.execute("INSERT INTO Inscriptions VALUES ({},{},null)".format(
                self.ui.CBPart.currentText(), self.ui.CBPart.currentText()
            ))
            display.refreshLabel(self.ui.Status, "Succès")
        except Exception as e:
            display.refreshLabel(self.ui.Status, "Insertion impossible : " + repr(e))

    @pyqtSlot()
    def suppr(self):
        try:
            cursor = self.data.cursor()
            cursor.execute("DELETE FROM Inscriptions WHERE numPA = {} AND numEp = {}".format(
                self.ui.CBPart.currentText(), self.ui.CBPart.currentText()
            ))
            display.refreshLabel(self.ui.Status, "Succès")
        except Exception as e:
            display.refreshLabel(self.ui.Status, "Insertion impossible : " + repr(e))
