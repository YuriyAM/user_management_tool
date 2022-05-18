import inquirer


class AccessDeniedWarning:
    def show():
        inquirer.list_input(
            "You do not have permissions to view this page",
            choices=["Back to main page"]
        )
