# user_management_tool

This is a command line version of **user_management_tool** written with Python.

## Dependencies

This version of **user_management_tool** requires Python 3.6 to run and uses following packages:

- [pymongo 4.1.1](https://pypi.org/project/pymongo/)
- [python-dotenv 0.20.0](https://pypi.org/project/python-dotenv/)
- [inquirer 2.9.2](https://pypi.org/project/pymongo/)
- [rich 12.4.1](https://pypi.org/project/rich/)

## How to run

1. Create MongoDB database instance with

```
docker-compose up -d
```

2. Install required dependencies with

```
pip3 install -r requirements.txt
```

3. Run application with

```
python3 main.py
```
