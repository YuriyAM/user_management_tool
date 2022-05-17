import os
import inquirer
from models.page import Page
from rich.markdown import Markdown
from rich.console import Console
from providers.console_provider import ConsoleProvider

from providers.navigator import Navigator


class InfoPage(Page):

    def show_readme():
        ROOT_DIR = os.path.dirname(__file__)
        README = os.path.join(ROOT_DIR, "..\README.md")
        console = Console()
        md = Markdown("### Markdown")
        console.print(md)
        # Console.print(Markdown("#Text"))
        with open(README, 'r') as readme:
            Console().clear()
            Console().print(Markdown(readme.read()))

    def show():
        ConsoleProvider.clear()
        InfoPage.show_readme()
        choice = [
            inquirer.List(
                'goback',
                choices=["Back to page list"],
                default="Back to page list"
            )
        ]
        inquirer.prompt(choice)
        Navigator.set_next('/home')
