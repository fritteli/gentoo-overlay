from zope.interface import implements
from twisted.python import usage
from twisted.plugin import IPlugin
from twisted.application.service import IServiceMaker

# Due to the directory layout, and the fact that plugin directories aren't
# modules (no __init__.py), this file is named something other than palaver.py,
# to ensure that this import pulls in the right module.
import palaver

class Options(usage.Options):
    optParameters = [
        ('rhost', None, None),
        ('rport', None, None),
        ('secret', None, None),
        ('backend', None, 'dir'),
        ('spool', None, None),
        ('admin', None, 1),
        ('create', None, 1),
        ('dbname', None, 'muc'),
        ('dbuser', None, 'muc'),
        ('dbhostname', None, None),
        ('log', 'l', './html/logs/'),
        ('config', 'c', 'config.xml')
    ]

    optFlags = [
        ('verbose', 'v', 'Show traffic'),
    ]

class ServiceFactory(object):
    implements(IServiceMaker, IPlugin)
    tapname = "palaver"
    description = "A multi-user chat xmpp/jabber component."
    options = Options

    def makeService(self, options):
        return palaver.makeService(options)

service = ServiceFactory()
