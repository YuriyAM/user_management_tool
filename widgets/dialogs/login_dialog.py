import inquirer

from providers.console_provider import ConsoleProvider


class LoginDialog:
    def show():
        ConsoleProvider.clear()
        choice = inquirer.list_input(
            message="Login into app?",
            choices=["Login", "Exit"]
        )
        if (choice == 'Exit'):
            exit(0)
