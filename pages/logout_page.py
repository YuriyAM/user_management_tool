import inquirer
from models.page import Page
from providers.console_provider import ConsoleProvider
from providers.navigator import Navigator


class LogoutPage(Page):
    def show():
        ConsoleProvider.clear()
        logout = inquirer.confirm(
            message="Do you want to log out?",
            default=False
        )
        if (logout == True):
            exit(0)
        elif (logout == False):
            Navigator.set_next('/home')
