import os
from pages.account_page import AccountPage
from pages.create_password_page import CreatePasswordPage
from pages.home_page import HomePage
from pages.info_page import InfoPage
from pages.login_page import LoginPage
from pages.logout_page import LogoutPage
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
    Navigator.add_route('/home', HomePage)
    Navigator.add_route('/info', InfoPage)
    Navigator.add_route('/users', UserlistPage)
    Navigator.add_route('/account', AccountPage)
    Navigator.add_route('/logout', LogoutPage)

    Navigator.set_home('/home')
    main()
