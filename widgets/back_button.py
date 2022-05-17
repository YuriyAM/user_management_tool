import inquirer


class BackButton:
    def show():
        questions = [
            inquirer.List(
                'goback',
                choices=["Back to page list"],
                default="Back to page list"
            )
        ]
        inquirer.prompt(questions)
