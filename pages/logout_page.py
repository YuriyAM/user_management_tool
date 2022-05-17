import inquirer
from models.page import Page
from providers.console_provider import ConsoleProvider
from providers.navigator import Navigator


class LogoutPage(Page):
    def show():
        ConsoleProvider.clear()
        questions = [
            inquirer.List(
                'logout',
                message="Do you want to log out?",
                choices=["Yes", "No"]
            )
        ]
        answers = inquirer.prompt(questions)
        if (answers['logout'] == 'Yes'):
            exit(0)
        elif (answers['logout'] == 'No'):
            Navigator.set_next('/home')
