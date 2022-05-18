import inquirer


class UserCreatedWarning:
    def show():
        inquirer.list_input(
            "User created",
            choices=["Back to main page"]
        )
