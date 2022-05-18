import inquirer


class UserEditedDailog:
    def show():
        inquirer.list_input(
            "User was edited",
            choices=["Back to main page"]
        )
