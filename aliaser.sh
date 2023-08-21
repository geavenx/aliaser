#!/bin/bash

figlet -k aliaser
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
stop_color=$'\e[m'


if [[ $SHELL = "/bin/zsh" || $SHELL = "/usr/bin/zsh" ]]; then
  export shell="zsh"
elif [[ $SHELL = "/bin/bash" || $SHELL = "/usr/bin/bash" ]]; then
  export shell="bash"
else
  echo "Shell não identificado."
  exit
fi


helpfunc() {
  echo ""
  echo "--- MENU DE AJUDA ---"
  echo ""
  echo "Para adicionar um alias:$RED aliaser -a [nome do alias]$stop_color"
  echo "Para deletar um alias:$RED aliaser -d [nome do alias]$stop_color"
  echo "Para ver seus aliases já criados:$RED aliaser -s$stop_color"
  echo "Para atualizar um alias: $RED aliaser -u [nome do alias]$stop_color"
  echo ""
  exit 1
}


show() {
  cd ~ || exit
  if [[ ! -e ".aliases" ]]; then
    echo "--> Arquivo de aliases não encontrado... Antes de ver um alias deve-se criar um."
    helpfunc
  fi
  createdAliases=$(tail -n +2 ~/.aliases)
  echo "Seus aliases:
${createdAliases}
"
  allAliases=$(echo "$createdAliases" | awk -F'=' '{ print $1 }' | awk -F' ' '{ print $2 }')
  export allAliases
  exit 1
}


while getopts "u:a:d:sh" opt; do 
  case "$opt" in
    a) newAliasName=$OPTARG
    ;;
    d) nameToDelete=$OPTARG
    ;;
    s) show
    ;;
    h) helpfunc
    ;;
    u) nameToUpdate=$OPTARG
    ;;
    ?) helpfunc
    ;;
  esac
done


if [[ -z "$nameToDelete" ]] && [[ -z "$newAliasName" ]] && [[ -z "$nameToUpdate" ]]; then
  echo "-> Por favor, insira o nome do alias corretamente.";
  helpfunc

elif [[ $# -ne 2 ]]; then
  echo "-> Por favor, utilize somente um parâmetro por vez.";
  helpfunc
fi


addAlias() {
cd ~ || exit
if [[ ! -e ".aliases" ]]; then
  echo "# Arquivo de configuração do Aliaser" > .aliases
  echo "Arquivo de configuração de aliases criado! (~/.aliases)"
fi

if [[ $shell = "zsh" ]]; then
  conditional=$(grep "HOME/.aliases" ~/.zshrc)
  if [[ $conditional = "" ]]; then
    echo "source \$HOME/.aliases" >> ~/.zshrc
  echo "${GREEN}.aliases adicionado ao ~/.zshrc${stop_color}"
  fi

elif [[ $shell = "bash" ]]; then
  conditional=$(grep " -f .~/.aliases" ~/.bashrc)
  if [[ $conditional = "" ]]; then
    echo "if [ -f ~/.aliases ]; then
  source ~/.aliases
fi" >> ~/.bashrc
  echo "${GREEN}.aliases adicionado ao ~/.bashrc${stop_color}"
  fi
fi 

repeatedAlias=$(tail -n +2 ~/.aliases | grep "$newAliasName")
if [[ $repeatedAlias != "" ]]; then
  echo "Esse alias já existe!
  "
 exit 1 
fi

echo "Nome do alias: $1"
read -r -p "Comando a ser executado: " comando

echo "alias $1='$comando'" >> ~/.aliases
echo "-> ${GREEN}Para que as mudanças sejam efetivas feche e abra seu terminal.${stop_color}"
}


deleteAlias() {
cd ~ || exit
if [[ ! -e ".aliases" ]]; then
  echo "-> Arquivo de aliases não encontrado... Antes de deletar um alias deve-se criar um."
  helpfunc
fi
grep -v "$1" ~/.aliases > ~/temp_aliaser && mv ~/temp_aliaser ~/.aliases
echo "Alias \"$1\" removido com sucesso!"
echo "-> ${GREEN}Para que as mudanças sejam efetivas feche e abra seu terminal.${stop_color}"
}


updateAlias() {
cd ~ || exit
if [[ ! -e ".aliases" ]]; then
  echo "--> Arquivo de aliases não encontrado... Antes de atualizar um alias deve-se criar um."
  helpfunc
fi

repeatedAlias=$(tail -n +2 ~/.aliases | grep "$nameToUpdate")
if [[ -z $repeatedAlias ]]; then
  echo "Esse alias não existe!
  "
 exit 1 
fi
grep -v "$1" ~/.aliases > ~/temp_aliaser && mv ~/temp_aliaser ~/.aliases
echo "Nome do alias: $1"
read -r -p "Novo comando a ser executado: " comando
echo "alias $1='$comando'" >> ~/.aliases
echo "-> ${GREEN}Para que as mudanças sejam efetivas feche e abra seu terminal.${stop_color}"
}


if [[ -n "$newAliasName" ]] && [[ -z "$nameToDelete" ]] && [[ -z "$nameToUpdate" ]]; then
  addAlias "$newAliasName"
elif [[ -n "$nameToDelete" ]] && [[ -z "$newAliasName" ]] && [[ -z "$nameToUpdate" ]]; then
  deleteAlias "$nameToDelete"
fi
if [[ -n "$nameToUpdate" ]] && [[ -z "$newAliasName" ]] && [[ -z "$nameToDelete" ]]; then
  updateAlias "$nameToUpdate"
fi

