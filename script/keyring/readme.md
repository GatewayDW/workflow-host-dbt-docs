# keyring

[`keyring`](https://github.com/jaraco/keyring) is a package (both Python & CLI) to store and retrieve passwords from the system keyring backends.

To import credentials from `.env`, run the script `.\script\keyring\import_dotenv_to_keyring.bat`

To retrieve credentials from the system keyring via CLI:
```cmd
@REM Turn on the virtual environment
keyring get <service> <username>
```

To retrieve credentials from the system keyring via Python:
```python
import keyring
print(keyring.get_password('service', 'username'))
```
