import inquirer


class PasswordComplexityWarning:
    def show():
        inquirer.list_input(
            "Password doesn't meet complexity requirements",
            choices=["Back"]
        )
