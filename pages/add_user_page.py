import inquirer
from models.page import Page
from models.user import User
from providers.navigator import Navigator
from providers.user_provider import UserProvider
from providers import database_provider as db
from widgets.warnings.access_denied_warning import AccessDeniedWarning
from widgets.warnings.user_created_warning import UserCreatedWarning
from widgets.warnings.wrong_username_warning import WrongUsernameWarning


class AddUserPage(Page):
    def check_permissions():
        if (not UserProvider.check_permissions()):
            AccessDeniedWarning.show()
            return False
        return True

    def prompt_user():
        while(True):
            username = inquirer.text("Enter username")
            if (db.find_user(username)):
                WrongUsernameWarning.show()
            else:
                user = User(username)
                break

        choices = [inquirer.Checkbox(
            "param",
            message='Set user parameters',
            choices=['Make user privileged', 'Enable user']
        )]
        params = inquirer.prompt(choices)['param']
        if ('Make user privileged' in params):
            user.privileged = True
        if ('Enable user' in params):
            user.enabled = True
        db.add_user(user)

    def show():
        if (not AddUserPage.check_permissions()):
            Navigator.set_next('/home')
            return
        AddUserPage.prompt_user()
        UserCreatedWarning.show()
        Navigator.set_next('/home')
