import inquirer

from providers.console_provider import ConsoleProvider


class LoginDialog:
    def show():
        ConsoleProvider.clear()
        questions = [
            inquirer.List(
                'login',
                message="Login into app?",
                choices=["Login", "Exit"]
            )
        ]
        answers = inquirer.prompt(questions)
        if (answers['login'] == 'Exit'):
            exit(0)
