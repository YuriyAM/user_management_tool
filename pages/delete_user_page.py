import inquirer
import providers.database_provider as db

from models.page import Page

from providers.navigator import Navigator
from providers.user_provider import UserProvider

from widgets.warnings.access_denied_warning import AccessDeniedWarning
from widgets.warnings.user_deleted_warning import UserDeletedWarning


class DeleteUserPage(Page):
    def check_permissions():
        if (not UserProvider.check_permissions()):
            AccessDeniedWarning.show()
            return False
        return True

    def show(param):
        assert 'username' in param.keys(), "Missing parameter: 'username'"
        if (not DeleteUserPage.check_permissions()):
            Navigator.set_next('/home')
            return

        user = db.find_user(param['username'])
        action = inquirer.confirm(
            message="Delete user '{}'?".format(user.username),
            default=False
        )
        if (action == True):
            db.delete_user(user)
            UserDeletedWarning.show()

        Navigator.set_next('/home')
