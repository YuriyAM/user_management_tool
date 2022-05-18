import re
from models.page import Page
from models.user import User
from providers.console_provider import ConsoleProvider
import providers.database_provider as db
import inquirer
from providers.navigator import Navigator
from providers.user_provider import UserProvider

from widgets.warnings.create_password_warning import CreatePasswordWarning
from widgets.warnings.password_complexity_warning import PasswordComplexityWarning
from widgets.warnings.password_created_warning import PasswordCreatedWarning
from widgets.warnings.password_match_warning import PasswordMatchWarning
from widgets.warnings.access_denied_warning import AccessDeniedWarning


class CreatePasswordPage(Page):

    password_regex = r'^((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()<>/|\.,]).{8,})$'

    def check_permissions(user):
        if (UserProvider.get_user().username != user.username):
            AccessDeniedWarning.show()
            return False
        return True

    def prompt_new_password(user):
        assert isinstance(user, User), 'Argument of wrong type!'
        password_isset = False
        while(not password_isset):
            new_password = inquirer.password(message="Enter new password")
            if (not re.match(CreatePasswordPage.password_regex, new_password)):
                PasswordComplexityWarning.show()
                continue

            confirm_password = inquirer.password(message="Confirm password")
            if (confirm_password != new_password):
                PasswordMatchWarning.show()
                continue
            user.password = new_password
            password_isset = True
        db.update_user(user)

    def show(param):
        assert 'username' in param.keys(), "Missing parameter: 'username'"
        user = db.find_user(param['username'])
        if (not CreatePasswordPage.check_permissions(user)):
            Navigator.set_next('/login')
            return

        ConsoleProvider.clear()
        CreatePasswordWarning.show()
        CreatePasswordPage.prompt_new_password(user)
        PasswordCreatedWarning.show()
        Navigator.set_next('/home')
