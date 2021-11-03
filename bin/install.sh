#!/usr/bin/env bash

SCRIPTPATH=$(dirname "$BASH_SOURCE")

if [[ $SCRIPTPATH == "." ]]; then
    cd ../
fi

echo "Criando .env a partir do .env.example"
cp ./.env.example ./.env

echo "OK!"

if [[ "$OSTYPE" != "win32" ]]; then
    echo "Informe a senha do seu computador:"

    sudo chmod +x ./bin/compose
fi

echo "Iniciando instalação.."
./bin/compose up -d && \
./bin/compose exec php composer install && \
./bin/compose exec php php artisan key:generate && \
./bin/compose exec php php artisan migrate:fresh --seed && \
./bin/compose run node npm install && \
./bin/compose run node npm run dev && \
echo "Instalado com sucesso!";
