import inquirer
import providers.database_provider as db

from models.credentials import Credentials
from models.page import Page

from providers.console_provider import ConsoleProvider
from providers.navigator import Navigator
from providers.user_provider import UserProvider


class AccountPage(Page):
    def prompt_password(user):
        password_correct = False
        while(not password_correct):
            password = inquirer.password("Enter current password")
            if db.check_credentials(Credentials(user.username, password)):
                password_correct = True
            else:
                print("Password is not correct!")

    def show():
        user = UserProvider.get_user()
        ConsoleProvider.clear()

        print("Username: ", user.username)
        print("Role: ", 'Admin' if user.privileged else 'User')

        choice = inquirer.list_input(
            "",
            choices=['Change password', 'Back to page list']
        )
        if (choice == 'Change password'):
            AccountPage.prompt_password(user)
            Navigator.push('/createpassword')
            Navigator.set_next('/home')
        elif(choice == 'Back to page list'):
            Navigator.set_next('/home')
