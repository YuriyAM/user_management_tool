from models.page import Page


class Navigator:
    routes = {}
    home = None
    next = None
    param = None

    def add_route(route, page):
        assert issubclass(page, Page), "Navigator: wrong route"
        Navigator.routes[route] = page

    def set_next(route):
        route, param = route.split("?") if "?" in route else (route, "")
        assert route in Navigator.routes.keys()
        Navigator.next = route
        Navigator.param = param

    def set_home(route):
        assert route in Navigator.routes.keys()

    def push(route):
        assert route in Navigator.routes.keys(),  "Route not found"
        Navigator.routes[route].show()

    def push_next():
        Navigator.routes[Navigator.next].show()

    def push_home():
        Navigator.routes[Navigator.home].show()
