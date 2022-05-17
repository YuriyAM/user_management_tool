from email import message
from models.credentials import Credentials
from models.page import Page
import providers.database_provider as db
import inquirer


class CreatePasswordPage(Page):

    @staticmethod
    def prompt_dialog():
        questions = [
            inquirer.List(
                'new_password',
                message="Please, create password",
                choices=["OK"]
            )
        ]
        answers = inquirer.prompt(questions)

    @staticmethod
    def prompt_new_password():
        questions = [
            inquirer.Text('new_password', message="Enter new password"),
            inquirer.Password('new_password_confirm',
                              message="Confirm password")
        ]
        answers = inquirer.prompt(questions)

        creds = Credentials(answers['username'], answers['password'])
        return db.check_credentials(creds)

    @staticmethod
    def show():
        ConsoleProvider.clear()
        counter = 3
        prompt_dialog()
        while(counter):
            user = prompt_new_password()
            if (user is None):
                print("Username ot password is incorrect!")
            elif (user.password == ""):
                return
            else:
                print("User logged in")
