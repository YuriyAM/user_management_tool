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
        assert route in Navigator.routes.keys()
        Navigator.next = route

    def set_home(route):
        assert route in Navigator.routes.keys()

    def push(route):
        route, param = route.split("?") if "?" in route else (route, None)
        assert route in Navigator.routes.keys(),  "Route not found"
        assert "=" in param if param else True, "Invalid parameter value"

        if (param):
            param = {param.split("=")[0]: param.split("=")[1]}
            Navigator.routes[route].show(param)
        else:
            Navigator.routes[route].show()

    def push_next():
        Navigator.routes[Navigator.next].show()

    def push_home():
        Navigator.routes[Navigator.home].show()
