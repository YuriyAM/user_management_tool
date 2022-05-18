from inspect import cleandoc
import inquirer
from models.page import Page
from models.user import User
from providers import database_provider as db
from providers.console_provider import ConsoleProvider
from providers.navigator import Navigator
from providers.user_provider import UserProvider
from widgets.warnings.access_denied_warning import AccessDeniedWarning


class ViewUserPage(Page):
    def check_permissions():
        if (not UserProvider.check_permissions()):
            AccessDeniedWarning.show()
            return False
        return True

    def show(param):
        assert 'username' in param.keys(), "Missing parameter: 'username'"
        if (not ViewUserPage.check_permissions()):
            Navigator.set_next('/home')
            return

        ConsoleProvider.clear()
        user = db.find_user(param['username'])
        print("Username: ", user.username)
        print("Role: ", 'Admin' if user.privileged else 'User')

        choice = inquirer.list_input(
            message="",
            choices=['Edit user', 'Delete user', 'Back to page list']
        )
        if (choice == 'Edit user'):
            Navigator.set_next('/edituser?username={}'.format(user.username))
        if (choice == 'Delete user'):
            Navigator.set_next('/deleteuser?username={}'.format(user.username))
        elif (choice == 'Back to page list'):
            Navigator.set_next('/home')
