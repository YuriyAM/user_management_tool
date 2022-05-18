import inquirer

from providers.console_provider import ConsoleProvider


class LogoutDialog:
    def show():
        ConsoleProvider.clear()
        choice = inquirer.list_input(
            "Do you want to log out?",
            choices=['Yes', 'No']
        )
        if (choice == 'Yes'):
            exit(0)
