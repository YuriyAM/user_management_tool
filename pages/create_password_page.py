import re
import inquirer
import providers.database_provider as db

from models.page import Page
from models.user import User

from providers.console_provider import ConsoleProvider
from providers.navigator import Navigator
from providers.user_provider import UserProvider

from widgets.warnings.create_password_warning import CreatePasswordWarning
from widgets.warnings.password_complexity_warning import PasswordComplexityWarning
from widgets.warnings.password_created_warning import PasswordCreatedWarning
from widgets.warnings.password_match_warning import PasswordMatchWarning
from widgets.warnings.access_denied_warning import AccessDeniedWarning


class CreatePasswordPage(Page):

    password_regex = r'^((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()<>/|\.,]).{8,})$'

    def prompt_password(user):
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

    def show():
        user = UserProvider.get_user()
        ConsoleProvider.clear()
        CreatePasswordWarning.show()
        CreatePasswordPage.prompt_password(user)
        PasswordCreatedWarning.show()
        Navigator.set_next('/home')
