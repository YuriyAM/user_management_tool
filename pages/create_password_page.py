from email import message
from models.credentials import Credentials
from models.page import Page
from providers.console_provider import ConsoleProvider
import providers.database_provider as db
import inquirer

from widgets.dialogs.create_password_dialog import CreatePasswordDialog


class CreatePasswordPage(Page):

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
        CreatePasswordDialog.show()
        while(counter):
            user = CreatePasswordPage.prompt_new_password()
            if (user is None):
                print("Username ot password is incorrect!")
            elif (user.password == ""):
                return
            else:
                print("User logged in")
