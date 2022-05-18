from models.credentials import Credentials
from models.page import Page
from models.user import User
from providers.console_provider import ConsoleProvider
from providers.navigator import Navigator
import providers.database_provider as db
from providers.user_provider import UserProvider
import inquirer

from widgets.dialogs.login_dialog import LoginDialog
from widgets.warnings.login_denied_warning import LoginDeniedWarning


class LoginPage(Page):

    @staticmethod
    def prompt_credentials():
        questions = [
            inquirer.Text('username', message="Enter username"),
            inquirer.Password('password', message="Enter password")
        ]
        answers = inquirer.prompt(questions)

        creds = Credentials(answers['username'], answers['password'])
        return db.check_credentials(creds)

    @staticmethod
    def show():
        LoginDialog.show()
        ConsoleProvider.clear()

        successful_login = False
        while(not successful_login):
            user = LoginPage.prompt_credentials()
            if (user):
                UserProvider.set_user(user)
                successful_login = True
            else:
                print("Username ot password is incorrect!")

        if (not UserProvider.check_allowed()):
            LoginDeniedWarning.show()
            Navigator.set_next('/login')
        elif (not UserProvider.check_registered()):
            Navigator.push(
                '/createpassword?username={}'
                .format(user.username)
            )
            Navigator.set_next('/home')
        else:
            Navigator.set_next('/home')
