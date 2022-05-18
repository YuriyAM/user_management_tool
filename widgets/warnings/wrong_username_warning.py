import inquirer


class WrongUsernameWarning:
    def show():
        inquirer.list_input(
            "Username must be unique",
            choices=["OK"]
        )
