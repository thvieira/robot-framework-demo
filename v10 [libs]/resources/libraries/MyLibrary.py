from robot.api.deco import keyword, library
from robot.api import logger

ROBOT_LIBRARY_SCOPE = 'TEST'
ROBOT_LIBRARY_VERSION = '2.0'
ROBOT_AUTO_KEYWORDS = False

logger.debug("Importing library")

@keyword('Diga oi')
def send_message(message):
    """
    Keyword documentation
    """
    logger.info(message)
    print(message)
