import inquirer


class CreatePasswordDialog:
    def show():
        questions = [
            inquirer.List(
                'new_password',
                message="Please, create password",
                choices=["OK"]
            )
        ]
        inquirer.prompt(questions)
