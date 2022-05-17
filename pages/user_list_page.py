import inquirer
from models.page import Page
from models.user import User
from providers import database_provider as db
from providers.navigator import Navigator


class UserlistPage(Page):
    @staticmethod
    def show():
        users = [u for u in db.get_users()]
        choices = users + ['Add new user', 'Back to page list']
        questions = [inquirer.List(
            'userlist',
            message="Choose user to edit",
            choices=choices
        )]
        answers = inquirer.prompt(questions)
        if (answers['userlist'] == 'Add new user'):
            Navigator.set_next("/adduser")
        elif(answers['userlist'] == 'Back to page list'):
            Navigator.set_next('/home')
        else:
            user = answers['userlist']
            assert isinstance(user, User)
            Navigator.set_next(
                '/account?username={0}'
                .format(answers['userlist'].username)
            )
