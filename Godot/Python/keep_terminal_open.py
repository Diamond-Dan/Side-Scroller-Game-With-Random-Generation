import sys

def excepthook(type, value, traceback):
    print("An error occurred:", value)
    input("Press Enter to exit...")
    sys.__excepthook__(type, value, traceback)

sys.excepthook = excepthook