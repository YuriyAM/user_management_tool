import inquirer


class UserEditedWarning:
    def show():
        inquirer.list_input(
            "User was sucessfully deleted",
            choices=["Back to main page"]
        )
