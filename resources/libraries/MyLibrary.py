from robot.api.deco import keyword, library
from robot.api import logger
from robot.api.exceptions import Failure

ROBOT_LIBRARY_SCOPE = 'TEST'
ROBOT_LIBRARY_VERSION = '2.0'
ROBOT_AUTO_KEYWORDS = False

logger.debug("Importing library")



@keyword('Should be list')
def should_be_list(objet: any):
    """
    Check if the objet is a list.
    """
    logger.info(objet)
    if not isinstance(object, list):
        print(typeof(object))
        raise Failure("It is not a list, it is ")

@keyword('Get comma separated list as string')
def get_comma(items_list: list):
    """
    Get comma separated list as string.
    """
    comma_separated_list =  []
    for item in items_list:
        comma_separated_list += ','
        comma_separated_list += item
    
    return comma_separated_list

@keyword('Shoud be valid ISBN')
def isValidISBN(isbn):
  None
