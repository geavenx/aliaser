# Aliaser
The Aliaser is a simple shell script designed to help you manage aliases in your shell (bash or zsh) environment. It provides a user-friendly command-line interface to add, delete, view, and update aliases quickly and efficiently.

## Usage
### Adding an Alias
To add a new alias, use the following command:

'''
aliaser -a [alias_name]
'''

You will be prompted to enter the command you want to associate with the alias.

### Deleting an Alias
To delete an existing alias, use the following command:

'''
aliaser -d [alias_name]
'''

### Viewing Your Aliases
To view the aliases you have already created, use the following command:

'''
aliaser -s
'''

### Updating an Alias
To update an existing alias, use the following command:

'''
aliaser -u [alias_name]
'''

You will be prompted to enter the new command for the alias.

### Help
If you need assistance or want to see this help message again, simply run:

'''
aliaser -h
'''

## Installation
Download the aliaser.sh script to your local machine.

Make it executable:

'''
chmod +x aliaser.sh
'''

To make the aliaser command accessible from anywhere in your shell, add an alias for it. For example, in your ~/.bashrc or ~/.zshrc file, add the following line:

'''
alias aliaser='path/to/aliaser.sh'
'''

Replace path/to/aliaser.sh with the actual path to the aliaser.sh script.

## Notes
The aliases are stored in the ~/.aliases file.
The script automatically sources the ~/.aliases file in your shell configuration (.bashrc for bash and .zshrc for zsh) to make the aliases available in your shell session.
Remember to close and reopen your terminal or run source ~/.bashrc (or source ~/.zshrc for zsh) to apply the changes after using the Aliaser.

Enjoy managing your aliases with ease!
