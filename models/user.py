class User:
    def __init__(self, username, password='', privileged=False, enabled=True):
        self.username = username
        self.password = password
        self.privileged = privileged
        self.enabled = enabled

    @classmethod
    def fromJson(cls, json):
        assert isinstance(json, dict), 'Argument of wrong type!'
        return cls(
            username=json['username'],
            password=json['password'],
            privileged=json['privileged'],
            enabled=json['enabled']
        )

    def __str__(self):
        return "({0}) {1}".format('Admin' if self.privileged else 'User', self.username)
