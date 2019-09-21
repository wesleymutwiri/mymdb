from config.common_settings import * 

DEBUG=True 
SECRET_KEY = 'some_ secret'

INSTALLED_APPS += [
    'debug_toolbar',
]

DATABASES['default'].update({
    'ENGINE': 'django.db.backends.sqlite3',
    'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
})

MEDIA_ROOT = os.path.join(BASE_DIR, '../media_root')

INTERNAL_IPS = [
    '127.0.0.1',
]