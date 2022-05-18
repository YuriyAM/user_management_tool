import inquirer


class CreatePasswordWarning:
    def show():
        inquirer.list_input(
            message="Please, create password",
            choices=["OK"]
        )
