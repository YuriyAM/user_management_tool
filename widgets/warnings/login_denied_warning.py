import inquirer


class LoginDeniedWarning:
    def show():
        inquirer.list_input(
            "Your account is disabled. Please, contact your Administrator",
            choices=["Back to login page"]
        )
