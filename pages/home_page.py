import inquirer
from models.page import Page
from providers.console_provider import ConsoleProvider
from providers.navigator import Navigator


class HomePage(Page):
    def show():
        ConsoleProvider.clear()
        pages = [
            inquirer.List(
                'page',
                message="Choose page",
                choices=[
                    "Account management",
                    "Users",
                    "Info page",
                    "Logout"
                ]
            )
        ]
        choice = inquirer.prompt(pages)
        if (choice['page'] == 'Account management'):
            Navigator.set_next('/account')
        elif(choice['page'] == 'Users'):
            Navigator.set_next('/users')
        elif(choice['page'] == 'Info page'):
            Navigator.set_next('/info')
        elif(choice['page'] == 'Logout'):
            Navigator.push('/logout')
