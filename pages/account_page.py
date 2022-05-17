from email import message
from models.credentials import Credentials
from models.page import Page
from providers.console_provider import ConsoleProvider
import providers.database_provider as db
import inquirer

from providers.navigator import Navigator


class AccountPage(Page):

    def show(param):
        assert 'username' in param.keys(), "Missing parameter: 'username'"
        ConsoleProvider.clear()
        user = db.find_user(param['username'])
        print("Username:\t", user.username)
        print("Role:\t", 'Admin' if user.privileged else 'User')

        questions = [inquirer.List(
            'ok',
            message="ok",
            choices=['Back to page list']
        )]
        inquirer.prompt(questions)
        Navigator.set_next('/home')
