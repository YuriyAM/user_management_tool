# Dummy class to store current user data
from models.user import User


class UserProvider:
    CURRENT_USER = None

    def get_user():
        return UserProvider.CURRENT_USER

    def set_user(user):
        assert isinstance(user, User), "Current user has wrong data type"
        UserProvider.CURRENT_USER = user
