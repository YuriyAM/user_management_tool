from email import message
from models.credentials import Credentials
from models.page import Page
import providers.database_provider as db
import inquirer


class AccountPage(Page):

    def show(param):
        ConsoleProvider.clear()
        username = param.split('=')[1]
        user = db.find_user(username)
