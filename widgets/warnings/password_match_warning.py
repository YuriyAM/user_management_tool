import inquirer


class PasswordMatchWarning:
    def show():
        inquirer.list_input(
            "Passwords do not match",
            choices=["Back"]
        )
