# Dummy class to clear console screen

import os


class ConsoleProvider:
    def clear():
        print("\033[H\033[3J", end="")
        os.system('cls' if os.name == 'nt' else 'clear')
