from abc import ABC, abstractmethod


class Page(ABC):
    @abstractmethod
    def show(param=None):
        pass
