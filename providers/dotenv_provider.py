import os
from dotenv import dotenv_values

ROOT_DIR = os.path.dirname(__file__)
CONFIG = dotenv_values(os.path.join(ROOT_DIR, "..\.env"))
