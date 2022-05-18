import os
from pages.account_page import AccountPage
from pages.add_user_page import AddUserPage
from pages.create_password_page import CreatePasswordPage
from pages.delete_user_page import DeleteUserPage
from pages.edit_user_page import EditUserPage
from pages.home_page import HomePage
from pages.info_page import InfoPage
from pages.login_page import LoginPage
from pages.logout_page import LogoutPage
from pages.view_user_page import ViewUserPage
from providers.navigator import Navigator
from pages.user_list_page import UserlistPage
import providers.database_provider as db


def main():
    Navigator.push('/login')
    while(True):
        Navigator.push_next()


if __name__ == "__main__":
    db.init()
    Navigator.add_route('/login', LoginPage)
    Navigator.add_route('/createpassword', CreatePasswordPage)
    Navigator.add_route('/viewuser', ViewUserPage)
    Navigator.add_route('/adduser', AddUserPage)
    Navigator.add_route('/edituser', EditUserPage)
    Navigator.add_route('/deleteuser', DeleteUserPage)
    Navigator.add_route('/home', HomePage)
    Navigator.add_route('/info', InfoPage)
    Navigator.add_route('/users', UserlistPage)
    Navigator.add_route('/account', AccountPage)
    Navigator.add_route('/logout', LogoutPage)

    Navigator.set_home('/home')
    main()
