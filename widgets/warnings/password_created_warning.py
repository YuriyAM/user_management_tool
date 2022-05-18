import inquirer


class PasswordCreatedWarning:
    def show():
        inquirer.list_input(
            'Password is set',
            choices=['Proceed']
        )
