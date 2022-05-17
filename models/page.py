from abc import ABC, abstractmethod


class Page(ABC):
    @staticmethod
    @abstractmethod
    def show(param=None):
        pass
