from robot.api.deco import keyword, library
from robot.api import logger
from robot.api.exceptions import Failure


@library
class StackLibrary:

    ROBOT_LIBRARY_SCOPE = 'TEST'
    ROBOT_LIBRARY_VERSION = '1.0'

    pointer: int
    data: list

    def __init__(self):
        self.pointer = 0
        self.data = []
        logger.info("New stack was created.")

    @keyword('Push item to Stack')
    def push(self, item: any):
        """
        Push an item at the top of the stack.
        """
        self.data.append(item)
        self.pointer += 1
        logger.info("Added " + str(item) + " to the top of the stack.")

    @keyword('Pop item from Stack')
    def pop(self):
        """
        Return and remove the item on the top of the stack.
        """
        self.should_be_not_empty()
        item = self.data.pop(self.pointer - 1)
        self.pointer -= 1
        logger.info("Item " + str(item) + " was removed.")
        return item

    @keyword('Clear stack')
    def clear(self):
        """
        Clear all items from stack.
        """
        self.data = []
        self.pointer = 0
        logger.info("Stack is now empty.")

    @keyword('Stack should be empty')
    def should_be_empty(self):
        """
        Check if stack has no item.
        """
        if len(self.data) != 0:
            raise Failure("The stack has " + str(len(self.data)) + " items.")
        
        logger.info("The stack is empty.")

    @keyword('Stack should be not empty')
    def should_be_not_empty(self):
        """
        Check if the stack has any item.
        """
        if len(self.data) == 0: 
            raise Failure("The stack is empty.")
        
        logger.info("The stack has " + str(len(self.data)) + " items.")

    @keyword('Create Stack')
    def create(self):
        """
        Creates a new instance of stack.
        """
        return StackLibrary()
