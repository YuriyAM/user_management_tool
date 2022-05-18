import inquirer
from models.page import Page
from models.user import User
from pages.delete_user_page import DeleteUserPage
from providers import database_provider as db
from providers.navigator import Navigator
from providers.user_provider import UserProvider
from widgets.warnings.access_denied_warning import AccessDeniedWarning
from widgets.warnings.user_edited_warning import UserEditedWarning


class EditUserPage(Page):
    def check_permissions():
        if (not UserProvider.check_permissions()):
            AccessDeniedWarning.show()
            return False
        return True

    def prompt_edit(user):
        assert isinstance(user, User), ''

        print("Username: ", user.username)
        print("Role: ", 'Admin' if user.privileged else 'User')
        print("Access:", 'Enabled' if user.enabled else 'Disabled')

        priviledgeChoice = "Remove from Admins" if user.privileged else "Add user to Admins"
        enableChoice = "Disable account" if user.enabled else "Enable account"
        choices = inquirer.checkbox(
            message='Set user parameters',
            choices=[priviledgeChoice, enableChoice]
        )
        if (priviledgeChoice in choices):
            user.privileged = not user.privileged
        if (enableChoice in choices):
            user.enabled = not user.enabled

        db.update_user(user)
        UserEditedWarning.show()

    def show(param):
        assert 'username' in param.keys(), "Missing parameter: 'username'"
        if (not DeleteUserPage.check_permissions()):
            Navigator.set_next('/home')
            return

        user = db.find_user(param['username'])
        EditUserPage.prompt_edit(user)
        Navigator.set_next('/users')
