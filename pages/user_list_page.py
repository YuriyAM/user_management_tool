import inquirer
from models.page import Page
from models.user import User
from providers import database_provider as db
from providers.console_provider import ConsoleProvider
from providers.navigator import Navigator
from providers.user_provider import UserProvider


class UserlistPage(Page):
    @staticmethod
    def show():
        ConsoleProvider.clear()
        user_list = [u for u in db.get_users()]
        if (UserProvider.check_permissions()):
            user_list += ['Add new user']
        prompt_list = user_list + ['Back to page list']

        choice = inquirer.list_input(
            message="Choose user to edit",
            choices=prompt_list
        )
        if (choice == 'Add new user'):
            Navigator.set_next("/adduser")
        elif(choice == 'Back to page list'):
            Navigator.set_next('/home')
        else:
            assert isinstance(choice, User)
            Navigator.set_next(
                '/viewuser?username={0}'
                .format(choice.username)
            )
